<?php 
require("./library/boot.php");

require("library/handlers/logout.php"); // handle log out
require("library/handlers/activate.php"); // handle account activation
require("library/handlers/account_change_password.php"); // handle account change password
require("library/handlers/forgot_password.php"); // handle forgot password form
require("library/handlers/login.php"); // handle the log in process
require("library/handlers/signup.php"); // handle registration


if(isset($_GET['action']) && $_GET['action'] = "forgot_password") {
	$core->data['title'] = "New Password - My Account - " . site_name;
	$core->template = "forgot_password";
} elseif($user->isLogged()) {

	$core->data['title'] = "My account - " . site_name;

	$core->data['userAccountData'] = $user->getData();
	$core->data['userPersonalData'] = $user->getPersonalData();
	$core->data['userOrdersData'] = $shop->getOrdersByUserId($core->data['userAccountData']['id']);

	$unread_message = $core->db->query("SELECT viewed FROM private_message WHERE viewed=0 AND reciever_id=" . $_SESSION['user_id'])->rows;
	if(!empty($unread_message)) {
		if(count($unread_message) == 1) {
			$core->data['unread_message'] = "You have an unread message.";
		} else {
			$core->data['unread_message'] = "You have " . count($unread_message) . " unread messages.";
		}
	}

	if(isset($_POST['dp_submit'])){
		$succes = $user->setPersonalData($_POST);
		$_SESSION['message'] = "Your personal data was successfully modified.";
	}
	$core->data['userPersonalData'] = $user->getPersonalData();

	$core->template = "user";
} else {
	$core->data['title'] = "Sign Up/Log In - " . site_name;
	$core->template = "user_form";
	if(isset($_GET['sign_in']) && intval($_GET['sign_in']) == 1) {
		$core->data['login'] = "login";
	}
}

echo $core->render();