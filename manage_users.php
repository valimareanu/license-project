<?php
require("./library/boot.php");

// titlul site-ului si template-ul pe care il foloseste
$core->data['title'] = e("Users - ", false) . site_name;
$core->template = "manage_users";

if($user->isAdmin()) {

	// 1. the current page number ($current_page)
	$page = !empty($_GET['page']) ? (int)$_GET['page'] : 1;
	// 2. records per page ($per_page)
	$per_page = 20;
	// 3. total record count ($total_count)
	$total_count = $core->db->query("SELECT * FROM users")->num_rows;

	$pagination = new Pagination($page, $per_page, $total_count);
	$core->data['pagination'] = @$pagination;
	$core->data['page'] = @$page;

	$query = "SELECT * FROM users";
	if(isset($_GET['action']) && $_GET['action'] == 'username') {
		$query .= " ORDER BY username";
	}
	if(isset($_GET['action']) && $_GET['action'] == 'admin') {
		$query .= " ORDER BY user_a DESC";
	}
	if(isset($_GET['action']) && $_GET['action'] == 'status') {
		$query .= " ORDER BY status";
	}
	$query .= " LIMIT {$pagination->offset()}, {$per_page}";
	$core->data['users_list'] = @$core->db->query($query)->rows;

	if(isset($_POST['submit'])) {
		if(isset($_GET['id']) && intval($_GET['id'])) {	
			$id = $_GET['id'];
			$picture = trim(mysql_real_escape_string($_POST['picture']));
			$bio = trim(mysql_real_escape_string($_POST['bio']));
			$user_a = trim(mysql_real_escape_string($_POST['user_a']));
			$check = $catalog->selectFromTableWhere("users", "id", $id, 1);
			if($picture != $check['picture']) {
				if($check['picture'] != "all.jpg") {
					unlink(SITE_PATH . "assets\\users\\{$check['picture']}");
				}
			}
			if($check) {
				if(empty($user_a)) $user_a = 0;
				$sql = "UPDATE users SET picture='{$picture}', bio='{$bio}', user_a={$user_a} WHERE id=".$id;
				$core->db->query($sql);
				echo "<script> window.history.go(-1); </script>";
			} 
		}
	}

	if(isset($_GET['id']) && intval($_GET['id']) && isset($_GET['action']) && $_GET['action'] == 'activated') {
		$changed = $user->changeStatus($_GET['id'], $_GET['action']);
		if($changed) {
			$_SESSION['message'] = "Status changed successfully.";
		} else {
			$_SESSION['message'] = "Something went wrong.";
		}
		echo "<script> window.history.go(-1); </script>";
	}

	if(isset($_GET['id']) && intval($_GET['id']) && isset($_GET['action']) && $_GET['action'] == 'banned') {
		$changed = $user->changeStatus($_GET['id'], $_GET['action']);
		if($changed) {
			$_SESSION['message'] = "Status changed successfully.";
		} else {
			$_SESSION['message'] = "Something went wrong.";
		}
		echo "<script> window.history.go(-1); </script>";
	}

	if(isset($_GET['id']) && intval($_GET['id']) && isset($_GET['action']) && $_GET['action'] == 'picture') {
		$id = $_GET['id'];
		$check = $catalog->selectFromTableWhere("users", "id", $id, 1);
		if($check['picture'] != "all.jpg") {
			unlink(SITE_PATH . "assets\\users\\{$check['picture']}");
		}
		echo "<script> window.history.go(-1); </script>";
	}

	if(isset($_GET['id']) && intval($_GET['id']) && isset($_GET['action']) && $_GET['action'] == 'delete') {
		$id = $_GET['id'];
		$deleted_user = $catalog->selectFromTableWhere('users', 'id', $id, 1);
		$catalog->deleteFromTable('users', "id = $id");
		$catalog->deleteFromTable('user_details', "user_id = $id");
		$_SESSION['message'] = "User deleted successfully.";
		if($deleted_user['picture'] != "all.jpg") {
			unlink(SITE_PATH . "assets\\users\\{$deleted_user['picture']}");
		}
		$mail_body = "Hello,".PHP_EOL.PHP_EOL."You have recived this email because your YourCinema account was deleted by an administrator.".PHP_EOL.PHP_EOL.
			"For more information please contact the administrator at ".PHP_EOL.PHP_EOL.
			"E-mail address ".administrator_email.PHP_EOL."YourCinema team.";
		if($core->php_mail($deleted_user['email'], "YourCinema", $mail_body)) {
			// daca a fost trimis emailul atunci informez utilizatorul
			$_SESSION['message'] = " Mail sent successfully.";
		} else {
			// altfel informez utilizatorul ca emailul nu s-a trimis si il rog sa ia legatura cu administratorul
			$_SESSION['message'] = "User deleted successfully. Something went wrong. mail could not be sent.";
		}
		//$catalog->redirect('order_edit.php');
		echo "<script> window.history.go(-1); </script>";
	}


} else {
	$catalog->redirect("404.php");
}

echo $core->render();