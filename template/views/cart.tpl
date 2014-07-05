<!--  -->
<?php include(SITE_PATH . "template/_header.php"); ?>
<div class="wrapper">
<!-- daca exista erori in $_SESSION[''] sunt afisate apoi este eliberata variabila pentru a nu fi afisata aceeasi eroare pe mai multe pagini -->
<?php if(isset($_SESSION['message'])) {echo "<img src='/yourcinema/template/icons/error.png'><font color='red'>".
$_SESSION['message']."</font>";unset($_SESSION['message']); } ?>


<div id="content">
<!-- initializez totalul cu 0, apoi numar cate produse sunt in cart -->
	<?php 
		$total = 0;
		$items_no = count($_cart);
	?>
	<form action="" method="post">
	<section>
		<!-- afisez produsele din cart -->
		<h2>Shopping cart</h2>
		<?php if($items_no): ?>
		<ul>
		<table border='2px solid black' border-collapse='collapse' width="600px">
			<tr>
				<td><b>Price</b></td>
				<td><b>Name</b></td>
				<td><b>Picture</b></td>
				<td><b>Quantity</b></td>
				<td><b>Remove</b></td>
			<tr>
			<?php foreach($_cart as $item): ?>
				<?php //echo $item['name']; ?>
				<?php //var_dump($item); ?>
			<tr>
				<td><?php e($item['price']); ?><small> USD</small></td>
				<td><b ><?php e($item['name']); ?></b></td>
				<td><img style='width:50px;height:70px;vertical-align:middle' src="/yourcinema/assets/movies/<?php e($item['picture']); ?>"></td>
				<td>
					<!-- afisez cantitatea produsului si daca utilizatorul doreste poate sa creasca sau sa descreasca cantitatea -->
					<?php e($item['qty']); ?>&nbsp;&nbsp;&nbsp;
					<a href="cart.php?action=add_item&cid=<?php e($item['id']); ?>">
						<img style='width:20px;height:20px;vertical-align:middle' src="/yourcinema/template/icons/cart_add.png">
					</a>
					<?php if($item['qty'] == 1): ?>
						<!-- daca cantitatea este 1 si utilizatorul descreste cantitatea atunci produsul va fi scos din cart -->
						<a href="cart.php?action=remove&cid=<?php e($item['id']); ?>">
							<img style='width:20px;height:20px;vertical-align:middle' src="/yourcinema/template/icons/cart_remove.png">
						</a>
					<?php else: ?>
						<a href="cart.php?action=remove_item&cid=<?php e($item['id']); ?>">
							<img style='width:20px;height:20px;vertical-align:middle' src="/yourcinema/template/icons/cart_remove.png">
						</a>
					<?php endif; ?>
				</td>
				<td><a href="cart.php?action=remove&cid=<?php e($item['id']); ?>">
					<img src="/yourcinema/template/icons/remove.png">Remove
				</a></td>
				<!-- este calculat totalul pretului produselor -->
				<?php $total = $total + ($item['price'] * $item['qty']); ?>
			</tr>
			<?php endforeach; ?>
			<tr>
				<!-- este afisat totalul -->
				<td><b>Total price:</b></td>
				<td colspan="4" align="center"><?php e($total); ?><small> USD</small></td>
			</tr>
		</table>
		</ul>
		<a href="order.php">
			<input type="button" name="order_submit" value="Submit">
		</a>
		<!-- daca utilizatorul vrea sa goleasca cart-ul -->
		<a href="cart.php?action=empty_cart">
			<img src="/yourcinema/template/icons/cart_empty.gif">
		</a>
	<?php else: ?>
		<b>Your shopping cart is empty.</b>
	<?php endif; ?>
	</section>
	</form>
</div>

</div>
<?php include(SITE_PATH . "template/_footer.php"); ?>
