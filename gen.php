<?php
/*require("./library/boot.php");

if(!isset($_GET['gen_id']) || !intval($_GET['gen_id'])) {
	include('./template/views/404.tpl');
	die();
}

$core->template = "gen";
$core->data['genre'] = $catalog->selectFromTableWhere('gen', 'id', $_GET['gen_id'],1);
$core->data['title'] = "Gen: " . e($core->data['genre']['name'], false) . " - " . site_name;


$core->data['products_from_category'] = $catalog->productsFromCategory($_GET['gen_id'], 12);



echo $core->render();