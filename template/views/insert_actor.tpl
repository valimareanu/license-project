<!--  -->
<?php include(SITE_PATH . "template/_header.php"); ?>
<div class="wrapper">

<?php 
	if(isset($_GET['movie_id'])) {
		// daca exista variabila $_GET['movie_id'] atunci actorul care urmeaza inserat sigur a jucat in filmul respectiv
		if(isset($film)) echo "<h2>Insert actor for "; if(isset($film['name'])) {e($film['name']);} echo "</h2>"; 
	} elseif(isset($edit) && $edit == "edit") {
		// daca variabila $edit == "edit" atunci pagina va fi completata cu datele actorului pentru a fi editate
		echo "<h2>Edit actor "; if(isset($first_name) && isset($last_name)) {e($first_name . " " . $last_name);} echo "</h2>";
		if(isset($picture)) { 
			// daca exista poza actorului ea va fi afisata
			echo "<img src='/yourcinema/assets/actors/{$picture}' />";
		} else {
			echo "<font color='red'>The picture for this actor was not found.</font>";
		}
	} else {
		// daca nu este pus $edit sau $edit contine altceva decat "edit" atunci variabila este golita si pagina este setata
		// pentru introducerea unui actor nou 
		$edit = "";
		echo "<h2>Insert a new actor in the database</h2>";
	}
?>
<!-- daca exista erori in $_SESSION[''] sunt afisate apoi este eliberata variabila pentru a nu fi afisata aceeasi eroare pe mai multe pagini -->
<?php if(isset($_SESSION['message'])) {echo "<img src='/yourcinema/template/icons/error.png'><font color='red'>".
	$_SESSION['message']."</font>";unset($_SESSION['message']); } ?>
<table>
	<!-- daca este pus $edit atunci formularul trebuie sa trimita datele catre edit_actor.php pentru a fi editat actorul -->
	<!-- daca este pus $_GET['movie_id'] atunci formularul trebuie sa trimita datele catre insert_actor.php pentru a fi introdus actorul pentru filmul cu id-ul $_GET['movie_id'] -->
	<!-- altfel introduc actorul normal -->
	<form action="<?php
			if(isset($edit) && $edit == "edit") {
				echo 'edit_actor.php?actor_id=' . intval($_GET['actor_id']);
			} elseif(isset($_GET['movie_id']) && intval($_GET['movie_id'])) {
				echo 'insert_actor.php?movie_id=' . intval($_GET['movie_id']); 
			} else {
				echo 'insert_actor.php';
			}
		?>" method="POST">
		<!-- daca este gol $edit atunci imi trebuie si campul acesta, daca editez actorul nu imi trebuie si campul despre filmeul in care a jucat -->
		<?php if(empty($edit)) : ?>
		<tr>
		    <td><?php if((isset($error_field)) && ($error_field == 'name')) echo "<font color='red'>"; ?>Movie name: </font></td>
		    <td><input type="text" size="24" name="name" value="<?php if(isset($film['name'])) {echo $film['name'];} else {if(isset($name)) {echo $name;}} ?>" autofocus></td>
		</tr>
		<tr>
		    <td>Actor's name in movie: </font></td>
		    <td><input type="text" size="24" name="actor_film_name"></td>
		</tr>
		<?php endif;?>
		<tr>
		    <td><?php if((isset($error_field)) && ($error_field == 'first_name')) echo "<font color='red'>"; ?>Actor first name: </font></td>
		    <td><input type="text" size="24" name="first_name" value="<?php if(isset($first_name)) echo $first_name;?>"><mark>*</mark></td>
		</tr>
		<tr>
		    <td><?php if((isset($error_field)) && ($error_field == 'last_name')) echo "<font color='red'>"; ?>Actor last name: </font></td>
		    <td><input type="text" size="24" name="last_name" value="<?php if(isset($last_name)) echo $last_name;?>"><mark>*</mark></td>
		</tr>
		<tr>
		    <td><?php if((isset($error_field)) && ($error_field == 'birth_place')) echo "<font color='red'>"; ?>Actor birth place: </font></td>
		    <td><input type="text" size="24" name="birth_place" value="<?php if(isset($birth_place)) echo $birth_place;?>"><mark>*</mark></td>
		</tr>
		<tr>
		    <td><?php if((isset($error_field)) && ($error_field == 'birth_date')) echo "<font color='red'>"; ?>Actor birth date: </font></td>
		    <td><input type="text" size="24" name="birth_date" value="<?php if(isset($birth_date)) echo $birth_date;?>"><mark>*</mark></td>
		</tr>
		<tr>
		    <td><?php if((isset($error_field)) && ($error_field == 'country')) echo "<font color='red'>"; ?>Actor country: </font></td>
		    <td><input type="text" size="24" name="country" value="<?php if(isset($country)) echo $country;?>"><mark>*</mark></td>
		</tr>
		<tr>
		    <td><?php if((isset($error_field)) && ($error_field == 'biography')) echo "<font color='red'>"; ?>Actor Biography: </font></td>
		    <td><textarea name="biography" cols="35" rows="10"><?php if(isset($biography)) e($biography);?>
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
		<!-- in functie de $edit schimb valoare butonului in Insert sau Edit -->
		<tr><td><input  align="center" type="submit" name="submit" <?php if(empty($edit)) {echo "value='Insert'";} else {echo "value='Edit'";}?> /></td></tr>
	</form>
</table>

<!-- daca si filmul si actorul sunt introdusi atunci trebuie completat doar tabelul actor_film care face legatura intre filme si actori -->
<?php if(empty($edit)) : ?>
<h2>If the movie and actor are allready in the database just select them from the list</h2>
<table>
	<form action="insert_actor.php" method="POST">
		<tr>
			<!-- se alege numele filmului -->
		    <td><?php if((isset($error_field)) && ($error_field == 'movie_name')) echo "<font color='red'>"; ?>Movie name: </font></td>
		    <td>
		    	<select name="movie_name" class="chosen">
		    		<?php foreach ($movies as $name) { ?>
		    			<option value="<?php echo $name['name']; ?>"<?php if(isset($movie_name) && $movie_name==$name['name']) echo " selected=\"selected\""; ?>><?php e($name['name']); ?></option>
		    		<?php } ?>
		    	</select>
		    </td>
		</tr>
		<tr>
			<!-- se alege actorul sau actorii, daca mai multi actori care au jucat in film sunt deja introdusi in baza de date se pot selecta toti, si se face legatura intre film si toti actorii selectati -->
		    <td><?php if((isset($error_field)) && ($error_field == 'actor_name')) echo "<font color='red'>"; ?>Actor name: </font></td>
		    <td>
		    	<select data-placeholder="Select one actor..." name="actor_name" class="chosen3" multiple>
		    		<?php 
		    			foreach ($actors as $name) { 
		    				echo "<option";
		    				if(isset($actor_name)) {
		    					$full_name = $name['first_name'] . " " . $name['last_name'];
		    					if($full_name == $actor_name) {
		    						echo " selected=".$actor_name;
		    					}
		    				}
		    			echo ">";
		    			echo $name['first_name'] . " " . $name['last_name'];
		    			echo "</option>";
		    		} ?>
		    	</select>
		    </td>
		</tr>
		<tr>
		    <td>Actor's name in movie: </font></td>
		    <td><input type="text" size="24" name="actor_film_name" value="<?php if(isset($aka)) echo $aka;?>"></td>
		</tr>
		<tr><td><input  align="center" type="submit" name="submit1" value="Insert" /></td></tr>
	</form>
</table>
<?php endif;?>

</div>
<?php include(SITE_PATH . "template/_footer.php"); ?>