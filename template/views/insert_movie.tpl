<?php include(SITE_PATH . "template/_header.php"); ?>
<div class="wrapper">

<?php if(isset($edit) && $edit == "edit") { ?>
<h2>Edit <?php if(isset($name)) {e($name);} ?></h2>
<?php } else { $edit = ""; ?>
<h2>Insert movie in the database</h2>
<?php } ?>
<?php
	if(isset($edit) && $edit == "edit") {
		if(isset($picture)) { 
			echo "<img src='/yourcinema/assets/movies/$picture' />";
		} else {
			echo "<font color='red'>This movie has no picture</font>";
		}
	}
?>
<?php if(isset($_SESSION['message'])) {echo "<img src='/yourcinema/template/icons/error.png'><font color='red'>".
	$_SESSION['message']."</font>";unset($_SESSION['message']); } ?>
<table>
	<form action="<?php 
			if(isset($edit) && $edit == "edit") {
				echo 'edit_movie.php?movie_id=' . intval($_GET['movie_id']);
			} else {
				echo 'insert_movie.php';
			}
		?>" method="POST">
		<tr>
		    <td><?php if((isset($error_field)) && ($error_field == 'name')) echo "<font color='red'>"; ?>Name: </font></td>
		    <td><input type="text" size="24" name="name" value="<?php if(isset($name)) echo $name;?>" autofocus><mark>*</mark></td>
		</tr>
		<tr>
		    <td><?php if((isset($error_field)) && ($error_field == 'movie_date')) echo "<font color='red'>"; ?>Movie date: </font></td>
		    <td><input type="text" size="24" name="movie_date" placeholder="When the movie was first released." 
		    		value="<?php if(isset($movie_date)) echo $movie_date;?>"><mark>*</mark></td>
		</tr>
		<tr>
		   	<td><?php if((isset($error_field)) && ($error_field == 'gen')) echo "<font color='red'>"; ?>Gen: </font></td>
		    <td>
		    	<select name="gen[]" class="chosen2" multiple>
			    		<?php 
			    			foreach ($category as $name) { 
			    				echo "<option";
			    				if(isset($edit) && $edit == "edit") {
			    					if(isset($category1)) {
					    				foreach ($category1 as $cat) {
						    				if($name['name'] == $cat['name']) {
						    					echo " selected=" . $cat['name']; 
						    				} 
						    			}
						    		}
					    		}
					    		echo ">";
					    		e($name['name']); 
					    		echo "</option>";
					    	}
			    		?>
		    	</select><mark>*</mark>
		    </td>
		</tr>
		<tr>
		   	<td><?php if((isset($error_field)) && ($error_field == 'sinopsis')) echo "<font color='red'>"; ?>Sinopsis: </sinopsis></td>
		   	<td><textarea name="sinopsis" cols="35" rows="10" placeholder="Write something about the movie."><?php 
		   		if(isset($sinopsis)) echo $sinopsis;?>
		   	</textarea><mark>*</mark></td>
		</tr>
		<tr>
		    <td><?php if((isset($error_field)) && ($error_field == 'picture')) echo "<font color='red'>"; ?>Picture: </font></td>
		    <td>
		    	<input type="hidden" name="MAX_FILE_SIZE" value="2000000">
		    	<input type="file" name="picture_name" size="30">
		    </td>
		</tr>
		<tr>
		   	<td><?php if((isset($error_field)) && ($error_field == 'picture')) echo "<font color='red'>"; ?>Or provide an URL: </font></td>
		   	<td><input type="text" size="24" name="picture_url"></td>
		</tr>
		<tr>
		    <td>Stoc: </td><td><input type="text" size="24" name="stoc" value="<?php if(isset($stoc)) echo $stoc;?>"></td>
		</tr>
		<tr>
		    <td>Price: </td><td><input type="text" size="24" name="price" value="<?php if(isset($price)) echo $price;?>">USD</td>
		</tr>
		<tr>
		   	<td><input type="checkbox" name="visible" <?php if(isset($edit) && $edit == "edit") e("checked") ?> value="1"> Visible movie</td>
		</tr>
		<tr><td><input  align="center" type="submit" name="submit" <?php if(!$edit) {echo "value='Insert'";} else {echo "value='Edit'";}?>/></td></tr>
	</form>
</table>


</div>
<?php include(SITE_PATH . "template/_footer.php"); ?>