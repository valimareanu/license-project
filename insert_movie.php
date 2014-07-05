<?php
require("./library/boot.php");

// titlul site-ului si template-ul pe care il foloseste
$core->data['title'] = e("Insert movie - ", false) . site_name;
$core->template = "insert_movie";

if($user->isAdmin()) {
	// SELECT pentru toate filmele si actorii pentru a polpula listele din insert_movies.tpl
	$category = $core->db->query("SELECT name FROM gen")->rows;
	$core->data['category'] = &$category;

	// se verifica daca a fost sau nu dat submit de la insert_movie.tpl
	if (isset($_POST['submit'])) {
		// se preiau valorile din post mai intai asigurandu-ma ca sunt procesate si apoi sunt introduse in $core->data[] pentru a avea access la ele si in insert_movie.tpl
		$gens = $_POST['gen'];

		$core->data['name'] = $name = trim(mysql_real_escape_string($_POST['name']));
		$core->data['movie_date'] = $movie_date = trim(mysql_real_escape_string($_POST['movie_date']));
		$movie_year = substr($movie_date, -4);
		$add_date = strftime("%Y-%m-%d %H:%M:%S", time());
		$core->data['sinopsis'] = $sinopsis = trim(mysql_real_escape_string($_POST['sinopsis']));
		// se verifica daca este introdusa poza sau url-ul pozei
		if(isset($_POST['picture_name'])) {
			$picture = trim(mysql_real_escape_string($_POST['picture_name']));
		} else {
			$picture = $_POST['picture_url'];
		}
		if(empty($picture)) {
			$picture = "all.jpg";
		}
		
		$core->data['stoc'] = $stoc = trim(mysql_real_escape_string($_POST['stoc']));
		$core->data['price'] = $price = trim(mysql_real_escape_string($_POST['price']));
		if(isset($_POST['visible']) && $_POST['visible'] == 1) {
			$visible = 1;
		} else {
			$visible = 0;
		}

		// verific daca toate campurile importante sunt completate
		if(empty($name)) {
			$_SESSION['message'] = "<h3>All the fields must be filled.</h3>";
			$core->data['error_field'] = 'name';
		} elseif(empty($gens)) {
			$_SESSION['message'] = "<h3>Genre of the movie must be different.</h3>";
			$core->data['error_field'] = 'gen';
		}  elseif (empty($movie_date)) {
			$_SESSION['message'] = "<h3>All the fields must be filled.</h3>";
			$core->data['error_field'] = 'movie_date';
		} elseif (empty($sinopsis)) {
			$_SESSION['message'] = "<h3>All the fields must be filled.</h3>";
			$core->data['error_field'] = 'sinopsis';
		} else {
			$query = $core->db->query("SELECT id FROM filme WHERE name LIKE '%{$name}%' LIMIT 1")->rows;
			if($query) {
				// verific baza de date pentru a nu introduce duplicate
				$_SESSION['message'] = "<h3>A movie with the same name is allready in the database.</h3>";
			} else {
				$id_gen = "";
				// selectez din baza de date id-urile genurilor
				foreach($gens as $gen) {
					$gen_id = $core->db->query("SELECT id FROM gen WHERE name LIKE '{$gen}'")->rows[0];
					$id_gen .= "," . $gen_id['id'];
				}
				// sterg prima virgula din string
				$id_gen = substr($id_gen, 1);

				// introduc in baza de date filmul
				$catalog->insertMovie($name, $movie_date, $movie_year, $add_date, $sinopsis, $picture, $stoc, $price, $id_gen, $visible);
				$_SESSION['message'] = "<h3>The movie was successfully inserted in the database.</h3>";
				
				// preiau ultimul id introdus in baza de date
				$movie_id = $core->db->getLastID();
				if($movie_id) {
					// daca s-a introdus un film in baza de date eliberez toate variabilele cu care am lucrat
					unset($core->data['name'], $core->data['movie_date'], $core->data['sinopsis'], $core->data['picture'], $core->data['stoc'], $core->data['price']);
					// redirectionez utilizatorul pentru a introduce trailerul pentru filmul introdus
					$catalog->redirect("insert_trailer.php?movie_id={$movie_id}");
				}
			}
		}
	}
} else {
	$catalog->redirect("404.php");
}

echo $core->render();