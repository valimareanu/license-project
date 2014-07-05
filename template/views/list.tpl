<?php include(SITE_PATH . "template/_header.php"); ?>
<div class="wrapper">
	<?php if(isset($_SESSION['message'])) {echo "<img src='/yourcinema/template/icons/error.png'><font color='red'>".
	$_SESSION['message']."</font>";unset($_SESSION['message']); } ?>
	<div id="new_products">
	<?php foreach($movie_list as $product): ?>
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
<div id="pagination" style="clear: both;">
		<?php
			if($pagination->total_pages() > 1) {
				if($pagination->has_previous_page()) {
					echo "&nbsp<a href=\"list.php";
					if(isset($_GET['action'])) echo "?action=".$_GET['action']."&"; else echo "?";
					echo "page=";
					echo $pagination->previous_page();
					echo "\">&laquo; Previous</a>&nbsp";
				}

				for($i=1; $i <= $pagination->total_pages(); $i++) {
					if($i == $page) {
						echo " <span class=\"selected\">{$i}</span> ";
					} else {
						echo "&nbsp<a href=\"list.php";
						if(isset($_GET['action'])) echo "?action=".$_GET['action']."&"; else echo "?";
						echo "page={$i}\">{$i}</a>&nbsp";
					}
				}

				if($pagination->has_next_page()) {
					echo "&nbsp<a href=\"list.php";
					if(isset($_GET['action'])) echo "?action=".$_GET['action']."&"; else echo "?";
					echo "page=";
					echo $pagination->next_page(); // htmlentities
					echo "\">Next &raquo;</a>&nbsp";
				}
			}
		?>
	</div>
</div>
<?php include(SITE_PATH . "template/_footer.php"); ?>