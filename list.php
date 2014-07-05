<?php
require("./library/boot.php");

$core->template = "list";
$core->data['title'] = "Your list - " . site_name;

$core->data['movie_list'] = array();
if($user->isLogged()) {
	if(isset($_GET['movie_id']) && intval($_GET['movie_id']) && $_GET['action'] == "like") {
		$movie_id = intval($_GET['movie_id']);
		$user_id = intval($_SESSION['user_id']);
		$movie_name = $core->db->query("SELECT name FROM filme WHERE id={$movie_id}")->rows[0];
		$query = $core->db->query("SELECT * FROM filme_favorite WHERE filme_id={$movie_id} AND user_id={$user_id}")->rows;
		if(!$query) {
			$core->db->query("DELETE FROM filme_detestate WHERE filme_id={$movie_id} AND user_id={$user_id}");
			$core->db->query("DELETE FROM filme_de_vazut WHERE filme_id={$movie_id} AND user_id={$user_id}");
			$core->db->query("INSERT INTO filme_favorite (filme_id, user_id) VALUES ({$movie_id}, {$user_id})");
			$_SESSION['message'] = "This movie ". $movie_name['name'] . " was added in the movies that i like list.";
		} else {
			$_SESSION['message'] = "This movie " . $movie_name['name'] . " was allready in the movies that i like list.";
			$catalog->redirect("film.php?movie_id=".$movie_id);
		}
		$catalog->redirect("list.php?action=like");
	}

	if(isset($_GET['movie_id']) && intval($_GET['movie_id']) && $_GET['action'] == "to_see") {
		$movie_id = intval($_GET['movie_id']);
		$user_id = $_SESSION['user_id'];
		$movie_name = $core->db->query("SELECT name FROM filme WHERE id={$movie_id}")->rows[0];
		$query = $core->db->query("SELECT * FROM filme_de_vazut WHERE filme_id={$movie_id} AND user_id={$user_id}")->rows;
		if(!$query) {
			$core->db->query("DELETE FROM filme_detestate WHERE filme_id={$movie_id} AND user_id={$user_id}");
			$core->db->query("DELETE FROM filme_favorite WHERE filme_id={$movie_id} AND user_id={$user_id}");
			$core->db->query("INSERT INTO filme_de_vazut (filme_id, user_id) VALUES ({$movie_id}, {$user_id})");
			$_SESSION['message'] = "The movie " . $movie_name['name'] . " was added in the movies that i need to see list.";
		} else {
			$_SESSION['message'] = "The movie " . $movie_name['name'] . " was allready in the movies that i need to see list.";
			$catalog->redirect("film.php?movie_id=".$movie_id);
		}
		$catalog->redirect("list.php?action=to_see");
	}

	if(isset($_GET['movie_id']) && intval($_GET['movie_id']) && $_GET['action'] == "hate") {
		$movie_id = intval($_GET['movie_id']);
		$user_id = $_SESSION['user_id'];
		$movie_name = $core->db->query("SELECT name FROM filme WHERE id={$movie_id}")->rows[0];
		$query = $core->db->query("SELECT * FROM filme_detestate WHERE filme_id={$movie_id} AND user_id={$user_id}")->rows;
		if(!$query) {
			$core->db->query("DELETE FROM filme_favorite WHERE filme_id={$movie_id} AND user_id={$user_id}");
			$core->db->query("DELETE FROM filme_de_vazut WHERE filme_id={$movie_id} AND user_id={$user_id}");
			$core->db->query("INSERT INTO filme_detestate (filme_id, user_id) VALUES ({$movie_id}, {$user_id})");
			$_SESSION['message'] = "The movie " . $movie_name['name'] . " was added in the movies that i hate list.";
		} else {
			$_SESSION['message'] = "The movie " . $movie_name['name'] . " was allready in the movies that i hate list.";
			$catalog->redirect("film.php?movie_id=".$movie_id);
		}
		$catalog->redirect("list.php?action=hate");
	}

	// 1. the current page number ($current_page)
	$page = !empty($_GET['page']) ? (int)$_GET['page'] : 1;
	// 2. records per page ($per_page)
	$per_page = 5;
	// 3. total record count ($total_count)

	if(isset($_GET['action']) && $_GET['action'] == "like") {
		$query = "SELECT * FROM filme AS f
					INNER JOIN filme_favorite AS f_f 
					ON f.id=f_f.filme_id
					WHERE f_f.user_id=" . intval($_SESSION['user_id']);
		$total_count = $core->db->query($query)->num_rows;
		$pagination = new Pagination($page, $per_page, $total_count);
		$core->data['pagination'] = @$pagination;
		$core->data['page'] = @$page;
		$query .= " LIMIT {$pagination->offset()}, {$per_page}";
		$core->data['movie_list'] = $core->db->query($query)->rows;
	}

	if(isset($_GET['action']) && $_GET['action'] == "to_see") {
		$query = "SELECT * FROM filme AS f
					INNER JOIN filme_de_vazut AS f_d_v 
					ON f.id=f_d_v.filme_id
					WHERE f_d_v.user_id=" . intval($_SESSION['user_id']);
		$total_count = $core->db->query($query)->num_rows;
		$pagination = new Pagination($page, $per_page, $total_count);
		$core->data['pagination'] = @$pagination;
		$core->data['page'] = @$page;
		$query .= " LIMIT {$pagination->offset()}, {$per_page}";
		$core->data['movie_list'] = $core->db->query($query)->rows;
	}

	if(isset($_GET['action']) && $_GET['action'] == "hate") {
		$query = "SELECT * FROM filme AS f
					INNER JOIN filme_detestate AS f_d 
					ON f.id=f_d.filme_id
					WHERE f_d.user_id=" . intval($_SESSION['user_id']);
		$total_count = $core->db->query($query)->num_rows;
		$pagination = new Pagination($page, $per_page, $total_count);
		$core->data['pagination'] = @$pagination;
		$core->data['page'] = @$page;
		$query .= " LIMIT {$pagination->offset()}, {$per_page}";
		$core->data['movie_list'] = $core->db->query($query)->rows;
	}
}

echo $core->render();