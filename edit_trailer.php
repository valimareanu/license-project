<?php
require("./library/boot.php");

// titlul site-ului si template-ul pe care il foloseste
$core->data['title'] = e("Edit trailer - ", false) . site_name;
$core->template = "insert_trailer";

$core->data['edit'] = "edit";

if($user->isAdmin()) {
	// se preiau datele despre trailer
	if(isset($_GET['trailer_id']) && intval($_GET['trailer_id'])) {
		// se preia id-ul trailerului
		$id = trim(mysql_real_escape_string($_GET['trailer_id']));
		$trailer = $catalog->selectFromTableWhere('trailer', 'id', $id, 1);

		// preiau restul datelor despre trailer
		$core->data['trailer'] = $trailer['trailer'];
		// dupa ce am id-ul filmului selectez din baza de date si numele filmului
		$movie_name = $catalog->selectFromTableWhere('filme', 'id', $trailer['filme_id'], 1);
		$core->data['movie_name'] = $movie_name['name'];
	}

	// se verifica daca a fost sau nu dat submit de la insert_actor.tpl
	if (isset($_POST['submit'])) {
		// se preiau valorile din post mai intai asigurandu-ma ca sunt procesate si apoi sunt introduse in $core->data[] pentru a avea access la ele si in insert_actor.tpl

		// verific daca $_POST[] a fost schimbat sau nu, daca $_POST[] este acelasi cu datele din baza de date variabilele sunt puse null penru a nu fi introduse in UPDATE
		if(trim(mysql_real_escape_string($_POST['trailer'])) !== $actor['trailer']) {
			$core->data['trailer'] = $trailer = trim(mysql_real_escape_string($_POST['trailer'])); 
		} else {
			$trailer = null;
		}

		if(!empty($first_name)) {
			$core->db->query("UPDATE trailer SET trailer='[$trailer]' WHERE id={$id}");
			$_SESSION['message'] = "<h3>The trailer was successfully updated.</h3>";
		}
	}
} else {
	$catalog->redirect("404.php");
}

echo $core->render();