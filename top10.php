<?php 
require("./library/boot.php");

if(isset($_GET['name']) && ($_GET['name'] == 'actor' || $_GET['name'] == 'regizor' || $_GET['name'] == 'trailer' ||$_GET['name'] == 'filme')) {
	$table = trim(mysql_real_escape_string($_GET['name']));
}

$core->template = "top10";
if(isset($table)) {
	$top10 = $catalog->top10($table);
} else {
	$top10 = $catalog->top10('filme');
}
$core->data['top10'] = &$top10;
$core->data['title'] = e("Top 10 movies - ", false) . site_name;

echo $core->render();