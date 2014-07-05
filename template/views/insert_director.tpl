<!--  -->
<?php include(SITE_PATH . "template/_header.php"); ?>
<div class="wrapper">

<?php 
	if(isset($_GET['movie_id'])) {
		// daca exista variabila $_GET['movie_id'] atunci regizorul care urmeaza inserat sigur a regizat filmul respectiv
		if(isset($film)) echo "<h2>Insert director for "; if(isset($film)) {e($film['name']);} echo "</h2>";
	} elseif(isset($edit) && $edit == "edit") {
		// daca variabila $edit == "edit" atunci pagina va fi completata cu datele regizorului pentru a fi editate
		echo "<h2>Edit director "; if(isset($first_name) && isset($last_name)) {e($first_name . " " . $last_name);} echo "</h2>";
		if(isset($picture)) {
			// daca exista poza regizorului ea va fi afisata
			echo "<img src='/yourcinema/assets/directors/{$picture}' />";
		} else {
			$edit = "";
			echo "<font color='red'>The picture for this actor was not found.</font>";
		}
	} else { 
		// daca nu este pus $edit sau $edit contine altceva decat "edit" atunci variabila este golita si pagina este setata
		// pentru introducerea unui regizor nou
		$edit = "";
		echo "<h2>Insert a new director in the database</h2>";
	}
?>
<!-- daca exista erori in $_SESSION[''] sunt afisate apoi este eliberata variabila pentru a nu fi afisata aceeasi eroare pe mai multe pagini -->
<?php if(isset($_SESSION['message'])) {echo "<img src='/yourcinema/template/icons/error.png'><font color='red'>".
	$_SESSION['message']."</font>";unset($_SESSION['message']); } ?>
<table>
	<!-- daca este pus $edit atunci formularul trebuie sa trimita datele catre edit_director.php pentru a fi editat regizorul -->
	<!-- daca este pus $_GET['movie_id'] atunci formularul trebuie sa trimita datele catre insert_director.php pentru a fi introdus regizorul pentru filmul cu id-ul $_GET['movie_id'] -->
	<!-- altfel introduc regizorul normal -->
	<form action="<?php
			if(isset($edit) && $edit == "edit") {
				echo 'edit_director.php?director_id=' . intval($_GET['director_id']);
			} elseif (isset($_GET['movie_id']) && intval($_GET['movie_id'])) {
				echo 'insert_director.php?movie_id=' . intval($_GET['movie_id']);
			} else {
				echo 'insert_director.php';
			}
		?>" method="POST">
		<!-- daca este gol $edit atunci imi trebuie si campul acesta, daca editez regizorul nu imi trebuie si campul despre filmeul ep care l-a regizat -->
		<?php if(empty($edit)) : ?>
		<tr>
		    <td><?php if((isset($error_field)) && ($error_field == 'name')) echo "<font color='red'>"; ?>Movie name: </font></td>
		    <td><input type="text" size="24" name="name" value="<?php if(isset($film['name'])) {echo $film['name'];} else {if(isset($name)) {echo $name;}} ?>" autofocus></td>
		</tr>
		<?php endif;?>
		<tr>
		    <td><?php if((isset($error_field)) && ($error_field == 'first_name')) echo "<font color='red'>"; ?>Director first name: </font></td>
		    <td><input type="text" size="24" name="first_name" value="<?php if(isset($first_name)) echo $first_name;?>"><mark>*</mark></td>
		</tr>
		<tr>
		    <td><?php if((isset($error_field)) && ($error_field == 'last_name')) echo "<font color='red'>"; ?>Director last name: </font></td>
		    <td><input type="text" size="24" name="last_name" value="<?php if(isset($last_name)) echo $last_name;?>"><mark>*</mark></td>
		</tr>
		<tr>
		    <td><?php if((isset($error_field)) && ($error_field == 'birth_place')) echo "<font color='red'>"; ?>Director birth place: </font></td>
		    <td><input type="text" size="24" name="birth_place" value="<?php if(isset($birth_place)) echo $birth_place;?>"><mark>*</mark></td>
		</tr>
		<tr>
		    <td><?php if((isset($error_field)) && ($error_field == 'birth_date')) echo "<font color='red'>"; ?>Director birth date: </font></td>
		    <td><input type="text" size="24" name="birth_date" value="<?php if(isset($birth_date)) echo $birth_date;?>"><mark>*</mark></td>
		</tr>
		<tr>
		    <td><?php if((isset($error_field)) && ($error_field == 'country')) echo "<font color='red'>"; ?>Director country: </font></td>
		    <td><input type="text" size="24" name="country" value="<?php if(isset($country)) echo $country;?>"><mark>*</mark></td>
		</tr>
		<tr>
		    <td><?php if((isset($error_field)) && ($error_field == 'biography')) echo "<font color='red'>"; ?>Director Biography: </font></td>
		    <td><textarea name="biography" cols="35" rows="10"><?php if(isset($biography)) e($biography);?>
		    </textarea><mark>*</mark></td>
		</tr>
		<tr>
		    <td>Picture: </font></td>
		    <td>
		    	<input type="hidden" name="MAX_FILE_SIZE" value="2000000">
		    	<input type="file" name="picture_name" size="30">
		    </td>
		</tr>
		<tr>
		   	<td>Or provide an URL: </font></td><td><input type="text" size="24" name="picture_url"></td>
		</tr>
		<!-- in functie de $edit schimb valoare butonului in Insert sau Edit -->
		<tr><td><input  align="center" type="submit" name="submit" <?php if(empty($edit)) {echo "value='Insert'";} else {echo "value='Edit'";}?> /></td></tr>
	</form>
</table>

<!-- daca si filmul si regizorul sunt introdusi atunci trebuie completat doar tabelul regizor_film care face legatura intre filme si regizori -->
<?php if(empty($edit)) : ?>
<h2>If the movie and director are allready in the database just select them from the list</h2>
<table>
	<form action="insert_director.php" method="POST">
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
			<!-- se alege regizorul sau regizorii, daca mai multi regizori care au regizat filmul sunt deja introdusi in baza de date se pot selecta toti, si se face legatura intre film si toti regizorii selectati -->
		    <td><?php if((isset($error_field)) && ($error_field == 'director_name')) echo "<font color='red'>"; ?>Director name: </font></td>
		    <td>
		    	<select data-placeholder="Select one director..." name="director_name[]" class="chosen3" multiple>
		    		<?php foreach ($directors as $name) { 
		    			echo "<option";
		    			$full_name = $name['first_name'] . " " . $name['last_name'];
		    			if(isset($director_name)) {
		    				foreach($director_name as $director) {
		    					if($full_name == $director) {
		    						echo " selected=". $director;
		    					}
		    				}
		    			}
		    			echo ">";
		    			echo $name['first_name'] . " " . $name['last_name'];
		    			echo "</option>";
		    		} ?>
		    	</select>
		    </td>
		</tr>
		<tr><td><input  align="center" type="submit" name="submit1" value="Insert" /></td></tr>
	</form>
</table>
<?php endif;?>

</div>
<?php include(SITE_PATH . "template/_footer.php"); ?>