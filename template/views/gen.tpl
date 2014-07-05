<!--  -->
<?php include(SITE_PATH . "template/_header.php"); ?>
<div class="wrapper">


<h2><?php e($genre['name']);?> type movies</h2>

<div id="products_from_category">
	<?php foreach($products_from_category as $product): ?>
		<div class="product">
		<h3><a href="/yourcinema/film.php?movie_id=<?php echo $product['id']; ?>"><?php e($product['name']); ?></a></h3>
		<div class="mdate"><?php e($product['movie_date']); ?></div>
		<a href="/yourcinema/film.php?movie_id=<?php echo $product['id']; ?>">
		<?php if(strpos($product['picture'], 'http') == 0): ?>
			<img width="150" src="/yourcinema/assets/movies/<?php echo $product['picture']; ?>" />
		<?php else: ?>
			<img width="150" src="<?php echo urlencode($product['picture']); ?>" />
		<?php endif; ?>
		</a>
		<?php echo $product['sinopsis']; ?>
	</div>
	<?php endforeach; ?>
	<div class="clear"></div>
</div>




</div>
<?php include(SITE_PATH . "template/_footer.php"); ?>
