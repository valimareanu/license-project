<!--  -->
<?php include(SITE_PATH . "template/_header.php"); ?> 
<div class="wrapper">

<div id="content">
<!-- daca exista erori in $_SESSION[''] sunt afisate apoi este eliberata variabila pentru a nu fi afisata aceeasi eroare pe mai multe pagini -->
<?php if(isset($_SESSION['message'])) {echo "<img src='/yourcinema/template/icons/error.png'><font color='red'>".
	$_SESSION['message']."</font>";unset($_SESSION['message']); } ?>

<h2>Stock</h2>
	<section>
		<table border='2px solid black' border-collapse='collapse' width="600px">
			<tr>
				<td><b>Movie name</b></td>
				<td><b>Stock</b></td>
				<td><b>Price</b></td>
				<td><b>Bought</b></td>
				<td><b>Update</b></td>
			</tr>
			<?php foreach($film_stock as $stock): ?>
			<tr>
				<form action="stock.php?id=<?php e($stock['id']); ?>" method="post">
					<td><?php e($stock['name']); ?></td>
					<td><input type="text" name="stock" value="<?php if(isset($stock['stoc'])) e($stock['stoc']); ?>"></td>
					<td><input type="text" name="price" value="<?php if(isset($stock['price'])) e($stock['price']); ?>"></td>
					<td><?php e($stock['total_qty']); ?></td>
					<td><input type="submit" name="submit" value="Update"></td>
				</form>
			</tr>
			<?php endforeach; ?>
		</table>
	</section>
	<div id="pagination" style="clear: both;">
		<?php
			if($pagination->total_pages() > 1) {
				if($pagination->has_previous_page()) {
					echo "&nbsp<a href=\"stock.php?page=";
					echo $pagination->previous_page();
					echo "\">&laquo; Previous</a>&nbsp";
				}

				for($i=1; $i <= $pagination->total_pages(); $i++) {
					if($i == $page) {
						echo " <span class=\"selected\">{$i}</span> ";
					} else {
						echo "&nbsp<a href=\"stock.php?page={$i}\">{$i}</a>&nbsp";
					}
				}

				if($pagination->has_next_page()) {
					echo "&nbsp<a href=\"stock.php?page=";
					echo $pagination->next_page(); // htmlentities
					echo "\">Next &raquo;</a>&nbsp";
				}
			}
		?>
	</div>
</div>
</div>
<?php include(SITE_PATH . "template/_footer.php"); ?>