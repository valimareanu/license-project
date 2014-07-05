<?php 

final class Shop {

    private static $_instance;
    private $db = null;
    private $_cart = null;

    private function __construct(&$dbc) { 
        $this->db = $dbc;
        $this->_init();
    }

    private final function __clone() { }

    public static function getInstance(&$dbc) {
        if(self::$_instance === null) {
            self::$_instance = new Shop($dbc);
        }
        return self::$_instance;
    }

    private function _init(){
        $sid = $this->db->escape(session_id());
        $sql = "SELECT cart.*, f.name, f.price, f.picture FROM cart LEFT JOIN filme as f ON(f.id = cart.filme_id) WHERE session_id = '" . $sid . "'";
        if(isset($_SESSION['id']) && is_numeric($_SESSION['id'])) {
            $sql .= " OR ( user_id = " . intval($_SESSION['user_id']) . " AND user_id != 0 )";
        }
    	$query = $this->db->query($sql);
        if($query->num_rows){
            $this->_cart = $query->rows;
        } else {
            $this->_cart = array( );
        }
    }

    // adauga in cart un produs
    public function addToCart($pid){
        if(!is_numeric($pid)){
            return false;
        } else {
            $pname = $this->db->query("SELECT name FROM filme WHERE id={$pid} LIMIT 1")->rows[0];
        }
        if(isset($_SESSION['user_id'])){
            $uid = intval($_SESSION['user_id']);
        } else {
            $uid = 0;
        }
        $sid = $this->db->escape(session_id());
        $qty = $this->db->query("SELECT * FROM cart WHERE filme_id=".intval($pid)." AND session_id='".$sid."' LIMIT 1")->rows;
        if(!empty($qty)) {
             $this->db->query("UPDATE cart SET qty=qty+1 WHERE filme_id=".intval($pid)." AND session_id='".$sid."'");
        } else {
            $this->db->query("INSERT INTO cart(filme_id, film_name, session_id, user_id) VALUES( ".intval($pid).", '".$pname['name']."', '".$sid."', ".$uid.")");
        }
        $this->_init(); // refresh cart
    }

    // incrementeaza cantitatea produsului cu 1
    public function addQty($cartItemId){
        if(!intval($cartItemId) && !is_numeric($cartItemId)){
            return false;
        }
        $sid = $this->db->escape(session_id());
        if(isset($sid)) {
            $sql = "UPDATE cart SET qty=qty+1 WHERE id = ".intval($cartItemId)." AND session_id = '" . $sid . "'";
        } else {
            return false;
        }
        $this->db->query($sql);
        $this->_init(); // refresh cart
        if($this->db->countAffected()){
            return true;
        }
        return false;
    }

    // schimba statusul de la tabelul order
    public function changeStatus($id, $status) {
        $order_check = $this->db->query("SELECT * FROM orders WHERE id={$id}")->rows;
        if(!empty($order_check)) {
            $this->db->query("UPDATE orders SET status='{$status}' WHERE id={$id}");
            return true;
        } else {
            return false;
        }
    }

    // schimba stocul adauga in stock daca comanda a fost anulata
    public function changeStock($film_id, $op_qty) {
        if(isset($film_id) && isset($op_qty)) {
            $this->db->query("UPDATE filme SET stoc=stoc+{$op_qty} WHERE id={$film_id}");
        }
    }

    // scoate toate produsele din cart
    public function emptyCart(){
        $sid = $this->db->escape(session_id());
        if(isset($_SESSION['id']) && is_numeric($_SESSION['id'])) {
            $sql = "DELETE FROM cart WHERE session_id = '" . $sid . "' OR (user_id = " . intval($_SESSION['user_id']) . " AND user_id != 0)";
        } else {
            $sql = "DELETE FROM cart WHERE session_id = '" . $sid . "'";
        }
        $this->db->query($sql);
        $this->_init(); // refresh cart
    }

    // selecteaza produsele care au fost introduse in cart
    public function getCart(){
        return $this->_cart;
    }

    // preia toate comenzile din baza de date
    public function getOrders($offset, $per_page) {
        $sql = "SELECT o.*, o_P.id AS o_p_id, o_p.filme_id, o_p.film_name, o_p.qty, o_p.price FROM orders AS o
                    INNER JOIN order_product AS o_p
                    ON o.id=o_p.order_id ORDER BY o.add_date DESC LIMIT {$offset}, {$per_page}";
        return $this->db->query($sql)->rows;
    }

    // preia toate comenzile pe care le-a plasat un utilizator
    public function getOrdersByUserId($uid){
        $sql = "SELECT orders.*, OP.order_id, OP.filme_id, OP.price, OP.qty, F.film_id, F.film_name, F.film_picture FROM orders 
            CROSS JOIN (SELECT order_id, filme_id, price, qty FROM order_product) as OP ON(orders.id = OP.order_id ) 
            LEFT JOIN (SELECT id as film_id, name as film_name, picture as film_picture FROM filme) as F ON(F.film_id = OP.filme_id)                
            WHERE user_id = " . intval($uid) . " ORDER BY add_date DESC";
        $query = $this->db->query($sql);
        if(!$query->num_rows){
            return array( );
        }
        $orders = array( );
        $order_id = 0;
        $order_index = -1;
        foreach ($query->rows as $row) {
            if($order_id != $row['order_id']){
                $order_index++;
                $order_id = $row['order_id'];
                $orders[$order_index] = array(
                    'user_id' => $row['user_id'],
                    'order_id' => $row['order_id'],
                    'full_name' => $row['full_name'],
                    'address' => $row['address'],
                    'telephone' => $row['telephone'],
                    'billing_details' => $row['billing_details'],
                    'add_date' => $row['add_date'],
                    'status' => $row['status'],
                    'payment_method' => $row['payment_method'],
                    'shipping_method' => $row['shipping_method'],
                    'products' => array(0 => array(
                        'id' =>  $row['film_id'],
                        'name' =>  $row['film_name'],
                        'picture' =>  $row['film_picture']
                        )),
                    'total' => $row['price'] * $row['qty']
                    );
            } else {
                $orders[$order_index]['total'] += $row['price'] * $row['qty'];
                $orders[$order_index]['products'][] = array(
                        'id' =>  $row['id'],
                        'name' =>  $row['name'],
                        'picture' =>  $row['picture']
                    );
            }
        }
        return $orders;
    }

    // verifica daca este in cart un produs
    public function isInCart($pid){
        if(!intval($pid) && !is_numeric($pid)){
            return false;
        }
        $sid = $this->db->escape(session_id());
        if(isset($_SESSION['id']) && is_numeric($_SESSION['id'])) {
            $sql = "SELECT * FROM cart WHERE filme_id = " . intval($pid) . " AND (session_id = '" . $sid . "' OR (user_id = " . intval($_SESSION['user_id']) . " AND user_id != 0)) LIMIT 1";
        } else {
            $sql = "SELECT * FROM cart WHERE filme_id = " . intval($pid) . " AND session_id = '" . $sid . "' LIMIT 1";
        }
        $query = $this->db->query($sql);
        if($query->num_rows){
            return true;
        }
        return false;
    }

    // scoate din cart produsul selectat
    public function removeFromCart($cartItemId){
        if(!intval($cartItemId) && !is_numeric($cartItemId)){
            return false;
        }
        $sid = $this->db->escape(session_id());
        if(isset($_SESSION['id']) && is_numeric($_SESSION['id'])) {
            $sql = "DELETE FROM cart WHERE id = ".intval($cartItemId)." AND (session_id = '" . $sid . "' OR (user_id = " . intval($_SESSION['user_id']) . " AND user_id != 0))";
        } else {
            $sql = "DELETE FROM cart WHERE id = ".intval($cartItemId)." AND session_id = '" . $sid . "'";
        }
        $this->db->query($sql);
        $this->_init(); // refresh cart
        if($this->db->countAffected()){
            return true;
        }
        return false;
    }

    // decrementeaza de la cantitatea produsului cu 1
    public function removeQty($cartItemId){
        if(!intval($cartItemId) && !is_numeric($cartItemId)){
            return false;
        }
         $sid = $this->db->escape(session_id());
        if($sid) {
            $sql = "UPDATE cart SET qty=qty-1 WHERE id = ".intval($cartItemId)." AND session_id = '" . $sid . "'";
        } else {
            return false;
        }
        $this->db->query($sql);
        $this->_init(); // refresh cart
        if($this->db->countAffected()){
            return true;
        }
        return false;
    }

}
