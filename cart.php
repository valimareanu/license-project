<?php 
require("./library/boot.php");

$core->data['title'] ="Cos de cumparaturi - " . site_name;
$core->template = "cart";

if(isset($_GET['action']) && $_GET['action'] == 'empty_cart'){
	$shop->emptyCart();
}

if(isset($_GET['action']) && isset($_GET['cid']) && $_GET['action'] == 'remove'){
	$shop->removeFromCart($_GET['cid']);
}

if(isset($_GET['action']) && isset($_GET['cid']) && $_GET['action'] == 'add_item'){
	$shop->addQty($_GET['cid']);
}

if(isset($_GET['action']) && isset($_GET['cid']) && $_GET['action'] == 'remove_item'){
	$shop->removeQty($_GET['cid']);
}
echo $core->render();