<?php
require("./library/boot.php");

// titlul siteului si template-ul pe care il foloseste
$core->data['title'] = e("Insert diredctor - ", false) . site_name;
$core->template = "insert_director";

if($user->isAdmin()) {
	// daca se gaseste variabila $GET[] inseamna ca am fost redirectionat de la insert_movie.php si pot sa iau campurile de la filmul recent introdus
	if(isset($_GET['movie_id']) && intval($_GET['movie_id'])) {
		$film = $catalog->product($_GET['movie_id']);
		$core->data['film'] = &$film;
	}

	// SELECT pentru toate filmele si regizorii pentru a polpula listele din insert_director.tpl
	$movies = $core->db->query("SELECT name FROM filme")->rows;
	$core->data['movies'] = &$movies;
	$directors = $core->db->query("SELECT first_name, last_name FROM regizor")->rows;
	$core->data['directors'] = &$directors;

	// se verifica daca a fost sau nu dat submit de la insert_director.tpl
	if(isset($_POST['submit'])) {
		// se preiau valorile din post mai intai asigurandu-ma ca sunt procesate si apoi sunt introduse in $core->data[] pentru a avea access la ele si in insert_director.tpl
		$core->data['name'] = $movie_name = trim(mysql_real_escape_string($_POST['name']));
		$core->data['first_name'] = $first_name = trim(mysql_real_escape_string($_POST['first_name']));
		$core->data['last_name'] = $last_name = trim(mysql_real_escape_string($_POST['last_name']));
		$core->data['birth_place'] = $birth_place = trim(mysql_real_escape_string($_POST['birth_place']));
		$core->data['birth_date'] = $birth_date = trim(mysql_real_escape_string($_POST['birth_date']));
		$core->data['country'] = $country = trim(mysql_real_escape_string($_POST['country']));
		$core->data['biography'] = $biography = trim(mysql_real_escape_string($_POST['biography']));
		// se verifica daca este introdusa poza sau url-ul pozei
		if(isset($_POST['picture_name'])) {
			$picture = trim(mysql_real_escape_string($_POST['picture_name']));
		} else {
			$picture = $_POST['picture_url'];
		}
		if(empty($picture)) {
			$picture = "all.jpg";
		}

		// daca am $_GET[] trimis de la insert_movie.php atunci preiau id-ul fimlului introdus, daca nu fac SELECT din baza de date pentru a gasi id-ul filmului
		if(isset($_GET['movie_id']) && intval($_GET['movie_id'])){
			$id = $film['id'];
		} elseif(!empty($movie_name)) {
			$film = array(); 
			$query = $core->db->query("SELECT id FROM filme WHERE name LIKE '{$movie_name}'")->rows[0];
			if(!empty($query)) {
				$film_id = $core->db->query("SELECT id FROM filme WHERE name LIKE '{$movie_name}'")->rows[0];
				$id = $film_id['id'];
			} else {
				$id = null;
				$_SESSION['message'] = "<h3>The movie was not found in the database.</h3>";
			}
			$id = $film['id'];
		}

		// verific daca toate campurile importante sunt completate
		if(empty($first_name)) {
			$_SESSION['message'] = "<h3>All the fields except movie name must be filled.</h3>";
			$core->data['error_field'] = 'first_name';
		} elseif (empty($last_name)) {
			$_SESSION['message'] = "<h3>All the fields except movie name must be filled.</h3>";
			$core->data['error_field'] = 'last_name';
		} elseif (empty($birth_place)) {
			$_SESSION['message'] = "<h3>All the fields except movie name must be filled.</h3>";
			$core->data['error_field'] = 'birth_place';
		} elseif (empty($birth_date)) {
			$_SESSION['message'] = "<h3>All the fields except movie name must be filled.</h3>";
			$core->data['error_field'] = 'birth_date';
		} elseif (empty($country)) {
			$_SESSION['message'] = "<h3>All the fields except movie name must be filled.</h3>";
			$core->data['error_field'] = 'country';
		}elseif (empty($biography)) {
			$_SESSION['message'] = "<h3>All the fields except movie name must be filled.</h3>";
			$core->data['error_field'] = 'biography';
		} else {
			$query2 = $core->db->query("SELECT id FROM regizor WHERE first_name LIKE '%{$first_name}%' AND last_name LIKE '%{$last_name}%' LIMIT 1")->rows;
			// verific baza de date pentru a nu introduce duplicate
			if($query2) {
				// afisez eroare daca s-a gasit deja un regizor cu numele si prenumele introdus
				$_SESSION['message'] = "<h3>An director with that first name and last name is allready in the database.</font></h3>";
			} else {
				$core->db->query("INSERT INTO regizor (first_name, last_name, birth_place, birth_date, country, biography, picture) 
									VALUES ('{$first_name}', '{$last_name}', '{$birth_place}', '{$birth_date}', '{$country}', '{$biography}', '{$picture}')");
				// preiau ultimul id introdus in baza de date
				$director_id = $core->db->getLastID();
				if($director_id) {
					// daca s-a introdus un regizor in baza de date eliberez toate variabilele cu care am lucrat
					unset($core->data['name'], $core->data['first_name'], $core->data['last_name'], $core->data['birth_place'], $core->data['birth_date'], $core->data['country'], $core->data['biography'], $core->data['picture']);
					$_SESSION['message'] = "<h3>The director was successfully inserted in the database.</font></h3>";

					// daca a fost introdus regizorul in baza de date inseamna ca pot sa fac si legatura intre regizor si film
					if(!empty($id)) {	
						$core->db->query("INSERT INTO regizor_film (regizor_id, filme_id) 
											VALUES ({$director_id}, {$id})");
					}

					// daca exista variabila $_GET[] inseamna ca trebuie sa redirectionez mai departe pentru a introduce actorii filmului
					if(isset($_GET['movie_id']) && intval($_GET['movie_id'])) {
						$catalog->redirect("insert_actor.php?movie_id=" . $_GET['movie_id']);
					}
				}
			}
		}
	}

	// se verifica daca a fost sau nu dat submit1 de la insert_director.tpl
	if(isset($_POST['submit1'])) {
		// se preiau datele din $_POST[]
		$core->data['movie_name'] = $movie_name = trim(mysql_real_escape_string($_POST['movie_name']));
		$core->data['director_name'] = $directors_name = $_POST['director_name'];
		// deoarece $_POST['director_name'] multiple select trebuie sa le preiau pe toate
		foreach ($directors_name as $director_name) {
			// despart numele in doua pentru ca apoi sa fie introdus in $first_name si $last_name
			$arr = explode(" ", $director_name, 2);
			if(isset($arr[0])) {$first_name = $arr[0];} else {$first_name = null;}
			if(isset($arr[1])) {$last_name = $arr[1];} else {$last_name = null;}
			// preiau id-ul regizorilor selectati
			$director_ids[] = $core->db->query("SELECT id FROM regizor WHERE first_name LIKE '%{$first_name}%' AND last_name LIKE '%{$last_name}%' LIMIT 1")->rows[0];
		}
		// preiau id-ul filmului
		$movie_id = $core->db->query("SELECT id FROM filme WHERE name LIKE '%{$movie_name}%' LIMIT 1")->rows[0];
		// verific daca toate campurile sunt completate
		if(empty($movie_name)) {
			$_SESSION['message'] = "<h3>All the fields must be filled.</h3>";
			$core->data['error_field'] = 'movie_name';
		} elseif(empty($director_name)) {
			$_SESSION['message'] = "<h3>All the fields must be filled.</h3>";
			$core->data['error_field'] = 'director_name';
		} else {
			if(isset($movie_id) && isset($director_ids)) {
				foreach($director_ids as $director_id) {
					// pentru fiecare regizor in parte se verifica daca legatura nu a fost facuta deja cu filmul selectat
					$query = $core->db->query("SELECT * FROM regizor_film WHERE find_in_set(" . $director_id['id'] . ", regizor_id) AND find_in_set(" . $movie_id['id'] . ", filme_id)")->rows;
					if(!$query) {
						// daca nu a fost facuta deja legatura dintre regizor si film se face acum
						$core->db->query("INSERT INTO regizor_film (regizor_id, filme_id) VALUES (" . $regizor_id['id'] . ", " . $movie_id['id'] . ")");
						$_SESSION['message'] = "Director's filmography was updated.";
						unset($query);
					} else {
						// anunta utilizatorul ca legatura intre regizor si film este deja facuta
						$_SESSION['message'] = "<h3>The movie was allready added to the direcor's filmography. Director ID " . $director_id['id'] . "</h3>";
						break;
					}
				}
			} else {
				// afiseaza mesaj de eroare 
				$_SESSION['message'] = "<h3>Something went wrong please try again.</h3>";
			}
		}
	}
} else {
	$catalog->redirect("404.php");
}

echo $core->render();