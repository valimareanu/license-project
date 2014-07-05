<?php
require("./library/boot.php");

// titlul site-ului si template-ul pe care il foloseste
$core->data['title'] = e("Stock - ", false) . site_name;
$core->template = "stock";

if($user->isAdmin()) {

	// 1. the current page number ($current_page)
	$page = !empty($_GET['page']) ? (int)$_GET['page'] : 1;
	// 2. records per page ($per_page)
	$per_page = 8;
	// 3. total record count ($total_count)
	$total_count = $core->db->query("SELECT * FROM filme")->num_rows;

	$pagination = new Pagination($page, $per_page, $total_count);
	$core->data['pagination'] = @$pagination;
	$core->data['page'] = @$page;

	$sql = "SELECT f.*, o_p.filme_id, count(o_p.qty) AS total_qty FROM filme AS f 
			LEFT JOIN order_product AS o_p ON f.id=o_p.filme_id
			GROUP BY name ORDER BY stoc ASC, name ASC LIMIT {$pagination->offset()}, {$per_page}";
	$film_stock = $core->db->query($sql)->rows;

	$core->data['film_stock'] = $film_stock;

	if(isset($_POST['submit'])) {
		if(isset($_GET['id']) && intval($_GET['id'])) {	
			$stock = trim(mysql_real_escape_string($_POST['stock']));
			$price = trim(mysql_real_escape_string($_POST['price']));
			$id = $_GET['id'];
			$check = $catalog->selectFromTableWhere("filme", "id", $id);
			if($check) {
				$core->db->query("UPDATE filme SET stoc={$stock}, price={$price} WHERE id={$id}");
				echo "<script> window.history.go(-1); </script>";
			} 
		}
	}
} else {
	$catalog->redirect("404.php");
}

echo $core->render();