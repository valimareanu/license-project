<?php
require("./library/boot.php");

if($user->isLogged()) {
	if(isset($_GET['action']) && $_GET['action'] == "unread") {
		$messages = $core->db->query("SELECT * FROM private_message WHERE reciever_id=" . $_SESSION['user_id'] . " AND viewed = 0")->rows;
		$core->db->query("UPDATE private_message SET viewed = 1 WHERE viewed = 0");
		$core->data['title'] = "Unread essages - " . site_name;
	} elseif(isset($_GET['action']) && $_GET['action'] == "messages") {
		$messages = $core->db->query("SELECT * FROM private_message WHERE reciever_id=" . $_SESSION['user_id'])->rows;
		$core->data['title'] = "Messages - " . site_name;
	}
	$core->data['messages'] = @$messages;
	$core->template = "user_profile";
} elseif(isset($_GET['sender']) && isset($_GET['id']) && intval($_GET['id'])) {
	$id = intval($_GET['sender']);
	$user_id = $_SESSION['user_id'];
	$name = $_SESSION['username'];
	$core->data['message'] = $message = trim(mysql_real_escape_string($_POST['message']));

	$query1 = $core->db->query("SELECT * FROM private_message WHERE sender_name LIKE '%{$name}%' AND message LIKE '%{$message}%' LIMIT 1")->rows;
	if(empty($query1)) { 
		$core->db->query("INSERT INTO private_message (sender_id, sender_name, reciever_id, message, viewed) VALUES ({$user_id}, '{$name}', {$id}, '{$message}', 0)");
		unset($core->data['name'], $core->data['message']);
		$catalog->redirect("user_profile.php?action=messages");
	} else {
		$_SESSION['message'] = "You have allready posted this message.";
		unset($core->data['name'], $core->data['message']);
	}
} elseif(!isset($_GET['user_id']) || !intval($_GET['user_id'])) {
	include('./template/views/404.php');
	die();
} else {

	$core->template = "user_profile";
	$user_profile = $catalog->selectFromTableWhere("users", "id", $_GET['user_id'], 1);
	$core->data['title'] = e($user_profile['first_name'] . ' ' . $user_profile['last_name'], false) . " - " . site_name;
	$core->data['user_profile'] = @$user_profile;

	if(isset($_POST['submit'])) {
		if(isset($_GET['user_id']) && intval($_GET['user_id'])) {
			$id = intval($_GET['user_id']);
		}
		if(empty($_POST['name'])) {
			$name = $_SESSION['username'];
			$user_id = $_SESSION['user_id'];
		} else {
			$core->data['name'] = $name = trim(mysql_real_escape_string($_POST['name']));
		}
		$core->data['message'] = $message = trim(mysql_real_escape_string($_POST['message']));

		$query1 = $core->db->query("SELECT * FROM private_message WHERE sender_name LIKE '%{$name}%' AND message LIKE '%{$message}%' LIMIT 1")->rows;
		if(empty($query1)) {
			if($user->isLogged()) { 
				$core->db->query("INSERT INTO private_message (sender_id, sender_name, reciever_id, message, viewed) VALUES ({$user_id}, '{$name}', {$id}, '{$message}', 0)");
				unset($core->data['name'], $core->data['message']);
			} else {
				$core->db->query("INSERT INTO private_message (sender_name, reciever_id, message, viewed) VALUES('{$name}', {$id}, '{$message}', 0)");
				unset($core->data['name'], $core->data['message']);
			}
		} else {
			$_SESSION['message'] = "You have allready posted this message.";
			unset($core->data['name'], $core->data['message']);
		}
	}
}
echo $core->render();