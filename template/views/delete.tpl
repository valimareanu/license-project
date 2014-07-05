<!--  -->
<?php include(SITE_PATH . "template/_header.php"); ?>
<div class="wrapper">

	<!-- daca exista erori in $_SESSION[''] sunt afisate apoi este eliberata variabila pentru a nu fi afisata aceeasi eroare pe mai multe pagini -->
	<?php if(isset($_SESSION['message'])) {echo "<img src='/yourcinema/template/icons/error.png'><font color='red'>".
	$_SESSION['message']."</font>";unset($_SESSION['message']); } ?>


</div>
<?php include(SITE_PATH . "template/_footer.php"); ?>