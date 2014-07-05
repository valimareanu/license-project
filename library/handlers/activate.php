<?php 
	
	// daca utilizatorul a primit linkul de validare prin email acesta este un redirect catre aceasta pagina continand email si token
	if(isset($_GET['action']) && $_GET['action'] == 'activation' && isset($_GET['email']) && isset($_GET['token'])) {
		$email = trim(mysql_real_escape_string($_GET['email']));
		$token = trim(mysql_real_escape_string($_GET['token']));
		// verific daca emailul si tokenul sunt bune
		$active = $user->activateAccount($email, $token);
		// daca sunt bune redirectionez utilizatorul
		if($active == 1) {
			// contul a fost activat redirectionez userul catre pagina de log in pentru a se loga
			$catalog->redirect('user.php?sign_in=1');
			// daca nu atunci redirectionez utilizatorul catre 404 afisand si un mesaj care ii explica ce s-a intamplat gresit
		} elseif($active == 0) {
			$catalog->redirect('template/views/404.php?id=0');
		} elseif($active == -1) {
			$catalog->redirect('template/views/404.php?id=-1');
		} elseif($active == -2) {
			$catalog->redirect('template/views/404.php?id=-2');
		} elseif ($active == -3) {
			$catalog->redirect('template/views/404.php?id=-3');
		}
	} 