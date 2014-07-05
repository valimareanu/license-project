<?php
require("./library/boot.php");

// titlul site-ului si template-ul pe care il foloseste
$core->data['title'] = e("Insert trailer - ", false) . site_name;
$core->template = "insert_trailer";

if($user->isAdmin()) {
	// daca se gaseste variabila $_GET[] inseamna ca am fost redirectionat de la insert_movie.php si pot sa iau campurile de la filmul recent introdus
	if(isset($_GET['movie_id']) && intval($_GET['movie_id'])) {
		$film = $catalog->product($_GET['movie_id']);
		$core->data['film'] = &$film;
	}

	// se verifica daca a fost sau nu dat submit de la insert_trailer.tpl
	if(isset($_POST['submit'])) {
		// se preiau valorile din post mai intai asigurandu-ma ca sunt procesate si apoi sunt introduse in $core->data[] pentru a avea access la ele si in insert_trailer.tpl
		$core->data['movie_name'] = $movie_name = trim(mysql_real_escape_string($_POST['name']));
		$core->data['trailer'] = $trailer = trim($_POST['trailer']);
		$add_date = strftime("%Y-%m-%d %H:%M:%S", time());

		// daca am $_GET[] trimis de la insert_movie.php atunci preiau id-ul fimlului introdus, daca nu fac SELECT din baza de date pentru a gasi id-ul filmului
		if(isset($_GET['movie_id']) && intval($_GET['movie_id'])){
			$id = $film['id'];
		} elseif(!empty($movie_name)) {
			$film_id = array(); 
			if(!empty($core->db->query("SELECT id FROM filme WHERE name LIKE '{$movie_name}'")->rows[0])) {
				$film_id = $core->db->query("SELECT id FROM filme WHERE name LIKE '{$movie_name}'")->rows[0];
			} else {
				$film_id = null;
			}
			$id = $film_id['id'];
		}

		// verific daca toate campurile importante sunt completate
		if(empty($id)) {
			$_SESSION['message'] = "<h3>The movie could not be found.Please try again.</h3>";
			$core->data['error_field'] = 'movie_name';
		} elseif(empty($trailer)) {
	   		$_SESSION['message'] = "<h3>All the fields must be filled.</h3>";
			$core->data['error_field'] = 'trailer';		
		} else {
			$query = $core->db->query("SELECT id FROM trailer WHERE trailer LIKE '%{$trailer}%' LIMIT 1")->rows;
			// verific baza de date pentru a nu introduce duplicate
			if($query) {
				// afisez eroare daca s-a gasit deja un trailer introdus
				$_SESSION['message'] = "<h3>A trailer with that embed code is allready in the database.</h3>";
			} else {
				// altfel introduc actorul in baza de date
				$core->db->query("INSERT INTO trailer (filme_id, data, trailer) 
									VALUES ({$id}, '{$add_date}', '{$trailer}')");
				// preiau ultimul id introdus in baza de date
				$trailer_id = $core->db->getLastID();
				if($trailer_id) {
					// daca s-a introdus trailer-ul in baza de date eliberez toate variabilele cu care am lucrat
					unset($core->data['movie_name'], $core->data['trailer']);
					$_SESSION['message'] = "<h3>Trailer was successfully inserted in the database.</h3>";

					// daca exista variabila $_GET[] inseamna ca trebuie sa redirectionez mai departe pentru a introduce regizorul filmului
					if(isset($_GET['movie_id']) && intval($_GET['movie_id'])) {
						$catalog->redirect("insert_director.php?movie_id=" . $_GET['movie_id']);
					}
				}
			}
		}
	}
} else {
	$catalog->redirect("404.php");
}

echo $core->render();