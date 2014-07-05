<?php 

if(isset($_POST['new_password'])){

	//validation
	$fail = false;
	do {
		if(!$user->validatePassword($_POST['new_password'])){
			$_SESSION['message'] = "Your new password is too short (at least 6 characters)!";
			$fail = true;
			break;
		}
		if($_POST['new_password'] != $_POST['new_password2']){
			$_SESSION['message'] = "Passwords don't match!";
			$fail = true;
			break;
			}
		if(!$user->isLogged()){
			$_SESSION['message'] = "You are no longer logged in your account.";
			$fail = true;
			break;
		}
		$userData = $user->getData();
		if($userData['password'] == md5($_POST['new_password2'])){
			$_SESSION['message'] = "New password must be different from the old one.";
			$fail = true;
			break;
		}
	} while (false);

	// change the pass
	if(!$fail){
		$succes = $user->changePassword($_POST['new_password']);
		if($succes){
			$_SESSION['message'] = "Your password was successfully changed.";
		} else {
			$_SESSION['message'] = "An error has occurred. Please try again later.";
		}
	}
	$catalog->redirect('user.php');

}