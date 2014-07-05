<?php 

	if (isset($_POST['submit'])) {
		// se initializeaza variabila $insert cu true, daca ramane asa pana la introducere in baza de date inseamna ca totul a fost
		// verificat
		$insert = true;
		// se initializeaza din start statusul contului pentru a fi apoi activat cand utilizatorul primeste emailul din partea siteului
		$status = "pending";

		// se preiau variabilele din $_POST['']
		$core->data['username'] = $username = trim(mysql_real_escape_string($_POST['username']));
		$password = trim(mysql_real_escape_string($_POST['password']));
		$password1 = trim(mysql_real_escape_string($_POST['password1']));
		$core->data['first_name'] = $first_name = trim(mysql_real_escape_string($_POST['first_name']));
		$core->data['last_name'] = $last_name = trim(mysql_real_escape_string($_POST['last_name']));
		$core->data['email'] = $email = trim(mysql_real_escape_string($_POST['email']));
		$core->data['picture_url'] = trim(mysql_real_escape_string($_POST['picture_url']));
		$core->data['bio'] = $bio = trim(mysql_real_escape_string($_POST['bio']));
		$add_date = strftime("%Y-%m-%d %H:%M:%S", time());

		// se verifica daca utilizatorul a introdus o poza sau URL-ul unei poze
		// daca nu a introdus nici poza nici URL atunci este pusa poza default all.jpg
		if(empty($_FILES['file']['name'])) {
			$picture = "all.jpg";
		} elseif(isset($_POST['picture_url'])) {
			$picture = trim(mysql_real_escape_string($_POST['picture_url']));
		} else {
			$picture = trim(mysql_real_escape_string($_FILES['file']['name']));
		}

		// se verifica daca toate campurile au fost completate
		if(empty($username)) {
			$_SESSION['message'] = "Username must be filled.";
			$core->data['error_field'] = 'username';
			$insert = false;
		} elseif(empty($first_name)) {
			$_SESSION['message'] = "First name must be filled.";
			$core->data['error_field'] = 'first_name';
			$insert = false;
		} elseif(empty($last_name)) {
			$_SESSION['message'] = "Last name must be filled.";
			$core->data['error_field'] = 'last_name';
			$insert = false;
		} elseif(empty($email)) {
			$_SESSION['message'] = "Email must be filled.";
			$core->data['error_field'] = 'email';
			$insert = false;
		}

		// se verifica daca emailul este valid sau daca este deja acest email in baza de date
		if(!$user->validateEmail($email)) {
			$_SESSION['message'] = "Email adress is invalid.";
			$insert = false;
		} elseif($user->isEmailTaken($email)) {
			$_SESSION['message'] = "The email is allready taken.";
			$insert = false;
		}

		if(!$user->validatePassword($password)) {
			$_SESSION['message'] = "Password isn't strong enough.";
			$insert = false;
		}

		if($password != $password1) {
			$_SESSION['message'] = "Passwords don't match.";
			$core->data['error_field'] = 'password';
			$insert = false;
		}

		if(empty($_FILES['file']['name'])) {
			// utilizatorul nu doreste sa adauge poza o sa fie pusa poza default
		} else {
			if($user->uploadUserPhoto($_FILES['file']) != "OK") {
				// daca metoda $user->uploadUserPhoto() nu intoarce OK atunci a intors o eroare care este afisata utilizatorului
				$_SESSION['message'] = $user->uploadUserPhoto($_FILES['file']);
				$insert = false;
			}
		}

		// daca $insert a ramas true atunci pot sa trimit mail utilizatorului pentru a activa contul
		if($insert == true) {
			// se genereaza un token de 6 cifre sau litere
			$token = $user->generateToken(6);
			// trimit mail utilizatorului cu pagina pe care trebuie sa o acceseze pentru a-si activa contul
			$mail_body = "Hello,".PHP_EOL.PHP_EOL."You have recived this email because you Signed Up with YourCinema.".PHP_EOL.PHP_EOL.
							"Please follow this link to finish the registration process.".PHP_EOL.PHP_EOL.
							site_domain."/user.php?action=activation&email=".$email."&token=".$token.PHP_EOL.PHP_EOL."We hope you like our services,".PHP_EOL."YourCinema team.";
			if($core->php_mail($email, "Account activation", $mail_body)) {
				// introduc datele in baza de date, statusul utilizatorului fiind pending
				$user->register($username, $password, $first_name, $last_name, $email, $picture, $bio, $status, $token, $add_date);
				// daca a fost trimis emailul atunci informez utilizatorul
				$_SESSION['message'] = "Check your email for the activation link.";
				$catalog->redirect("index.php");
			} else {
				// altfel informez utilizatorul ca emailul nu s-a trimis si il rog sa ia legatura cu administratorul
				$_SESSION['message'] = "Couldn't send email. Please try again or contact the administrator at E-mail address ".administrator_email.".";
			}
		}
	}
?>