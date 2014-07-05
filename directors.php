<?php
require("./library/boot.php");

$core->data['title'] = "Actors - " . site_name;
$core->template = "directors";

// 1. the current page number ($current_page)
$page = !empty($_GET['page']) ? (int)$_GET['page'] : 1;
// 2. records per page ($per_page)
$per_page = 5;
// 3. total record count ($total_count)
$total_count = $core->db->query("SELECT * FROM regizor")->num_rows;

$pagination = new Pagination($page, $per_page, $total_count);
$core->data['pagination'] = @$pagination;
$core->data['page'] = @$page;
$directors = $core->db->query("SELECT * FROM regizor ORDER BY first_name AND last_name LIMIT {$pagination->offset()}, {$per_page}")->rows;
$core->data['directors'] = &$directors;

echo $core->render();