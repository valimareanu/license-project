<?php
require("./library/boot.php");

// titlul site-ului si template-ul pe care il foloseste
$core->data['title'] = e("Edit actor - ", false) . site_name;
$core->template = "insert_actor";

$core->data['edit'] = "edit";

if($user->isAdmin()) {
	// se preiau datele despre actor
	if(isset($_GET['actor_id']) && intval($_GET['actor_id'])) {
		// se preia id-ul filmului
		$id = trim(mysql_real_escape_string($_GET['actor_id']));
		$actor = $catalog->selectFromTableWhere('actor', 'id', $id, 1);

		// fac accesibile datele actorului si pentru edit_actor.tpl
		$core->data['first_name'] = $actor['first_name'];
		$core->data['last_name'] = $actor['last_name'];
		$core->data['birth_date'] = $actor['birth_date'];
		$core->data['birth_place'] = $actor['birth_place'];
		$core->data['country'] = $actor['country'];
		$core->data['biography'] = $actor['biography'];
		$core->data['picture'] = $actor['picture'];
	} else {
		$catalog->redirect('404.php');
	}

	// se verifica daca a fost sau nu dat submit de la insert_actor.tpl
	if (isset($_POST['submit'])) {
		// se preiau valorile din post mai intai asigurandu-ma ca sunt procesate si apoi sunt introduse in $core->data[] pentru a avea access la ele si in insert_actor.tpl

		// verific daca $_POST[] a fost schimbat sau nu, daca $_POST[] este acelasi cu datele din baza de date variabilele sunt puse null penru a nu fi introduse in UPDATE
		if(trim(mysql_real_escape_string($_POST['first_name'])) !== $actor['first_name']) {
			$core->data['first_name'] = $first_name = trim(mysql_real_escape_string($_POST['first_name'])); 
		} else {
			$first_name = null;
		}
		if(trim(mysql_real_escape_string($_POST['last_name'])) !== $actor['last_name']) {
			$core->data['last_name'] = $last_name = trim(mysql_real_escape_string($_POST['last_name']));
		} else {
			$last_name = null;
		}
		if(trim(mysql_real_escape_string($_POST['birth_place'])) !== $actor['birth_place']) {
			$core->data['birth_place'] = $birth_place = trim(mysql_real_escape_string($_POST['birth_place']));
		} else {
			$birth_place = null;
		}
		if(trim(mysql_real_escape_string($_POST['birth_date'])) !== $actor['birth_date']) {
			$core->data['birth_date'] = $birth_date = trim(mysql_real_escape_string($_POST['birth_date']));
		} else {
			$birth_date = null;
		}
		if(trim(mysql_real_escape_string($_POST['birth_place'])) !== $actor['birth_place']) {
			$core->data['birth_place'] = $birth_place = trim(mysql_real_escape_string($_POST['birth_place']));
		} else {
			$birth_place = null;
		}
		if(trim(mysql_real_escape_string($_POST['country'])) !== $actor['country']) {
			$core->data['country'] = $country = trim(mysql_real_escape_string($_POST['country']));
		} else {
			$country = null;
		}
		if(trim(mysql_real_escape_string($_POST['biography'])) !== $actor['biography']) {
			$core->data['biography'] = $biography = trim(mysql_real_escape_string($_POST['biography']));
		} else {
			$biography = null;
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
		if(!empty($picture) && ($picture !== $actor['picture'])) {
			if($actor['picture'] != "all.jpg") {
				unlink(SITE_PATH . "assets\\actors\\{$actor['picture']}");
			}
		}
		

		// introduc in baza de date filmul, excluzand variabilele care nu sunt modificate
		$query = " id=" . $id; 
		if(!empty($first_name)) {$query .= ", first_name='" . $first_name . "'"; }  
		if(!empty($last_name)) {$query .= ", last_name='" . $last_name . "'";} 
		if(!empty($birth_place)) {$query .= ", birth_place='" . $birth_place . "'"; } 
		if(!empty($birth_date)) {$query .= ", birth_date='" . $birth_date . "'"; } 
		if(!empty($country)) {$query .= ", country='" . $country . "'";} 
		if(!empty($biography)) {$query .= ", biography='" . $biography . "'"; } 
		if(!empty($picture)) {$query .= ", picture='" . $picture  . "'"; } 
		$core->db->query("UPDATE actor SET {$query} WHERE id={$id}");
		$_SESSION['message'] = "<h3>The actor was successfully updated.</h3>";
	}
} else {
	$catalog->redirect("404.php");
}


echo $core->render();