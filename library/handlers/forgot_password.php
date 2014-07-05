<?php
	// daca utilizatorul a uitat parola atunci i se trimite un mail cu o parola noua si este rugat sa se autentifice cat mai 
	// repede si sa schimbe parola temporara cu alta pe care o va folosi
	if(isset($_GET['action']) && $_GET['action'] == 'forgot_password' && isset($_POST['email'])) {
		if(!$user->validateEmail($_POST['email'])) {
			// se verifica daca emailul este valid
			$_SESSION['message'] = "Email adress was invalid.";
		} elseif (!$user->isEmailTaken($_POST['email'])) {
			// daca emailul nu exista in baza de date atunci este afisat mesaj de eroare
			$_SESSION['message'] = "There is no account with this email adress.";
		} else {
			// altfel se reseteaza parola pentru utilizator
			$action = $user->resetPassword($_POST['email']);
			if($action != false) {
				// daca s-a resetat parola corespunzator se trimite mail utilizatorului
				$mail_body = "Hello,".PHP_EOL.PHP_EOL."You have recived this email because you have requested the account password reset on YourCinema".PHP_EOL."Your account data:".PHP_EOL.PHP_EOL."Email: ".$_POST['email'].PHP_EOL."New password: ".$action['new_password'].PHP_EOL.PHP_EOL."Please log in and change this password with a new one that you can easily remember as soon as you can.";
				$core->php_mail($_POST['email'], "Password reset", $mail_body);
			} else {
				// daca nu s-a putut reseta parola atunci rog utilizatorul sa ia legatura cu administratorul
				$_SESSION['message'] = "An error has occured. Please contact the administrator at E-mail address ".administrator_email.".";
			}
		}
	} 