<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<title><?php echo $title; ?></title>
	<link rel='stylesheet' type='text/css' media='all' href='/yourcinema/template/style.css' />
	<link rel='stylesheet' type='text/css' media='all' href='/yourcinema/template/chosen.min.css' />
	<!--[if lt IE 9]><script src="/yourcinema/library/html5.js"></script><![endif]-->
	<script src="/yourcinema/template/jquery.min.js"></script>
	<script src="/yourcinema/template/chosen.jquery.min.js"></script>
	<script src="/yourcinema/template/myScript.js"></script>
	
	<!--<script type="text/javascript" src="/yourcinema/template/jquery-1.4.2.min.js"></script>-->
	<script type="text/javascript" src="/yourcinema/template/jquery-ui-1.8.2.custom.min.js"></script> 
	<script type="text/javascript"> 
 
		jQuery(document).ready(function(){
			$('#moviesearch').autocomplete({
				source:'suggest_movies.php',
				select: function( event, ui ) { 
           			window.location = ui.item.url;
        		},
        		minLength:2});
		});
 
	</script> 
	<link rel="stylesheet" href="/yourcinema/template/smoothness/jquery-ui-1.8.2.custom.css" /> 
	<style type="text/css"><!--
	
	        /* style the auto-complete response */
	        li.ui-menu-item { font-size:12px !important; }
	
	--></style>

	<script type="text/javascript" src="/yourcinema/template/rating.js"></script>

</head>
<body>

<header class="wrapper">

<div id="menu">
	<a href="/yourcinema/" class="buy_button">Home</a>
	<a href="/yourcinema/actors.php" class="buy_button">Actors</a>
	<a href="/yourcinema/directors.php" class="buy_button">Directors</a>
	<a href="/yourcinema/top10.php" class="buy_button">Top 10</a>
	<?php if($user->isLogged()) { ?>
		<a href="/yourcinema/user.php" class="buy_button">My account</a>
		<a href="/yourcinema/list.php?action=like" class="buy_button">Movies that i like</a>
		<a href="/yourcinema/list.php?action=seen" class="buy_button">Movies that i have seen</a>
		<a href="/yourcinema/list.php?action=to_see" class="buy_button">Movies that i need to see</a>
		<a href="/yourcinema/list.php?action=hate" class="buy_button">Movies that i hate</a>
		<a href="/yourcinema/user.php?logout=1" class="buy_button">Log Out</a>
	<?php } else {?>
		<a href="/yourcinema/user.php" class="buy_button">Log In</a>
	<?php } ?>
	<?php if($shop->getCart()) { ?>
	<a href="/yourcinema/cart.php" class="buy_button"><img height="20px" style='vertical-align:middle' src="/yourcinema/template/icons/Shopping-Shopping-cart-loaded-icon.png"></a>
	<?php } else {?>
	<a href="/yourcinema/cart.php" class="buy_button"><img height="20px" style='vertical-align:middle' src="/yourcinema/template/icons/Shopping-Shopping-cart-empty-icon.png"></a>
	<?php } ?>

	<form action="/yourcinema/" method="post">
		<input id="moviesearch" type="text" name="search" <?php if(isset($_SESSION['movie_name'])) {echo "value='".$_SESSION['movie_name']."'";} ?> placeholder="Search movies, actors..."><?php //unset($_SESSION['movie_name']); ?>
		<select data-filter="gen" data-placeholder="Choose a movie genre..." name="s_gen[]" class="chosen search_filter" multiple>
		    <?php 
		    	foreach ($_genuri as $gen) { 
		    		echo "<option";
		    		if(isset($_SESSION['gen']) && is_array($_SESSION['gen']) && count($_SESSION['gen'])) {
		    			foreach ($_SESSION['gen'] as $gen1) {
		    				if($gen['name'] == $gen1) {
		    					echo " selected=".$gen1;
		    				}
		    			}
		    		}
		    		echo ">";
		    		e($gen['name']);
		    		echo "</option>";
		    	}
		    	//unset($_SESSION['gen']);
		    ?>
		</select>
		<select data-filter="actor" data-placeholder="Choose a movie actor..." name="s_actor[]" class="chosen3 search_filter" multiple>
		    <?php 
		    	foreach ($_actors as $actor) { 
		    		echo "<option";
		    		$full_name = $actor['first_name'] . " " . $actor['last_name'];
		    		if(isset($_SESSION['actor']) && is_array($_SESSION['actor']) && count($_SESSION['actor'])) {
		    			foreach ($_SESSION['actor'] as $actor1) {
		    				if($full_name == $actor1) {
		    					echo " selected=".$actor1;
		    				}
		    			}
		    		}
		    		echo ">";
		    		e($actor['first_name'] . " " . $actor['last_name']);
		    		echo "</option>";
		    	}
		    	//unset($_SESSION['actor']);
		    ?>
		</select>
		<select data-filter="director" data-placeholder="Choose a movie director..." name="s_director[]" class="chosen3 search_filter" multiple>
		    <?php 
		    	foreach ($_directors as $director) {
		    		echo "<option";
		    		$full_name_d = $director['first_name'] . " " . $director['last_name'];
		    		if(isset($_SESSION['director']) && is_array($_SESSION['director']) && count($_SESSION['director'])) {
		    			foreach ($_SESSION['director'] as $director1) {
		    				if($full_name_d == $director1) {
		    					echo " selected=".$director1;
		    				}
		    			}
		    		}
		    		echo ">";
		    		e($director['first_name'] . " " . $director['last_name']);
		    		echo "</option>";
		    	}
		    	//unset($_SESSION['director']);
		    ?>
		</select>
		<select data-filter="year" data-placeholder="Choose a movie year..." name="s_year[]" class="chosen search_filter" multiple>
		    <?php 
		    	for ($i=date("Y"); $i>=1960; $i--) {
		    		echo "<option";		 
		    		if(isset($_SESSION['year']) && is_array($_SESSION['year']) && count($_SESSION['year'])) {   
		    			foreach ($_SESSION['year'] as $year1) {	
		    				if($i == $year1) {
		    					echo " selected=".$year1;
		    				}
		    			}
		    		}
		    		echo ">";
		    		e($i);
		    		echo "</option>";
		    	}
		    	//unset($_SESSION['year']);
		    ?>
		</select>
		<input type="submit" name="submit_s" value="Search">
	</form>

	<?php if($user->isAdmin()) { echo "<br />";?>
	<a href="/yourcinema/insert_movie.php" class="buy_button">Insert Movie</a>
	<a href="/yourcinema/insert_trailer.php" class="buy_button">Insert Trailer</a>
	<a href="/yourcinema/insert_actor.php" class="buy_button">Insert Actor</a>
	<a href="/yourcinema/insert_director.php" class="buy_button">Insert Director</a>
	<a href="/yourcinema/order_edit.php" class="buy_button">Edit Orders</a>
	<a href="/yourcinema/stock.php" class="buy_button">Stock</a>
	<a href="/yourcinema/manage_users.php" class="buy_button">Manage users</a>
	<?php } ?>
</div>

<script type="text/javascript" src="/yourcinema/template/rating.js"></script>

	
</header>
