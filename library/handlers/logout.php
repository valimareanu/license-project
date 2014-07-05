<?php 
	// se elibereaza variabila $_SESSION[''] delogand utilizatorul
	if(isset($_GET['logout'])) {
		$user->logout();
	}