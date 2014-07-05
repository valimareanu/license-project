<?php include(SITE_PATH . "template/_header.php"); ?>
<div class="wrapper">

<?php 
	if(isset($_GET['movie_id'])) {
		echo "<h2>Insert trailer for "; if(isset($film['name'])) {e($film['name']);} echo "</h2>"; 
	} elseif(isset($edit) && $edit == "edit") {
		echo "<h2>Edit trailer for movie "; if(isset($movie_name)) {e($movie_name);} echo "</h2>";
	} else {
		echo "<h2>Insert a new trailer in the database</h2>";
	}
?>
<?php if(isset($_SESSION['message'])) {echo "<img src='/yourcinema/template/icons/error.png'><font color='red'>".
	$_SESSION['message']."</font>";unset($_SESSION['message']); } ?>
<table>
	<form action="<?php 
			if(isset($edit) && $edit == "edit") {
				echo 'edit_trailer.php?trailer_id=' . intval($_GET['trailer_id']);
			} elseif(isset($_GET['movie_id']) && intval($_GET['movie_id'])) {
				echo 'insert_trailer.php?movie_id=' . intval($_GET['movie_id']); 
			} else {
				echo 'insert_trailer.php';
			}
		?>" method="POST">
		<tr>
		    <td><?php if((isset($error_field)) && ($error_field == 'movie_name')) echo "<font color='red'>"; ?>Movie name: </font></td>
		    <td><input type="text" size="24" name="name" value="<?php if(isset($film['name'])) {echo $film['name'];} elseif(isset($movie_name)) {echo $movie_name;}?>" autofocus><mark>*</mark></td>
		</tr>
		<tr>
		    <td><?php if((isset($error_field)) && ($error_field == 'trailer')) echo "<font color='red'>"; ?>Trailer code: </font></td>
		    <td><textarea name="trailer" cols="35" rows="10" placeholder="Place the embeded code from youtube from example."><?php if(isset($trailer)) echo $trailer;?>
		    </textarea><mark>*</mark></td>
		</tr>
		<tr><td><input  align="center" type="submit" name="submit" value="Insert" /></td></tr>
	</form>
</table>


</div>
<?php include(SITE_PATH . "template/_footer.php"); ?>