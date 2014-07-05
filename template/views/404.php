<?php
	// pagina de erori, afisez de obicei 404 Page Not Found, sau daca trebuie, afisez un mesaj complet
	if(isset($_GET['1'])) {
		echo "This account was not activated. Please check your email (even Spam) for the activation link";
	} elseif(isset($_GET['0'])) {
		echo 'This account is allready activated.';
	} elseif(isset($_GET['-1'])) {
		echo 'This account is suspended.';
	} elseif(isset($_GET['-2'])) {
		echo 'The activation link is invalid. Please contact the administrator.';
	} elseif(isset($_GET['-3'])) {
		echo 'An error has occured. Please contact the administrator.';
	} else {
		echo "404 Page Not Found";
	}
?>