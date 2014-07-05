<?php
require("./library/boot.php");
$core->template = "test";

	
	//$core->db->query("UPDATE users SET username='" . $_POST['username'] . "', password='" . md5($_POST['password']) . "' WHERE id=66");

	/*$to = "daemon_vali@yahoo.com";
	$subject = "Account activation";
	$message = 'hello';
	$headers = 'From: webmaster@example.com' . "\r\n" .
    'Reply-To: webmaster@example.com' . "\r\n" .
    'X-Mailer: PHP/' . phpversion();

	$sent = mail($to, $subject, $message, $headers);
	if($sent) {
		echo("s-a trimis");
	} else {
		echo("nu s-a trimis");
	}*/

	/*
	if(isset($_POST['submit_s'])) {
		$q = $core->db->query("SELECT * FROM filme WHERE name LIKE '" . $_POST['search'] . "' LIMIT 1")->rows;
		$core->data['search_q'] = $q;
	}*/
	/*
	$text = "bla, bla, bla, AND ";
	$newText = substr($text, 0, -6);
	echo $newText;
	*/
	/*
	$sid = $core->db->escape(session_id());
	echo $sid;
	*/
	/*
	echo $_FILES['file']['name'] . "<h2>Aici</h2>";
	if($user->uploadUserPhoto($_FILES['file']) != "OK") {
		$_SESSION['message'] = $user->uploadUserPhoto($_FILES['file']);
		echo "<h2>".$_SESSION['message']."</h2>";
	}*/
	//echo $_SERVER['REMOTE_ADDR']; // ::1
	/*
	if (!empty($_SERVER['HTTP_CLIENT_IP'])) {
    	$ip = $_SERVER['HTTP_CLIENT_IP'];
	} elseif (!empty($_SERVER['HTTP_X_FORWARDED_FOR'])) {
   		$ip = $_SERVER['HTTP_X_FORWARDED_FOR'];
	} else {
    	$ip = $_SERVER['REMOTE_ADDR'];
	}
	$_SESSION['message'] = $ip;
	*/
	/*
	$movie_date = $core->db->query("SELECT movie_date FROM filme WHERE id=5")->rows[0];
	if(date('dd-mm-YYYY') <= date('dd-mm-YYYY', strtotime($movie_date['movie_date']))) {
		print_r($movie_date['movie_date']);
	}*/

	//$core->log_action("r","","comments");
	//echo nl2br($core->data['log_comments']);

	/*$reciever_email = "daemon_vali@yahoo.com";
	$subject = "Test";
	$mail_body = "This is a test mail";
	if(!$core->php_mail($reciever_email, $subject, $mail_body)) {
		echo "Mail could not be sent. Please contact our administrator on this email: ".administrator_email;
	}*/
	/*
	$query = $core->db->query("SELECT * FROM trailer WHERE id=2")->rows[0];
	$url = $query['trailer'];
	$part_one_cde = explode("/",$url);
	$part_2_cde = explode("\"",$part_one_cde[4]);
	$img_1 = "http://img.youtube.com/vi/$part_2_cde[0]/0.jpg";
    $img_2 = "http://img.youtube.com/vi/$part_2_cde[0]/1.jpg";
    $img_3 = "http://img.youtube.com/vi/$part_2_cde[0]/2.jpg";

    echo "Img 1";
    echo "<br />";
    echo "<img src=\"$img_3\" width=\"100\" height=\"100\" />";
    echo"<br /><br />";
    echo "Img 2";
    echo "<br />";
    echo "<img src=\"$img_2\" width=\"150\" height=\"150\" />";
    echo"<br /><br />";
    echo "Img 3";
    echo "<br />";
    echo "<img src=\"$img_1\" width=\"200\" height=\"200\" />";
    
    $product = "sam_worthington.jpg";
    if(file_exists("C:\\xampp\\htdocs\\yourcinema\\assets\\actors\\".$product)) {
    	echo $product;
    }
    	
?>
    <?php if(file_exists("/yourcinema/assets/movies/".$product)): ?>
		<img width="150" src="/yourcinema/assets/movies/<?php echo $product; ?>" />
	<?php elseif(file_exists("/yourcinema/assets/actors/".$product)): ?>
		<img width="150" src="/yourcinema/assets/actors/<?php echo $product; ?>" />
	<?php elseif(file_exists("/yourcinema/assets/directors/".$product)): ?>
		<img width="150" src="/yourcinema/assets/directors/<?php echo $product; ?>" />
	<?php endif; echo $product; ?>
<?php
    
if(strtotime(date('d-m-Y')) >= strtotime("07-03-2008")) {
	// daca data curenta este mai mare decat data lansarii filmului se poate vota
	$m_date = "true";
} else {
	$m_date = "false";
}
echo $m_date;*/
echo $core->render();

