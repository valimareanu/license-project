<?php
require("./library/boot.php");

// titlul site-ului si template-ul pe care il foloseste
$core->data['title'] = e("Delete - ", false) . site_name;
$core->template = "delete";

if($user->isAdmin()) {
	// sterg filmul cu id-ul trimis prin $_GET[]
	if((isset($_GET['movie_id']) && intval($_GET['movie_id'])) && (isset($_GET['action']) && $_GET['action'] == "movie")) {
		$id = intval($_GET['movie_id']);
		//$movie = $core->db->query("SELECT * FROM filme WHERE id={$id}")->rows[0];
		$movie = $catalog->selectFromTableWhere('filme', 'id', $id, 1);
		if(!empty($movie)) {
			//$core->db->query("DELETE FROM filme WHERE id={$id}");
			$catalog->deleteFromTable('filme', "id = $id");
			//$core->db->query("DELETE FROM ratings WHERE id={$id}");
			$catalog->deleteFromTable('ratings', "id = $id");
			//$core->db->query("DELETE FROM actor_film WHERE filme_id={$id}");
			$catalog->deleteFromTable('actor_film', "filme_id = $id");
			//$core->db->query("DELETE FROM regizor_film WHERE filme_id={$id}");
			$catalog->deleteFromTable('regizor_film', "filme_id = $id");
			//$core->db->query("DELETE FROM trailer WHERE filme_id={$id}");
			$catalog->deleteFromTable('trailer', "filme_id = $id");
			$_SESSION['message'] = "The movie {$movie['name']} was successfully deleted.";
			if($movie['picture'] != "all.jpg") {
				unlink(SITE_PATH . "assets\\movies\\{$movie['picture']}");
			}
		}
	}

	// sterg regizorul cu id-ul trimis prin $_GET[]
	if((isset($_GET['director_id']) && intval($_GET['director_id'])) && (isset($_GET['action']) && $_GET['action'] == "director")) {
		$id = intval($_GET['director_id']);
		//$director = $core->db->query("SELECT * FROM regizor WHERE id={$id}")->rows[0];
		$director = $catalog->selectFromTableWhere('regizor', 'id', $id, 1);
		if(!empty($director)) {
			//$core->db->query("DELETE FROM regizor WHERE id={$id}");
			$catalog->deleteFromTable('regizor', "id = $id");
			//$core->db->query("DELETE FROM regizor_film WHERE regizor_id={$id}");
			$catalog->deleteFromTable('regizor_film', "regizor_id = $id");
			$_SESSION['message'] = "The director {$director['first_name']} {$director['last_name']} was successfully deleted.";
			if($director['picture'] != "all.jpg") {
				unlink(SITE_PATH . "assets\\directors\\{$director['picture']}");
			}
		}
	}

	// sterg actorul cu id-ul trimis prin $_GET[]
	if((isset($_GET['actor_id']) && intval($_GET['actor_id'])) && (isset($_GET['action']) && $_GET['action'] == "actor")) {
		$id = intval($_GET['actor_id']);
		//$actor = $core->db->query("SELECT * FROM actor WHERE id={$id}")->rows[0];
		$actor = $catalog->selectFromTableWhere('regizor', 'id', $id, 1);
		if(!empty($actor)) {
			//$core->db->query("DELETE FROM actor WHERE id={$id}");
			$catalog->deleteFromTable('actor', "id = $id");
			//$core->db->query("DELETE FROM actor_film WHERE actor_id={$id}");
			$catalog->deleteFromTable('actor_film', "actor_id = $id");
			$_SESSION['message'] = "<h3>The actor {$actor['first_name']} {$actor['last_name']} was successfully deleted.</h3>";
			if($actor['picture'] != "all.jpg") {
				unlink(SITE_PATH . "assets\\actors\\{$actor['picture']}");
			}
		}
	}

	// sterg trailerul cu id-ul trimis prin $_GET[]
	if ((isset($_GET['trailer_id']) && intval($_GET['trailer_id'])) && (isset($_GET['action']) && $_GET['action'] == "trailer")) {
		$id = intval($_GET['trailer_id']);
		//$core->data->query("DELETE FROM trailer WHERE id={$id}");
		$catalog->deleteFromTable('trailer', "id = $id");
		$_SESSION['mesage'] = "<h3>The trailer with id {$id} was successfully deleted.</h3>";
	}

	// sterg legatura dintre regizor si film
	if((isset($_GET['director_id']) && intval($_GET['director_id'])) && (isset($_GET['movie_id']) && intval($_GET['movie_id'])) &&
		(isset($_GET['action']) && $_GET['action'] == "moviedirector")) {
		$d_id = intval($_GET['director_id']);
		$m_id = intval($_GET['movie_id']);
		//$core->db->query("DELETE FROM regizor_film WHERE regizor_id={$d_id} AND filme_id={$m_id}");
		$catalog->deleteFromTable('regizor_film', $filters = array("regizor_id = $d_id", "filme_id = $m_id"));
		$catalog->redirect("film.php?movie_id=" . $m_id);
	}

	// sterg legatura dintre actor si film
	if((isset($_GET['actor_id']) && intval($_GET['actor_id'])) && (isset($_GET['movie_id']) && intval($_GET['movie_id'])) &&
		(isset($_GET['action']) && $_GET['action'] == "movieactor")) {
		$a_id = intval($_GET['actor_id']);
		$m_id = intval($_GET['movie_id']);
		//$core->db->query("DELETE FROM actor_film WHERE actor_id={$a_id} AND filme_id={$m_id}");
		$catalog->deleteFromTable('actor_film', $filters = array("actor_id = $a_id", "filme_id = $m_id"));
		$catalog->redirect("film.php?movie_id=" . $m_id);
	}

	// sterg commentul
	if((isset($_GET['comment_id']) && intval($_GET['comment_id'])) && (isset($_GET['action']) && $_GET['action'] == "comment")) {
		$id = intval($_GET['comment_id']);
		//$core->db->query("DELETE FROM comments WHERE id=".$_GET['comment_id']);
		$catalog->deleteFromTable('comments', "id = $id"));
		if(isset($_GET['movie_id']) && intval($_GET['movie_id']))
			$catalog->redirect("film.php?movie_id=" .$_GET['movie_id']);
		} elseif(isset($_GET['actor_id']) && intval($_GET['actor_id'])) {
			$catalog->redirect("actor.php?actor_id=" .$_GET['actor_id']);
		} elseif(isset($_GET['director_id']) && intval($_GET['director_id'])) {
			$catalog->redirect("director.php?director_id=" .$_GET['director_id']);
		}
	}
} else {
	$catalog->redirect("404.php");
}

echo $core->render();