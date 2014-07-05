<div class="widget" id="order_summary">
	<div class="head"><h5>Shopping Cart Summary</h5></div>
	<ul id="order_summary_list">
	<?php 
		$total = 0; 
		foreach ($_cart as $item): 
			$total = $total + ($item['price'] * $item['qty']);
		?>
		<li><b><font size="4"><?php e($item['film_name']); ?></font></b></li>
	<?php endforeach; ?>
	</ul>
	<table width="100%" cellpadding="0" cellspacing="0" id="os_totals">
		<thead>
			<tr><th>Products:</th><th><span id="os_products"><?php c($total); ?></span> USD</th></tr>
		</thead>
		<tbody>
			<tr><td>Transport:</td><td> + <span id="os_transport">0</span> USD</td></tr>
		</tbody>
		<tfoot>
			<tr><td>TOTAL:</td><td><span id="os_total">0</span> USD</td></tr>
		</tfoot>
	</table>
</div>

<script>
	$(document).ready(function() {

		var $scrollingDiv = $("#order_summary");
		var headerHeight = 140;

		$(window).scroll(function(){
			var offset = $(window).scrollTop();
			if(offset > headerHeight){				
				$scrollingDiv.stop().animate({"marginTop": (offset - headerHeight) + "px"}, 500 );	
			} else {
				$scrollingDiv.stop().animate({"marginTop": "0px"}, 500 );
			}
		});

	});
</script>