<?php 
	if(isset($_POST['login'])) {
		// se preiau datele utilizatorului
		$core->data['username'] = $username = trim(mysql_real_escape_string($_POST['username']));
		$password = trim(mysql_real_escape_string($_POST['password']));

		// se verifica daca parola si numele utilizatorului sunt valide
		$login = $user->login($username, $password);
		if($login === true) {
			// daca utilizatorul s-a logat atunci va fi redorectionat catre pagina profilului
			$catalog->redirect('user.php');
		} elseif($login == "pending") {
			// daca contul utilizatorului are statusul pending atunci este redirectionat catre pagina de eroare afisand un mesaj in care i 
			// se explica ce trebuie sa faca
			$catalog->redirect('template/views/404.php?1');
		} elseif($login == "banned") {
			// daca contul utilizatorului are statusul banned atunci este redirectionat catre pagina de eroare afisand un mesaj in care i 
			// se explica ce trebuie sa faca
			$catalog->redirect('template/views/404.php?-1');
		} else {
			// i se transmite utilizatorului ca se poate sa fi introdus parola sau numele gresit
			$_SESSION['message'] = "Username or password was incorect.";
		}
	}	