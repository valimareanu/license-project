<?php
require("./library/boot.php");

// titlul site-ului si template-ul pe care il foloseste
$core->data['title'] = e("Insert actor - ", false) . site_name;
$core->template = "insert_actor";

if($user->isAdmin()) {
	// daca se gaseste variabila $_GET[] inseamna ca am fost redirectionat de la insert_movie.php si pot sa iau campurile de la filmul recent introdus
	if(isset($_GET['movie_id']) && intval($_GET['movie_id'])) {
		$film = $catalog->product($_GET['movie_id']);
		$core->data['film'] = &$film;
	}

	// SELECT pentru toate filmele si actorii pentru a polpula listele din insert_actor.tpl
	$movies = $core->db->query("SELECT name FROM filme")->rows;
	$core->data['movies'] = &$movies;
	$actors = $core->db->query("SELECT first_name, last_name FROM actor")->rows;
	$core->data['actors'] = &$actors;

	// se verifica daca a fost sau nu dat submit de la insert_actor.tpl
	if(isset($_POST['submit'])) {
		$insert_actor = true;
		// se preiau valorile din post mai intai asigurandu-ma ca sunt procesate si apoi sunt introduse in $core->data[] pentru a avea access la ele si in insert_actor.tpl
		$core->data['name'] = $movie_name = trim(mysql_real_escape_string($_POST['name']));
		$core->data['actor_film_name'] = $actor_film_name = trim(mysql_real_escape_string($_POST['actor_film_name']));
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
			$film_id = array(); 
			$query = $core->db->query("SELECT id FROM filme WHERE name LIKE '{$movie_name}'")->rows[0];
			if(!empty($query)) {
				$film_id = $core->db->query("SELECT id FROM filme WHERE name LIKE '{$movie_name}'")->rows[0];
				$id = $film_id['id'];
			} else {
				$id = null;
				$_SESSION['message'] = "The movie was not found in the database.";
				$insert_actor = false;
			}
		}

		// verific daca toate campurile importante sunt completate
		if(empty($first_name)) {
			$_SESSION['message'] = "All the fields except movie name must be filled.";
			$core->data['error_field'] = 'first_name';
			$insert_actor = false;
		} 
		if (empty($last_name)) {
			$_SESSION['message'] = "All the fields except movie name must be filled.";
			$core->data['error_field'] = 'last_name';
			$insert_actor = false;
		} 
		if (empty($birth_place)) {
			$_SESSION['message'] = "All the fields except movie name must be filled.";
			$core->data['error_field'] = 'birth_place';
			$insert_actor = false;
		} 
		if (empty($birth_date)) {
			$_SESSION['message'] = "All the fields except movie name must be filled.";
			$core->data['error_field'] = 'birth_date';
			$insert_actor = false;
		} 
		if (empty($country)) {
			$_SESSION['message'] = "All the fields except movie name must be filled.";
			$core->data['error_field'] = 'country';
			$insert_actor = false;
		}
		if (empty($biography)) {
			$_SESSION['message'] = "All the fields except movie name must be filled.";
			$core->data['error_field'] = 'biography';
			$insert_actor = false;
		} 

		if($insert_actor == true) {
			$query2 = $core->db->query("SELECT id FROM actor WHERE first_name LIKE '%{$first_name}%' AND last_name LIKE '%{$last_name}%' LIMIT 1")->rows;
			// verific baza de date pentru a nu introduce duplicate
			if($query2) {
				// afisez eroare daca s-a gasit deja un actor cu numele si prenumele introdus
				$_SESSION['message'] = "An actor with that first name and last name is allready in the database.";
			} else {	
				// altfel introduc actorul in baza de date
				$core->db->query("INSERT INTO actor (first_name, last_name, birth_place, birth_date, country, biography, picture) 
									VALUES ('{$first_name}', '{$last_name}', '{$birth_place}', '{$birth_date}', '{$country}', '{$biography}', '{$picture}')");
				// preiau ultimul id introdus in baza de date
				$actor_id = $core->db->getLastID();
				if($actor_id) {
					// daca s-a introdus actorul in baza de date eliberez toate variabilele cu care am lucrat
					unset($core->data['name'], $core->data['first_name'], $core->data['last_name'], $core->data['birth_place'], $core->data['birth_date'], $core->data['country'], $core->data['biography'], $core->data['picture']);
					$_SESSION['message'] = "<h3>The actor was successfully inserted in the database.</h3>";
				
					// daca a fost introdus actorul in baza de date inseamna ca pot sa fac si legatura intre regizor si film
					if(!empty($id)) {
						if(empty($actor_film_name)) {	
							$core->db->query("INSERT INTO actor_film (actor_id, filme_id) 
											VALUES ({$actor_id}, {$id})");
						} else {
							$core->db->query("INSERT INTO actor_film (actor_id, filme_id, aka) 
											VALUES ({$actor_id}, {$id}, '{$actor_film_name}')");
						}
					}
					// daca exista variabila $_GET[] pot sa introduc mai multi actori pentru acelasi film
					if(isset($_GET['movie_id']) && intval($_GET['movie_id'])) {
						$catalog->redirect("insert_actor.php?movie_id=" . $_GET['movie_id']);
					}
				}
			}
		}
	}

	// se verifica daca a fost sau nu dat submit1 de la insert_actor.tpl
	if(isset($_POST['submit1'])) {
		// se preiau datele din $_POST[]
		$core->data['movie_name'] = $movie_name = trim(mysql_real_escape_string($_POST['movie_name']));
		$core->data['actor_name'] = $actor_name = trim(mysql_real_escape_string($_POST['actor_name']));
		$core->data['aka'] = $aka = trim(mysql_real_escape_string($_POST['actor_film_name']));

		// despart numele in doua pentru ca apoi sa fie introdus in $first_name si $last_name
		$arr = explode(" ", $actor_name, 2);
		if(isset($arr[0])) {$first_name = $arr[0];} else {$first_name = null;}
		if(isset($arr[1])) {$last_name = $arr[1];} else {$last_name = null;}
		// preiau id-ul actorilor selectati
		$actor_id = $core->db->query("SELECT id FROM actor WHERE first_name LIKE '%{$first_name}%' AND last_name LIKE '%{$last_name}%' LIMIT 1")->rows[0];
		// preiau id-ul filmului
		$movie_id = $core->db->query("SELECT id FROM filme WHERE name LIKE '%{$movie_name}%' LIMIT 1")->rows[0];
		// verific daca toate campurile sunt completate
		if(empty($movie_name)) {
			$_SESSION['message'] = "All the fields must be filled.";
			$core->data['error_field'] = 'movie_name';
		} elseif(empty($actor_name)) {
			$_SESSION['message'] = "All the fields must be filled.";
			$core->data['error_field'] = 'actor_name';
		} else {
			if(isset($movie_id) && isset($actor_id)) {
				// se verifica daca legatura nu a fost facuta deja cu filmul selectat 
				$query = $core->db->query("SELECT * FROM actor_film WHERE actor_id=" . $actor_id['id'] . " AND filme_id=" . $movie_id['id'])->rows;
				if(isset($aka) && !empty($aka)) {
					$query2 = $core->db->query("SELECT * FROM actor_film WHERE actor_id=" . $actor_id['id'] . " AND filme_id=" . $movie_id['id'] . " AND aka LIKE '" . $aka . "'")->rows;
				}
				if(!$query) {
					// daca nu a fost facuta deja legatura dintre actor si film se face acum
					$core->db->query("INSERT INTO actor_film (actor_id, filme_id) VALUES (" . $actor_id['id'] . ", " . $movie_id['id'] . ")");
					$_SESSION['message'] = "Actor's filmography was updated.";
					unset($query);
				} elseif(!$query2) {
					// daca era deja facuta legatura insa nu era pus numele actorului in film atunci updatez tabelul
					$core->db->query("UPDATE actor_film SET aka = '{$aka}' WHERE actor_id=" . $actor_id['id'] . " AND filme_id=" . $movie_id['id']);
					$_SESSION['message'] = "Actor's movie name was added.";
				} else {
					// anunta utilizatorul ca legatura intre actor si film este deja facuta
					$_SESSION['message'] = "The movie was allready added to the actor's filmography. Actor ID " . $actor_id['id'];
				}
			} else {
				// afiseaza mesaj de eroare 
				$_SESSION['message'] = "Something went wrong please try again.";
			}
		}
	}
} else {
	$catalog->redirect("404.php");
}

echo $core->render();