<?php 
require("./library/boot.php");

$core->data['title'] = "Edit orders - " . site_name;
$core->template = "order_edit";

if($user->isAdmin()) {

	// 1. the current page number ($current_page)
	$page = !empty($_GET['page']) ? (int)$_GET['page'] : 1;
	// 2. records per page ($per_page)
	$per_page = 20;
	// 3. total record count ($total_count)
	$total_count = $core->db->query("SELECT * FROM orders")->num_rows;

	$pagination = new Pagination($page, $per_page, $total_count);
	$core->data['pagination'] = @$pagination;
	$core->data['page'] = @$page;

	$all_orders = $shop->getOrders($pagination->offset(), $per_page);
	$core->data['all_orders'] = @$all_orders;

	if(isset($_POST['qty']) && isset($_GET['id']) && intval($_GET['id']) && isset($_GET['movie_id']) && intval($_GET['movie_id'])) {
		$qty = trim(mysql_real_escape_string($_POST['qty']));
		$movie = $catalog->selectFromTableWhere('filme', 'id', $_GET['movie_id'], 1);
		if(!empty($movie)) {
			$core->db->query("UPDATE order_product SET price=" . $movie['price']*$qty . ", qty=" . $qty . " WHERE id=" . $_GET['id']);
		}
		echo "<script> window.history.go(-1); </script>";
	}

	if(isset($_POST['shipping']) && isset($_GET['id']) && intval($_GET['id'])) {
		$shipping = trim(mysql_real_escape_string($_POST['shipping']));
		$core->db->query("UPDATE orders SET shipping_method='" . $_POST['shipping'] . "' WHERE id=" . $_GET['id']);
		echo "<script> window.history.go(-1); </script>";
	}

	if(isset($_GET['id']) && intval($_GET['id']) && isset($_GET['action']) && $_GET['action'] == 'pending') {
		$changed = $shop->changeStatus($_GET['id'], $_GET['action']);
		if($changed) {
			$_SESSION['message'] = "Status changed successfully.";
			foreach($all_orders as $a_order) {
				if($a_order['id'] == $_GET['id']) $order = $a_order;
			}
		} else {
			$_SESSION['message'] = "Something went wrong.";
		}
		echo "<script> window.history.go(-1); </script>";
	}

	if(isset($_GET['id']) && intval($_GET['id']) && isset($_GET['action']) && $_GET['action'] == 'on_route') {
		$changed = $shop->changeStatus($_GET['id'], $_GET['action']);
		if($changed) {
			$_SESSION['message'] = "Status changed successfully.";
			foreach($all_orders as $a_order) {
				if($a_order['id'] == $_GET['id']) $order = $a_order;
			}
		} else {
			$_SESSION['message'] = "Something went wrong.";
		}
		echo "<script> window.history.go(-1); </script>";
	}

	if(isset($_GET['id']) && intval($_GET['id']) && isset($_GET['action']) && $_GET['action'] == 'delivered') {
		$changed = $shop->changeStatus($_GET['id'], $_GET['action']);
		if($changed) {
			$_SESSION['message'] = "Status changed successfully.";
			foreach($all_orders as $a_order) {
				if($a_order['id'] == $_GET['id']) $order = $a_order;
			}
		} else {
			$_SESSION['message'] = "Something went wrong.";
		}
		echo "<script> window.history.go(-1); </script>";
	}

	if(isset($_GET['id']) && intval($_GET['id']) && isset($_GET['action']) && $_GET['action'] == 'cancel') {
		$changed = $shop->changeStatus($_GET['id'], $_GET['action']);
		if($changed) {
			$_SESSION['message'] = "Status changed successfully.";
			foreach($all_orders as $a_order) {
				if($a_order['id'] == $_GET['id']) $order = $a_order;
			}
			$shop->changeStock($order['filme_id'], $order['qty']);
		} else {
			$_SESSION['message'] = "Something went wrong.";
		}
		echo "<script> window.history.go(-1); </script>";
	}

	if(isset($_GET['id']) && intval($_GET['id']) && isset($_GET['action']) && $_GET['action'] == 'delete') {
		foreach($all_orders as $a_order) {
			if($a_order['id'] == $_GET['id']) $order = $a_order;
		}
		if($order['status'] == 'cancel') {
			$catalog->deleteFromTable('orders', "id = $id");
			$catalog->deleteFromTable('order_product', "order_id = $id");
			$_SESSION['message'] = "Order deleted successfully.";
		} else {
			$_SESSION['message'] = "Can't delete an ongoing order.";
		}
		echo "<script> window.history.go(-1); </script>";
	}
} else {
	$catalog->redirect("404.php");
}

echo $core->render();