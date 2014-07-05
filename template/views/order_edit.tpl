<!--  -->
<?php include(SITE_PATH . "template/_header.php"); ?>
<div class="wrapper">

<div id="content">
<!-- daca exista erori in $_SESSION[''] sunt afisate apoi este eliberata variabila pentru a nu fi afisata aceeasi eroare pe mai multe pagini -->
<?php if(isset($_SESSION['message'])) {echo "<img src='/yourcinema/template/icons/error.png'><font color='red'>".
	$_SESSION['message']."</font>";unset($_SESSION['message']); } ?>
<section>
<h2>All orders</h2>
<table border='2px solid black' border-collapse='collapse' width="600px">
	<tr>
		<td><b>User ID</b></td>
		<td><b>Full Name</b></td>
		<td><b>Date</b></td>
		<td><b>Telephone</b></td>
		<td><b>Address</b></td>
		<td><b>Billing details</b></td>
		<td><b>Payment Method</b></td>
		<td><b>Shipping Method</b></td>
		<td><b>Movie Name</b></td>
		<td><b>Qty</b></td>
		<td><b>Price</b></td>
		<td><b>Observations</b></td>
		<td><b>Status</b></td>
		<td><b>Change status</b></td>
		<td></td>
	<tr>
	<?php foreach($all_orders as $o_data): ?>
	<tr>
		<td><?php e($o_data['user_id']); ?></td>
		<td><?php e($o_data['full_name']); ?></td>
		<td><div class="mdate"><?php e($o_data['add_date']); ?></div></td>
		<td><?php e($o_data['telephone']); ?></td>
		<td><?php e($o_data['address']); ?></td>
		<td><?php e($o_data['billing_details']); ?></td>
		<td><?php e($o_data['payment_method']); ?></td>
		<td>
			<form action="order_edit.php?id=<?php e($o_data['id']); ?>" Method="post">
				<select name="shipping"> 
        			<option value="" selected="selected"><?php e($o_data['shipping_method']); ?></option>
        			<option value="post">post</option>
        			<option value="courier">courier</option>
    			</select>
    			<input type="submit" value="Update">
			</form>
		</td>
		<td>
			<form action="order_edit.php?id=<?php e($o_data['o_p_id']); ?>&movie_id=<?php e($o_data['filme_id']); ?>" Method="post">
				<input type="text" name="qty" value="<?php e($o_data['qty']); ?>">
			</form>
		</td>
		<td><?php e($o_data['price']); ?></td>
		<td><?php if(!empty($o_data['obs'])) e($o_data['obs']); else echo "No observations." ?></td>
		<td><?php e($o_data['status']); ?></td>
		<td>
			<?php if(!empty($o_data['status']) && $o_data['status'] == 'pending'): ?>
				<a href="order_edit.php?action=on_route&id=<?php e($o_data['id']); ?>" class="normal_button">On route</a>
				<a href="order_edit.php?action=canceled&id=<?php e($o_data['id']); ?>" class="normal_button">Cancel</a>
			<?php elseif(!empty($o_data['status']) && $o_data['status'] == 'on_route'): ?>
				<a href="order_edit.php?action=pending&id=<?php e($o_data['id']); ?>" class="normal_button">Pending</a>
				<a href="order_edit.php?action=delivered&id=<?php e($o_data['id']); ?>" class="normal_button">Delivered</a>
				<a href="order_edit.php?action=cancel&id=<?php e($o_data['id']); ?>" class="normal_button">Cancel</a>
			<?php elseif(!empty($o_data['status']) && $o_data['status'] == 'delivered'): ?>
				<a href="order_edit.php?action=pending&id=<?php e($o_data['id']); ?>" class="normal_button">Pending</a>
				<a href="order_edit.php?action=on_route&id=<?php e($o_data['id']); ?>" class="normal_button">On route</a>
				<a href="order_edit.php?action=cancel&id=<?php e($o_data['id']); ?>" class="normal_button">Cancel</a>
			<?php endif; ?>
		</td>
		<td><a href="order_edit.php?action='delete'&id=<?php e($o_data['id']); ?>" class="normal_button" onclick="return window.confirm('Are you sure you want to delete this order?');">DELETE</a></td>
	</tr>
	<?php endforeach; ?>
</table>
</section>
<div id="pagination" style="clear: both;">
		<?php
			if($pagination->total_pages() > 1) {
				if($pagination->has_previous_page()) {
					echo "&nbsp<a href=\"order_edit.php?page=";
					echo $pagination->previous_page();
					echo "\">&laquo; Previous</a>&nbsp";
				}

				for($i=1; $i <= $pagination->total_pages(); $i++) {
					if($i == $page) {
						echo " <span class=\"selected\">{$i}</span> ";
					} else {
						echo "&nbsp<a href=\"order_edit.php?page={$i}\">{$i}</a>&nbsp";
					}
				}

				if($pagination->has_next_page()) {
					echo "&nbsp<a href=\"order_edit.php?page=";
					echo $pagination->next_page(); // htmlentities
					echo "\">Next &raquo;</a>&nbsp";
				}
			}
		?>
	</div>
</div>
</div>
<?php include(SITE_PATH . "template/_footer.php"); ?>