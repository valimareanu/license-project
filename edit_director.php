<?php
require("./library/boot.php");

// titlul site-ului si template-ul pe care il foloseste
$core->data['title'] = e("Edit director - ", false) . site_name;
$core->template = "insert_director";

$core->data['edit'] = "edit";

if($user->isAdmin()) {
	// se preiau datele despre regizor
	if(isset($_GET['director_id']) && intval($_GET['director_id'])) {
		// se preia id-ul filmului
		$id = trim(mysql_real_escape_string($_GET['director_id']));
		$director = $catalog->selectFromTableWhere('regizor', 'id', $id, 1);

		// preiau restul datelor despre regizor
		$core->data['first_name'] = $director['first_name'];
		$core->data['last_name'] = $director['last_name'];
		$core->data['birth_date'] = $director['birth_date'];
		$core->data['birth_place'] = $director['birth_place'];
		$core->data['country'] = $director['country'];
		$core->data['biography'] = $director['biography'];
		$core->data['picture'] = $director['picture'];
	}

	// se verifica daca a fost sau nu dat submit de la insert_director.tpl
	if (isset($_POST['submit'])) {
		// se preiau valorile din post mai intai asigurandu-ma ca sunt procesate si apoi sunt introduse in $core->data[] pentru a avea access la ele si in insert_director.tpl

		// verific daca $_POST[] a fost schimbat sau nu, daca $_POST[] este acelasi cu datele din baza de date variabilele sunt puse null penru a nu fi introduse in UPDATE
		if(trim(mysql_real_escape_string($_POST['first_name'])) !== $director['first_name']) {
			$core->data['first_name'] = $first_name = trim(mysql_real_escape_string($_POST['first_name'])); 
		} else {
			$first_name = null;
		}
		if(trim(mysql_real_escape_string($_POST['last_name'])) !== $director['last_name']) {
			$core->data['last_name'] = $last_name = trim(mysql_real_escape_string($_POST['last_name']));
		} else {
			$last_name = null;
		}
		if(trim(mysql_real_escape_string($_POST['birth_place'])) !== $director['birth_place']) {
			$core->data['birth_place'] = $birth_place = trim(mysql_real_escape_string($_POST['birth_place']));
		} else {
			$birth_place = null;
		}
		if(trim(mysql_real_escape_string($_POST['birth_date'])) !== $director['birth_date']) {
			$core->data['birth_date'] = $birth_date = trim(mysql_real_escape_string($_POST['birth_date']));
		} else {
			$birth_date = null;
		}
		if(trim(mysql_real_escape_string($_POST['birth_place'])) !== $director['birth_place']) {
			$core->data['birth_place'] = $birth_place = trim(mysql_real_escape_string($_POST['birth_place']));
		} else {
			$birth_place = null;
		}
		if(trim(mysql_real_escape_string($_POST['country'])) !== $director['country']) {
			$core->data['country'] = $country = trim(mysql_real_escape_string($_POST['country']));
		} else {
			$country = null;
		}
		if(trim(mysql_real_escape_string($_POST['biography'])) !== $director['biography']) {
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
		if(!empty($picture) && ($picture !== $director['picture'])) {
			if($director['picture'] != "all.jpg") {
				unlink(SITE_PATH . "assets\\directors\\{$director['picture']}");
			}
		}
		

		// introduc in baza de date filmul, excluzand variabilele care sunt empty
		$query = " id=" . $id; 
		if(!empty($first_name)) {$query .= ", first_name='" . $first_name . "'"; }  
		if(!empty($last_name)) {$query .= ", last_name='" . $last_name . "'";} 
		if(!empty($birth_place)) {$query .= ", birth_place='" . $birth_place . "'"; } 
		if(!empty($birth_date)) {$query .= ", birth_date='" . $birth_date . "'"; } 
		if(!empty($country)) {$query .= ", country='" . $country . "'";} 
		if(!empty($biography)) {$query .= ", biography='" . $biography . "'"; } 
		if(!empty($picture)) {$query .= ", picture='" . $picture  . "'"; } 
		$core->db->query("UPDATE regizor SET {$query} WHERE id={$id}");
		$_SESSION['message'] = "<h3>The director was successfully updated.</h3>";
	}
} else {
	$catalog->redirect("404.php");
}


echo $core->render();