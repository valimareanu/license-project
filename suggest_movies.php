<?php
require("./library/boot.php");

if(isset($_REQUEST['set_filter'])){

	$filtername = trim($_REQUEST['filter_name']);
	$filtervalue = $_REQUEST['filter_value'];
	$_SESSION[$filtername] = $filtervalue;

} else {
	if(isset($_SESSION['actor']) && is_array($_SESSION['actor']) && count($_SESSION['actor'])) {
		foreach($_SESSION['actor'] as $actor) {
			// despart numele in doua pentru ca apoi sa fie introdus in $first_name si $last_name
			$arr = explode(" ", $actor, 2);
			if(isset($arr[0])) {$first_name_a = $arr[0];} else {$first_name_a = null;}
			if(isset($arr[1])) {$last_name_a = $arr[1];} else {$last_name_a = null;}
			// preiau id-ul actorilor selectati
			$actor_id = $core->db->query("SELECT id FROM actor WHERE first_name LIKE '%{$first_name_a}%' AND last_name LIKE '%{$last_name_a}%' LIMIT 1")->rows[0];
			$actor_i = $actor_id['id'];
		}
	}
	if(isset($_SESSION['director']) && is_array($_SESSION['director']) && count($_SESSION['director'])) {
		foreach($_SESSION['director'] as $director) {
			// despart numele in doua pentru ca apoi sa fie introdus in $first_name si $last_name
			$arr = explode(" ", $director, 2);
			if(isset($arr[0])) {$first_name_d = $arr[0];} else {$first_name_d = null;}
			if(isset($arr[1])) {$last_name_d = $arr[1];} else {$last_name_d = null;}
			// preiau id-ul regizorilor selectati
			$director_id = $core->db->query("SELECT id FROM regizor WHERE first_name LIKE '%{$first_name_d}%' AND last_name LIKE '%{$last_name_d}%' LIMIT 1")->rows[0];
			$director_i = $director_id['id'];
		}
	}

	if(isset($_SESSION['gen']) && is_array($_SESSION['gen']) && count($_SESSION['gen'])) {
		foreach ($_SESSION['gen'] as $gen) {
			$gen_id = $core->db->query("SELECT id FROM gen WHERE name LIKE '%{$gen}%'")->rows[0];
			$gen_i = $gen_id['id'];
		}
	}

	$sql = "SELECT f.*  FROM filme AS f";
	if(isset($actor_id)) {
		$sql .= ' INNER JOIN actor_film AS a_f  
			ON f.id = a_f.filme_id  
			INNER JOIN actor AS a  
			ON a_f.actor_id = a.id'; 
	}
	if(isset($director_id)) {
		$sql .= ' INNER JOIN regizor_film AS r_f 
			ON f.id = r_f.filme_id 
			INNER JOIN regizor AS r 
			ON r_f.regizor_id = r.id'; 
	}
	$sql .= " WHERE f.name LIKE '%" . mysql_real_escape_string($_REQUEST['term']) ."%' ";
	if(isset($director_id)) {
		$sql .= " AND r.id=" . $director_i; 
	} 
	if(isset($actor_id)) {
		$sql .= " AND a.id=" . $actor_i;
	}
	if(isset($_SESSION['year']) && is_array($_SESSION['year']) && count($_SESSION['year'])){
		$sql .= " AND f.movie_year IN (" . implode(",", $_SESSION['year']) . ")";
	}
	if(isset($gen_id)) {
		$sql .= " AND find_in_set(" . $gen_i . ",id_gen)";
	}
	$sql .= " ORDER BY name ASC LIMIT 0,10";

	$search_value = "";
	if($core->db->query($sql)->num_rows != 0) {
		$query_movie = $core->db->query($sql)->rows;
	} 
	unset($sql);
	$sql = "SELECT * FROM actor WHERE first_name LIKE '%".mysql_real_escape_string($_REQUEST['term'])."%' OR last_name LIKE '%".mysql_real_escape_string($_REQUEST['term'])."%'";
	if($core->db->query($sql)->num_rows != 0) {
		$query_actor = $core->db->query($sql)->rows;
	}
	 
	unset($sql);
	$sql = "SELECT * FROM regizor WHERE first_name LIKE '%".mysql_real_escape_string($_REQUEST['term'])."%' OR last_name LIKE '%".mysql_real_escape_string($_REQUEST['term'])."%'";
	if($core->db->query($sql)->num_rows != 0) {
		$query_director = $core->db->query($sql)->rows;
	} 
	
	$data = array();
	
	if(!empty($query_movie)) {
		foreach($query_movie as $row) {
			$data[] = array(
		       	'label' => "<img style='width:40px;height:55px;vertical-align:middle' src='/yourcinema/assets/movies/" . $row['picture'] . "'> <span style=''>" . $row['name'] . "</span>",
		        'value' => $row['name'],
		        'url' => "film.php?movie_id=".$row['id']
		    );
		}
	}

	if(!empty($query_actor)) {
		foreach($query_actor as $row) {
			$data[] = array(
		       	'label' => "<img style='width:40px;height:55px;vertical-align:middle' src='/yourcinema/assets/actors/" . $row['picture'] . "'> <span style=''>" . $row['first_name'] . " " . $row['last_name'] . "</span>",
		        'value' => $row['first_name'] . " " . $row['last_name'],
		        'url' => "actor.php?actor_id=".$row['id']
		    );
		}
	}

	if(!empty($query_director)) {
		foreach($query_director as $row) {
			$data[] = array(
		       	'label' => "<img style='width:40px;height:55px;vertical-align:middle' src='/yourcinema/assets/directors/" . $row['picture'] . "'> <span style=''>" . $row['first_name'] . " " . $row['last_name'] . "</span>",
		        'value' => $row['first_name'] . " " . $row['last_name'],
		        'url' => "director.php?director_id=".$row['id']
		    );
		}
	}

	echo json_encode($data);
	flush();
}