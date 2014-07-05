<!--  -->
<?php include(SITE_PATH . "template/_header.php"); ?>
<div class="wrapper">

	<!-- daca exista erori in $_SESSION[''] sunt afisate apoi este eliberata variabila pentru a nu fi afisata aceeasi eroare pe mai multe pagini -->
	<?php if(isset($_SESSION['message'])) {echo "<img src='/yourcinema/template/icons/error.png'><font color='red'>".
	$_SESSION['message']."</font>";unset($_SESSION['message']); } ?>

	<!-- se afiseaza datele despre film -->
	<h3><?php e($film['name']); ?></h3>

	<?php 
		if(isset($trailers)) { ?>
			<?php foreach($trailers as $trailer) {
				if($trailer['id'] == $_GET['trailer_id']) {
					echo $trailer['trailer'] . "<br>";
				}
			}?><br>
			<?php foreach($trailers as $trailer): ?>
				<a href="trailer.php?trailer_id=<?php e($trailer['id']); ?>&movie_id=<?php e($trailer['filme_id']); ?>">
					<?php 
						if($trailer['id'] != $_GET['trailer_id']) {
							echo $catalog->getPictureForTrailer($trailer['trailer']);
						}
					?>
				</a>
			<?php endforeach; ?><br>
			<?php if($_isAdmin): ?>
			<a href="edit_trailer.php?trailer_id=<?php e($trailer['id']); ?>"><input type="button" value="Edit trailer"></a>
			<a href="delete.php?action=trailer&trailer_id=<?php e($trailer['id']); ?>"><input type="button" onclick="return window.confirm('Are you sure you want to delete this trailer?');" value="Delete trailer"></a>
			<?php endif; ?>
	<?php } ?>

</div>
<?php include(SITE_PATH . "template/_footer.php"); ?>