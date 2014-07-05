<?php 
require("./library/boot.php");

	$core->data['title'] = "Sign Up/Log In - " . site_name;
	$core->template = "user_form";

	if($user->isLogged()) {

		$core->data['userAccountData'] = $user->getData();
		$core->data['edit_user'] = "edit_user";

		// se verifica daca a fost sau nu dat submit de la user_form.tpl
		if (isset($_POST['submit'])) {
			$update = true;
			// se preiau valorile din post mai intai asigurandu-ma ca sunt procesate

			// verific daca $_POST[] a fost schimbat sau nu, daca $_POST[] este acelasi cu datele din baza de date variabilele sunt puse null penru a nu fi introduse in UPDATE
			if(trim(mysql_real_escape_string($_POST['username'])) !== $core->data['userAccountData']['username']) {
				$core->data['userAccountData']['username'] = $username = trim(mysql_real_escape_string($_POST['username'])); 
			} else {
				$username = null;
			}
			if(trim(mysql_real_escape_string($_POST['first_name'])) !== $core->data['userAccountData']['first_name']) {
				$core->data['userAccountData']['first_name'] = $first_name = trim(mysql_real_escape_string($_POST['first_name']));
			} else {
				$first_name = null;
			}
			if(trim(mysql_real_escape_string($_POST['last_name'])) !== $core->data['userAccountData']['last_name']) {
				$core->data['userAccountData']['last_name'] = $last_name = trim(mysql_real_escape_string($_POST['last_name']));
			} else {
				$last_name = null;
			}
			if(md5(trim(mysql_real_escape_string($_POST['password']))) !== $core->data['userAccountData']['password']) {
				$_SESSION['message'] = "Password was incorrect.";
				$core->data['error_field'] = 'password';
				$update = false;
			} 
			if(trim(mysql_real_escape_string($_POST['email'])) !== $core->data['userAccountData']['email']) {
				$core->data['userAccountData']['email'] = $email = trim(mysql_real_escape_string($_POST['email']));
			} else {
				$email = null;
			}
			if(trim(mysql_real_escape_string($_POST['bio'])) !== $core->data['userAccountData']['bio']) {
				$core->data['userAccountData']['bio'] = $bio = trim(mysql_real_escape_string($_POST['bio']));
			} else {
				$bio = null;
			}

			// se verifica daca este introdusa poza sau url-ul pozei
			if(isset($_FILES['file']['name'])) {
				$picture = trim(mysql_real_escape_string($_FILES['file']['name']));
			} elseif(isset($_POST['picture_url'])) {
				$picture = $_POST['picture_url'];
			} else {
				$picture = "all.jpg";
			}
			if($user->uploadUserPhoto($_FILES['file']) != "OK") {
				$_SESSION['message'] = $user->uploadUserPhoto($_FILES['file']);
				$update = false;
			}

			// daca este pusa alta poza sterg automat poza veche
			if(!empty($picture) && ($picture !== $core->data['userAccountData']['picture'])) {
				if($data['userAccountData']['picture'] != "all.jpg") {
					unlink(SITE_PATH . "assets\\users\\{$data['userAccountData']['picture']}");
				}
			}
			
			if($update) {
				// introduc in baza de date filmul, excluzand variabilele care nu sunt modificate
				$query = " id=" . $core->data['userAccountData']['id']; 
				if(!empty($username)) {$query .= ", username='" . $username . "'"; }
				if(!empty($first_name)) {$query .= ", first_name='" . $first_name . "'"; }  
				if(!empty($last_name)) {$query .= ", last_name='" . $last_name . "'";} 
				if(!empty($email)) {$query .= ", email='" . $email . "'"; } 
				if(!empty($picture)) {$query .= ", picture='" . $picture . "'"; } 
				if(!empty($bio)) {$query .= ", bio='" . $bio . "'";}
				$core->db->query("UPDATE users SET {$query} WHERE id=".$core->data['userAccountData']['id']);
				$_SESSION['message'] = "Your account was successfully updated.";
			}
		}
	} else {
		$catalog->redirect("404.php");
	}

echo $core->render();