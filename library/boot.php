<?php 
require("./library/config.php");
require("./library/core.class.php");
require("./library/catalog.class.php");
require("./library/shop.class.php");
require("./library/user.class.php");
require("./library/helpers.php");
require("./library/pagination.php");
require_once('./PHPMailer/class.phpmailer.php');
$core = Core::getInstance();
$user = User::getInstance($core->db);
$catalog = Catalog::getInstance($core->db);
$shop = Shop::getInstance($core->db);

if(!defined("API")){
	$core->data['_categories'] = &$catalog->categories;
}
