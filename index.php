<?php
require("./library/boot.php");

$core->data['title'] = site_name;

$core->template = "home";

// 1. the current page number ($current_page)
$page = !empty($_GET['page']) ? (int)$_GET['page'] : 1;
// 2. records per page ($per_page)
$per_page = 5;
// 3. total record count ($total_count)
$total_count = $catalog->count();

$pagination = new Pagination($page, $per_page, $total_count);
$core->data['pagination'] = @$pagination;
$core->data['page'] = @$page;

$core->data['new_products'] = @$catalog->fetchNewProducts($per_page, $pagination->offset());
//$core->data['products_from_category'] = $catalog->productsFromCategory(1, 12);

if(isset($_POST['submit_s'])) {
	$search = trim(mysql_real_escape_string($_POST['search']));
	if(isset($_POST['s_gen'])) $gens = $_POST['s_gen'];
	if(isset($_POST['s_actor'])) $actors = $_POST['s_actor'];
	if(isset($_POST['s_director'])) $directors = $_POST['s_director'];
	if(isset($_POST['s_year'])) $years = $_POST['s_year'];

	if(isset($actors)) {
		foreach($actors as $actor) {
			// despart numele in doua pentru ca apoi sa fie introdus in $first_name si $last_name
			$arr = explode(" ", $actor, 2);
			if(isset($arr[0])) {$first_name_a = $arr[0];} else {$first_name_a = null;}
			if(isset($arr[1])) {$last_name_a = $arr[1];} else {$last_name_a = null;}
			// preiau id-ul actorilor selectati
			$actor_id = $core->db->query("SELECT id FROM actor WHERE first_name LIKE '%{$first_name_a}%' AND last_name LIKE '%{$last_name_a}%' LIMIT 1")->rows[0];
			$actor_i = $actor_id['id'];
		}
	}

	if(isset($directors)) {
		foreach($directors  as $director) {
			// despart numele in doua pentru ca apoi sa fie introdus in $first_name si $last_name
			$arr = explode(" ", $director, 2);
			if(isset($arr[0])) {$first_name_d = $arr[0];} else {$first_name_d = null;}
			if(isset($arr[1])) {$last_name_d = $arr[1];} else {$last_name_d = null;}
			// preiau id-ul regizorilor selectati
			$director_id = $core->db->query("SELECT id FROM regizor WHERE first_name LIKE '%{$first_name_d}%' AND last_name LIKE '%{$last_name_d}%' LIMIT 1")->rows[0];
			$director_i = $director_id['id'];
		}
	}

	if(isset($gens)) {
		foreach ($gens as $gen) {
			$gen_id = $core->db->query("SELECT id FROM gen WHERE name LIKE '%{$gen}%' LIMIT 1")->rows[0];
			$gen_i = $gen_id['id'];
		}
	}

	$query = 'SELECT f.* FROM filme AS f';
	if(isset($actor_id)) {
		$query .= ' INNER JOIN actor_film AS a_f  
			ON f.id = a_f.filme_id  
			INNER JOIN actor AS a  
			ON a_f.actor_id = a.id'; 
	}
	if(isset($director_id)) {
		$query .= ' INNER JOIN regizor_film AS r_f 
			ON f.id = r_f.filme_id 
			INNER JOIN regizor AS r 
			ON r_f.regizor_id = r.id'; 
	}
	$query .= ' WHERE f.name LIKE "%' . $search .'%"';
	if(isset($years)) {
		$query .= " AND f.movie_year IN (" . implode(",", $years) . ")";
	}
	if(isset($director_id)) {
		$query .= " AND r.id=" . $director_i; 
	} 
	if(isset($actor_id)) {
		$query .= " AND a.id=" . $actor_i;
	}
	if(isset($gen_id)) {
		$query .= " AND find_in_set(" . $gen_i . ",id_gen)";
	}
	$query .= ' ORDER BY name ASC LIMIT 0,10';
	$num_movies = $core->db->query($query)->num_rows;
	if($num_movies != 0) {
		$core->data['search_movie'] = $core->db->query($query)->rows;
	} 
	unset($query);
	$arr = explode(" ", $search, 2);
	if(isset($arr[0])) {$first_name_a = $arr[0];} else {$first_name_a = null;}
	if(isset($arr[1])) {$last_name_a = $arr[1];} else {$last_name_a = null;}
	if(isset($first_name_a) && !empty($first_name_a)) {
		$query = "SELECT * FROM actor WHERE first_name LIKE '%".$first_name_a."%'";
	}
	if(isset($last_name_a) && !empty($last_name_a)) {
	 	$query .= " OR last_name LIKE '%".$last_name_a."%'";
	}

	if(!empty($query)) {
		$num_actor = $core->db->query($query)->num_rows;
		if($num_actor != 0) {
			$core->data['search_actor'] = $core->db->query($query)->rows;
		} 
	}
	unset($query);
	$arr = explode(" ", $search, 2);
	if(isset($arr[0])) {$first_name_d = $arr[0];} else {$first_name_d = null;}
	if(isset($arr[1])) {$last_name_d = $arr[1];} else {$last_name_d = null;}
	if(isset($first_name_d) && !empty($first_name_d)) {
		$query = "SELECT * FROM regizor WHERE first_name LIKE '%".$first_name_d."%'";
	}
	if(isset($last_name_d) && !empty($last_name_d)) {
	 	$query .= " OR last_name LIKE '%".$last_name_d."%'";
	}
	
	if(!empty($query)) {
		$num_director = $core->db->query($query)->num_rows;
		if($num_director != 0) {
			$core->data['search_director'] = $core->db->query($query)->rows;
		}
	}
	$_SESSION['movie_name'] = $_POST['search'];
	if($num_movies == 0 && $num_actor == 0 && $num_director == 0) {
		$_SESSION['message'] = "Your search returned 0 results";
	}
}

echo $core->render();