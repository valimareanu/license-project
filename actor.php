<?php
require("./library/boot.php");

// daca nu am id-ul actorului atunci aceasta pagina nu o sa fie afisata
if(!isset($_GET['actor_id']) || !intval($_GET['actor_id'])) {
	include('./template/views/404.php');
	die();
}

// numele templateului pe care il foloseste acest controller
$core->template = "actor";

// memorez in $actor datele despre actorul cu id-ul preluat din $_GET['']
$actor_data = $catalog->selectFromTableWhere('actor', 'id', $_GET['actor_id'], 1);
// daca id-ul preluat din $_GET[''] nu exista in baza de date atunci voi redirectiona catre pagina de eroare
if(empty($actor_data)) {$catalog->redirect('404.php');}
// preiau filmele in care a jucat acest actor
$actor_movies = $catalog->selectWithDoubleInnerJoin($_GET['actor_id'], 'filme', 'actor_film', 'actor');
if(!empty($actor_movies)) {
	$actor_aka = $core->db->query("SELECT aka FROM actor_film WHERE actor_id=".$actor_data['id']." AND filme_id=".$actor_movies[0]['id'])->rows[0];
	$actor_movies[0]['aka'] = $actor_aka['aka'];
}
// preiau comenturile pentru acest film, pentru coment imi trebuie si poza utilizatorului asa ca trebuie sa fac JOIN cu tabelul users,
// in users a trebuit sa fac un rand cu id-ul 0 deoarece un utilizator poate sa lase coment chiar daca nu este logat, acesta avand user_id=0,
// pentru ca atunci cand fac JOIN sa poata sa fie selectate si comenturile care sunt lasati de utilizatori nelogati
$comments = $core->db->query("SELECT c.*, u.picture FROM comments AS c JOIN users AS u ON c.user_id=u.id WHERE actor_id=".$_GET['actor_id']." ORDER BY c.add_date")->rows;
// fac disponibile datele preluate din baza de date si pentru template
$core->data['actor_data'] = &$actor_data;
$core->data['actor_movies'] = &$actor_movies;
$core->data['comments'] = &$comments;
$core->data['title'] = e($actor_data['first_name'] . ' ' . $actor_data['last_name'], false) . " - " . site_name;

// preiau datele despre comment din $_POST[''] si le introduc in baza de date
if(isset($_POST['submit'])) {
	// este initializat $insert_comment cu true, daca ramane asa pana la insert atunci comentul o sa fie introdus in baza de date
	$insert_comment = true;
	// preiau id-ul actorului
	if(isset($_GET['actor_id']) && intval($_GET['actor_id'])) {
		$id = intval($_GET['actor_id']);
	}
	if(empty($_POST['name'])) {
		// daca numele este gol sunt 2 posibilitati acesta este logat si in acest caz preiau numele si id-ul din $_SESSION
		// sau utilizatorul nu a vrut sa lase numele
		$name = $_SESSION['username'];
		$user_id = $_SESSION['user_id'];
	} else {
		$core->data['name'] = $name = trim(mysql_real_escape_string($_POST['name']));
	}
	if(empty($_POST['comment'])) {
		// daca nu este scris nimic in coment atunci nu am ce sa inserez deci ii transmit utilizatorului ca trebuie sa fie completat
		$insert_comment = false;
		$_SESSION['message'] = "Please write something in the comment section.";
	} else {
		// este procesat comentul
		$core->data['comment'] = $comment = trim(mysql_real_escape_string($_POST['comment']));
	}
	// este adaugata data
	$add_date = strftime("%Y-%m-%d %H:%M:%S", time());
	// se verifica daca se poate introduce commentul
	if($insert_comment == true) {
		// se verifica daca comentul a mai fost introdus, pentru a nu avea duplicate
		//$query1 = $core->db->query("SELECT * FROM comments WHERE author LIKE '%{$name}%' AND comment LIKE '%{$comment}%'")->rows;
		$query1 = $catalog->selectFromTableWhereLike('comments', 'author', $name, 'comment', $comment);
		if(empty($query1)) {
			if($user->isLogged()) {
				// daca utilizatorul este logat atunci introduc si user_id
				$core->db->query("INSERT INTO comments (user_id, actor_id, author, comment, add_date) VALUES ({$user_id}, {$id}, '{$name}', '{$comment}', '{$add_date}')");
				// eliberez variabilele pentru a nu mai fi autocompletate in template
				unset($add_date, $core->data['name'], $core->data['comment']);
			} else {
				// daca utilizatorul nu este logat atunci user_id o sa fie 0
				$core->db->query("INSERT INTO comments (actor_id, author, comment, add_date) VALUES({$id}, '{$name}', '{$comment}', '{$add_date}')");
				// eliberez variabilele pentru a nu mai fi autocompletate in template
				unset($add_date, $core->data['name'], $core->data['comment']);
			}
			$catalog->redirect("actor.php?actor_id={$id}");
		} else {
			// daca comentul exista in baza de date anunt utilizatorul si eliberez variabilele
			$_SESSION['message'] = "You have allready posted this comment.";
			unset($add_date, $core->data['name'], $core->data['comment']);
		}
	}
}

// preiau $_POST[''] pentru edit comment
if(isset($_POST['edit_submit'])) {
	// este initializat $insert_comment cu true, daca ramane asa pana la insert atunci comentul o sa fie introdus in baza de date
	$insert_comment = true;
	// preiau id-ul actorului
	if(isset($_GET['actor_id']) && intval($_GET['actor_id'])) {
		$id = intval($_GET['actor_id']);
	}
	if(isset($_GET['comment_id']) && intval($_GET['comment_id'])) {
		$comment_id = intval($_GET['comment_id']);
	}
	if(strlen(trim($_POST['comment'])) == 0) {
		// daca nu este scris nimic in coment atunci nu am ce sa inserez deci ii transmit utilizatorului ca trebuie sa fie completat
		$insert_comment = false;
		$_SESSION['message'] = "Please write something in the comment section.";
	} else {
		// este procesat comentul
		$core->data['comment'] = $comment = trim(mysql_real_escape_string($_POST['comment']));
	}
	// este reintrodusa data
	$add_date = strftime("%Y-%m-%d %H:%M:%S", time());
	// se verifica daca se poate introduce commentul
	if($user->isLogged() && $insert_comment == true) { 
		if($user->isAdmin()) {
			$comment .= "edited by ".$_SESSION['username'];
		} 
		$core->db->query("UPDATE comments SET comment='{$comment}', add_date='{$add_date}' WHERE id={$comment_id}");
		unset($add_date, $core->data['name'], $core->data['comment']);
		$catalog->redirect("actor.php?actor_id={$id}");
	}
}

// posibilitatea de editare a comentului
if(isset($_GET['comment_id']) && intval($_GET['comment_id'])) {
	if($user->isLogged()) {
		// ca sa nu trebuiasca sa trimit user_id prin $_GET[''] preiau id-ul utilizatorului care a scris commentul acesta
		// si il verific cu id-ul utilizatorului logat, daca se potrivesc atunci utilizatorul isi poate edita comentul
		$edit_comment = $core->db->query("SELECT * FROM comments WHERE id=".$_GET['comment_id'])->rows[0];
		if($edit_comment['user_id'] == $_SESSION['user_id']) {
			$core->data['edit_comment'] = $edit_comment;
		} elseif($user->isAdmin()) {
			$core->data['edit_comment'] = $edit_comment;
		}
	}
}

echo $core->render();