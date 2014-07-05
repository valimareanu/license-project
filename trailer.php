<?php
require("./library/boot.php");

// numele templateului pe care il foloseste acest controller
$core->template = "trailer";

if((!isset($_GET['movie_id']) || !intval($_GET['movie_id'])) || (!isset($_GET['trailer_id']) || !intval($_GET['trailer_id']))) {
	include('./template/views/404.php');
	die();
}
// memorez in $film datele despre filmul cu id-ul preluat din $_GET['']
$film = $catalog->product($_GET['movie_id']);
// daca id-ul preluat din $_GET[''] nu exista in baza de date atunci voi redirectiona catre pagina de eroare
if(empty($film)) {$catalog->redirect('404.php');}
// preiau trailerul pentru aceast film
$trailers = $catalog->getTrailer($_GET['movie_id']);

$core->data['film'] = &$film;
$core->data['trailers'] = &$trailers;
$core->data['title'] = e($film['name'], false) . " - " . site_name;

echo $core->render();