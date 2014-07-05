<?php 

final class User {

    private static $_instance;
    private $db = null;
    private $_data = null;
    private $_is_logged = false;
    private $_is_admin = false;

    private function __construct(&$dbc) { 
        $this->db = $dbc;
        $this->_init();
    }

    private final function __clone() { }

    public static function getInstance(&$dbc) {
        if(self::$_instance === null) {
            self::$_instance = new User($dbc);
        }
        return self::$_instance;
    }

    private function _init(){        
        if(isset($_SESSION['user_id'])){
            $query = $this->db->query("SELECT * FROM users WHERE id = " . intval($_SESSION['user_id']));
            if($query->num_rows){
                $user = $query->rows[0];
                if($user['status']=="activated"){
                    $this->_data = $user;
                    $this->_is_logged = true;
                    if($user['user_a']) $this->_is_admin = true;
                }
            }
        }
    }

    // activeaza contul 
    public function activateAccount($email, $token){
        $user = $this->db->query("SELECT email, code, id, status FROM users WHERE email LIKE '" . $this->db->escape($email) . "' LIMIT 1")->rows[0];
        $num_rows = $this->db->query("SELECT id FROM users WHERE email LIKE '" . $this->db->escape($email) . "'")->num_rows;
        if($num_rows == 0){
            return 0;
        }
        switch ($user['status']) {
            case 'activated':
                return 0;
                break;
            case 'disabled':
                return -1;
                break;
            case 'pending':
                if($user['code'] == $token){
                    $this->db->query("UPDATE users SET status = 'activated' WHERE id = ".intval($user['id']));
                    return 1;
                } else {
                    return -2;
                }
                break;
            default:
                return -3;
                break;
        }
    }

    // schimba parola utilizatorului
    public function changePassword($newPassword){
        if(!$this->isLogged()){
            return false;
        }
        $this->db->query("UPDATE users SET password = '".md5($newPassword)."' WHERE email LIKE '".$this->db->escape($this->_data['email'])."' LIMIT 1");
        if($this->db->countAffected()){
            return true;
        }
        return false;
    }

    // schimba statusul de la tabelul users
    public function changeStatus($id, $status) {
        $user_check = $this->db->query("SELECT * FROM users WHERE id={$id}")->rows;
        if(!empty($user_check)) {
            $this->db->query("UPDATE users SET status='{$status}' WHERE id={$id}");
            return true;
        } else {
            return false;
        }
    }

    // genereaza un token cu caractere luate din $charset de lungime default 6
    public function generateToken($len = 6){
        $charset = "1234567890abcdefghijklmnopqrstuvwxyz";
        $token = "";
        for ($i=0; $i<$len; $i++) {
            $token .= $charset[(mt_rand(0,(strlen($charset)-1)))];            
        }
        return $token;
    }

    // preia datele utilizatorului logat
    public function getData(){
        $data = $this->_data;
        //unset($data['password']); 
        return $data;
    }

    // preia datele utilizatorului din tabelul user_details care contine nr de telefon, adresa, etc
    public function getPersonalData(){
        if(!isset($this->_data['id'])){
            return null;
        }
        $query = $this->db->query("SELECT * FROM user_details WHERE user_id = ".intval($this->_data['id'])." LIMIT 1");
        if($query->num_rows == 1){
            return $query->rows[0];
        }
        return null;
    }

    // verifica daca emailul este deja introdus in baza de date si intoarce true daca da
    public function isEmailTaken($email){
        $query = $this->db->query("SELECT * FROM users WHERE email LIKE '" . $this->db->escape($email) . "' LIMIT 1");
        if($query->num_rows){
            return true;
        }
        return false;
    }

    // intoarce true daca utilizatorul este administrator sau false daca nu nu
    public function isAdmin(){
        return $this->_is_admin;
    }

    // intoarce true daca utilizatorul este logat sau false daca nu nu
    public function isLogged(){
        return $this->_is_logged;
    }

    // autentifica utilizatorul
    public function login($username, $password){
        if(strlen(trim($username)) < 6 || strlen($password) < 6){
            return false;
        }
        $query = $this->db->query("SELECT * FROM users WHERE username LIKE '" . $this->db->escape(trim($username)) . "' AND password = '" . md5($password) . "' LIMIT 1");
        if($query->num_rows == 0){
            return false;
        } 
        $row = $query->rows[0];
        if($row['status'] == "activated") {
            $_SESSION['user_id'] = $row['id'];
            $_SESSION['username'] = $row['username'];
            $this->_data = $row;
            $this->_is_logged = true;
            return true;
        }
        return $row['status'];
    }

    // delogeaza utilizatorul
    public function logout(){
        unset($_SESSION['user_id']);
        unset($_SESSION['username']);
        $this->_is_logged = false;
        $this->_is_admin = false;
        $this->_data = null;
    }

    // insereaza in tabelul users datele utilizatorului
    public function register($username, $password, $first_name, $last_name, $email, $picture="all.jpg", $bio="", $status, $code = null, $add_date){
        if($code == null) {
            $code = $this->generateToken(6);
        }
        $this->db->query("INSERT INTO users (username, password, first_name, last_name, email, picture, bio, status, code, created) 
                            VALUES ('".$this->db->escape($username)."', '".md5($password)."', '".$this->db->escape($first_name)."', 
                                '".$this->db->escape($last_name)."', '".$this->db->escape($email)."', '".$this->db->escape($picture)."', 
                                '".$this->db->escape($bio)."', '".$this->db->escape($status)."', '".$this->db->escape($code)."', '".$this->db->escape($add_date)."')");
        if($this->db->countAffected()){
            return $this->db->getLastId();
        } else {
            return false;
        }
    }

    // reseteaza parola unui utilizator daca cumva acesta a uitat-o generand o parola temporara de lungime 8
    public function resetPassword($email){
        $data = array( 
            'new_password' => $this->generateToken(8)
            );
        $this->db->query("UPDATE users SET password = '".md5($data['new_password'])."' WHERE email LIKE '".$this->db->escape($email)."' LIMIT 1");
        if($this->db->countAffected()){
            return $data;
        }
        return false;
    }

    // introduce in tabelul user_details datele personale ale utilizatorului
    public function setPersonalData($input){
        if(!isset($this->_data['user_id'])){
            return null;
        }
        if($this->getPersonalData() == null) {
            $sql = "INSERT INTO user_details (person_type, full_name, company, commercial_register_number, tax_identification_number, telefon, adress, city, country, user_id) VALUES (
                ".intval($this->_data['person_type']).",
                '".$this->db->escape($input['full_name'])."',
                '".$this->db->escape($input['company'])."',
                '".$this->db->escape($input['commercial_register_number'])."',
                '".$this->db->escape($input['tax_identification_number'])."',
                '".$this->db->escape($input['telefon'])."',
                '".$this->db->escape($input['adress'])."',
                '".$this->db->escape($input['city'])."',
                '".$this->db->escape($input['country'])."',
                '".$this->db->escape($input['user_id'])."'
                )";
        } else {
            $sql = "UPDATE user_details SET 
                person_type = '".$this->db->escape($input['person_type'])."', 
                full_name     = '".$this->db->escape($input['full_name'])."', 
                company     = '".$this->db->escape($input['company'])."', 
                commercial_register_number   = '".$this->db->escape($input['commercial_register_number'])."', 
                tax_identification_number          = '".$this->db->escape($input['tax_identification_number'])."', 
                telefon      = '".$this->db->escape($input['telefon'])."', 
                adress       = '".$this->db->escape($input['adress'])."', 
                city   = '".$this->db->escape($input['city'])."', 
                country        = '".$this->db->escape($input['country'])."' 
                WHERE user_id = " . intval($this->_data['user_id']) . " LIMIT 1"; 
        }
        $this->db->query($sql);
        if($this->db->countAffected()){
            return true;
        }
        return false;
    }

    // uploadeaza poza utilizatorului pe server, intai verificand daca are extensia unei poze si nu e ste mai mare de 2Mb
    public function uploadUserPhoto($file) {
        $_FILES['file'] = $file;
        $allowedExts = array("gif", "jpeg", "jpg", "png");
        $temp = explode(".", $_FILES['file']["name"]);
        $extension = end($temp);
        $message = "";

        if ((($_FILES['file']['type'] == "image/gif")
            || ($_FILES['file']['type'] == "image/jpeg")
            || ($_FILES['file']['type'] == "image/jpg")
            || ($_FILES['file']['type'] == "image/pjpeg")
            || ($_FILES['file']['type'] == "image/x-png")
            || ($_FILES['file']['type'] == "image/png"))
            && ($_FILES['file']['size'] < 2000000)
            && in_array($extension, $allowedExts)) {
            if ($_FILES['file']['error'] > 0) {
                $message = $_FILES['file']['error'];
            } else {
                if (file_exists(SITE_PATH."assets\\" . $_FILES['file']['name'])) {
                    $message = $_FILES['file']['name'] . " already exists.";
                } else {
                    if(move_uploaded_file($_FILES['file']['tmp_name'],SITE_PATH."assets\\" . $_FILES['file']['name'])) {
                        $message = "OK";
                    }
                }
            }
        } else {
           $message = "Invalid file.";
        }
    return $message;
    }

    // verifica daca emailul utilizatorului este valid
    public function validateEmail($email){
        // check format
        if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
            return false;
        }
        // check domain existance
        $email = explode("@", $email);
        if(!checkdnsrr($email[1])){
            return false;
        }
        return true;
    }

    // verifica daca lungimea parolei este mai mare de 6
    public function validatePassword($password){
        if(strlen($password) < 6){
            return false;
        }
        return true;
    }
}

