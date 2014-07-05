<?php
require("./library/boot.php");

// titlul site-ului si template-ul pe care il foloseste
$core->data['title'] = e("Edit movie - ", false) . site_name;
$core->template = "insert_movie";

$core->data['edit'] = "edit";

if($user->isAdmin()) {
	// se preiau datele despre film
	if(isset($_GET['movie_id']) && intval($_GET['movie_id'])) {
		// se preia id-ul filmului
		$id = trim(mysql_real_escape_string($_GET['movie_id']));
		$filme = $catalog->selectFromTableWhere('filme', 'id', $id, 1);

		$id_gen1 = substr($filme['id_gen'], 0, 1);
		$id_gen2 = substr($filme['id_gen'], 2, 1);
		$id_gen3 = substr($filme['id_gen'], 4);

		// in tabelul filme avem doar id-ul genurilor acum trebuie sa preiau numele genului
		// preiau o data toate genurile pentru a forma lista de genuri
		$category = $core->db->query("SELECT name FROM gen")->rows;
		$core->data['category'] = &$category;
		if(!empty($id_gen1)) {
			// preiau doar genurile care sunt atribuite filmului pentru a fi deja selectate
			$category1 = $core->db->query("SELECT name FROM gen WHERE id={$id_gen1} OR id={$id_gen2} OR id={$id_gen3}")->rows;
			$core->data['category1'] = &$category1;
		}

		// preiau restul datelor despre film
		$core->data['name'] = $filme['name'];
		$core->data['movie_date'] = $filme['movie_date'];
		$core->data['sinopsis'] = $filme['sinopsis'];
		$core->data['picture'] = $filme['picture'];
		$core->data['stoc'] = $filme['stoc'];
		$core->data['price'] = $filme['price'];
		$core->data['visible'] = $filme['visible'];
	}

	// se verifica daca a fost sau nu dat submit de la insert_movie.tpl
	if (isset($_POST['submit'])) {
		// se preiau valorile din post mai intai asigurandu-ma ca sunt procesate si apoi sunt introduse in $core->data[] pentru a avea access la ele si in insert_movie.tpl
		if(isset($_POST['gen'])) {
			$gens = $_POST['gen'];
		} else {
			$gens = null;
		}

		// verific daca $_POST[] a fost schimbat sau nu, daca $_POST[] este acelasi cu datele din baza de date variabilele sunt puse null penru a nu fi introduse in UPDATE
		if(trim(mysql_real_escape_string($_POST['name'])) !== $filme['name']) {
			$core->data['name'] = $name = trim(mysql_real_escape_string($_POST['name'])); 
		} else {
			$name = null;
		}
		if(trim(mysql_real_escape_string($_POST['movie_date'])) !== $filme['movie_date']) {
			$core->data['movie_date'] = $movie_date = trim(mysql_real_escape_string($_POST['movie_date']));
		} else {
			$movie_date = null;
		}
		$add_date = date("Y-m-d");
		if(trim(mysql_real_escape_string($_POST['sinopsis'])) !== $filme['sinopsis']) {
			$core->data['sinopsis'] = $sinopsis = trim(mysql_real_escape_string($_POST['sinopsis']));
		} else {
			$sinopsis = null;
		}
		if(trim(mysql_real_escape_string($_POST['stoc'])) !== $filme['stoc']) {
			$core->data['stoc'] = $stoc = trim(mysql_real_escape_string($_POST['stoc']));
		} else {
			$stoc = null;
		}
		if(trim(mysql_real_escape_string($_POST['price'])) !== $filme['price']) {
			$core->data['price'] = $price = trim(mysql_real_escape_string($_POST['price']));
		} else {
			$price = null;
		}
		if(isset($_POST['visible']) && $_POST['visible'] == 1) {
			$visible = 1;
		} else {
			$visible = 0;
		}

		// se verifica daca este introdusa poza sau url-ul pozei
		if(isset($_POST['picture_name'])) {
			$picture = trim(mysql_real_escape_string($_POST['picture_name']));
		} elseif(isset($_POST['picture_url'])) {
			$picture = $_POST['picture_url'];
		} elseif(empty($picture)) {
			$picture = "all.jpg";
		} else {
			$picture = null;
		}

		// daca este pusa alta poza sterg automat poza veche
		if(!empty($filme['picture']) && !empty($picture) && ($picture !== $filme['picture'])) {
			if($filme['picture'] != "all.jpg") {
				unlink(SITE_PATH . "assets\\actors\\{$filme['picture']}");
			}
		}
		
		$id_gen = "";
		if(!empty($gens)) {
			// selectez din baza de date id-urile genurilor
			foreach($gens as $gen) {
				$gen_id = $core->db->query("SELECT id FROM gen WHERE name LIKE '{$gen}'")->rows[0];
				$id_gen .= "," . $gen_id['id'];
			}
		}
		// sterg prima virgula din string
		$id_gen = substr($id_gen, 1);
		if($id_gen !== $filme['id_gen']) {
			$core->data['category'] = $gens;
		} else {
			$id_gen = null;
		}

		// introduc in baza de date filmul, excluzand variabilele care sunt empty
		$query = "add_date=" . $add_date; 
		if(!empty($name)) {$query .= ", name='" . $name . "'"; }  
		if(!empty($movie_date)) {$query .= " movie_date='" . $movie_date . "'" . "movie_year=" . substr($movie_date, -4);} 
		if(!empty($sinopsis)) {$query .= ", sinopsis='" . $sinopsis . "'"; } 
		if(!empty($picture)) {$query .= ", picture='" . $picture . "'"; } 
		if(!empty($stoc)) {$query .= ", stoc=" . $stoc; } 
		if(!empty($price)) {$query .= ", price=" . $price; } 
		if(!empty($id_gen)) {$query .= ", id_gen='" . $id_gen . "'"; } 
		if(!empty($visible)) {$query .= ", visible=" . $visible; } 
		$core->db->query("UPDATE filme SET {$query} WHERE id={$id}");
		$_SESSION['message'] = "<h3>The movie was successfully updated.</h3>";			
	}
} else {
	$catalog->redirect("404.php");
}

echo $core->render();