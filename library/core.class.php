<?php 

final class Core {

    private static $_instance;
    private $output;

    public $db;
    public $template;
    public $data = array( );

    private function __construct() {
        session_start();
    	$this->_initHeaders();
        $this->_initDb();
    }

    private final function __clone() { }

    public static function getInstance() {
        if(self::$_instance === null) {
            self::$_instance = new Core();
        }
        return self::$_instance;
    }

    private function _initHeaders(){
    	header("Content-Type: text/html; charset=UTF-8");
    }

    private function _initDb(){
    	require("./library/db.class.php");
    	if(defined("db_port")) 
    		$this->db = new DB(db_driver, db_hostname, db_user, db_pass, db_database, db_port);
    	else 
    		$this->db = new DB(db_driver, db_hostname, db_user, db_pass, db_database);
    }

    // functie care trimite mail
    public function php_mail($reciever_email, $subject, $mail_body) {
        $mail = new PHPMailer();
        $mail->IsSMTP();
        $mail->Host = "smtp.gmail.com";
        $mail->SMTPSecure = 'tls';
        $mail->Port = 25;
        $mail->SMTPAuth = true;
        $mail->Username = "valimareanu16@gmail.com";
        $mail->Password = "Valimar3anu";

        $mail->FromName = "YourCinema";
        $mail->From = "valimareanu16@gmail.com";
        $mail->AddAddress($reciever_email);
        $mail->Subject = $subject;
        $data = date("dd-mm-YYYY");
        $mail->Body = $mail_body;
        $mail->AltBody = "This mail was sent from YourCinema team. Something wrong happened if you see this message. Please inform our administrator as soon as you can on this E-mail address:".administrator_email;     //Plain Text Body
        $check = $mail->Send();
        if($check) {
            return true;
        } else {
            return false;
        }
    }

    public function render(){		
		if (file_exists(SITE_PATH . "template/views/" . $this->template . ".tpl")) {
            global $shop;
            global $user;
            global $catalog;
            $this->data['_cart'] = $shop->getCart();
            $this->data['_isLogged'] = $user->isLogged();     
            $this->data['_isAdmin'] = $user->isAdmin();
            if($this->data['_isLogged']){
                $userData = $user->getData();
                //$this->data['_friendlyUserName'] = $userData['email'];
                $this->data['_id'] = $userData['id'];
            }
			extract($this->data);			
      		ob_start();      
	  		require(SITE_PATH . "template/views/" . $this->template . ".tpl");
	  		$this->output = ob_get_contents();
      		ob_end_clean();      		
			return $this->output;
    	} else {
			trigger_error('Error: Could not load template: ' . $this->template . '!');
			exit();				
    	}
    }

}