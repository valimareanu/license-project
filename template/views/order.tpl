<!--  -->
<?php include(SITE_PATH . "template/_header.php"); ?>
<div class="wrapper">

	<!-- daca exista erori in $_SESSION[''] sunt afisate apoi este eliberata variabila pentru a nu fi afisata aceeasi eroare pe mai multe pagini -->
	<?php if(isset($_SESSION['message'])) {echo "<img src='/yourcinema/template/icons/error.png'><font color='red'>".
	$_SESSION['message']."</font>";unset($_SESSION['message']); } ?>

	<aside class="left">
		<?php include("template/components/order_summary.tpl"); ?>
	</aside>

	<div id="content2">	
		<h2><b>Complete order<b></h2>
		<form action="" method="post" id="order_form">

			<section class="box inputBox">
				<h3>Contact details</h3>
				<dl>
					<dt>Full name:</dt>
					<dd>
						<input class="input3<?php if(isset($errors['full_name'])) echo " err"; ?>" type="text" name="full_name" value="<?php if(isset($formData['full_name'])) e($formData['full_name']); ?>" /> <mark>*</mark>
						<?php if(isset($errors['full_name'])): ?><div class="error"><?php e($errors['full_name']); ?></div><?php endif; ?>
					</dd>
				</dl>
				<dl>
					<dt>Telephone:</dt>
					<dd><input class="input2" type="text" name="telephone" value="<?php if(isset($formData['telephone'])) e($formData['telephone']); ?>" /></dd>
				</dl>
				<dl>
					<dt>E-mail:</dt>
					<dd>
						<input class="input3<?php if(isset($errors['email'])) echo " err"; ?>" type="text" name="email" <?php if($_isLogged) echo 'disabled="disabled"'; ?> value="<?php if(isset($formData['email'])) e($formData['email']); ?>" /> <mark>*</mark>
						<?php if(isset($errors['email'])): ?><div class="error"><?php e($errors['email']); ?></div><?php endif; ?>
					</dd>
				</dl>
			</section>

			<?php if(!$_isLogged): ?>
			<section class="box inputBox">
				<h3>Account data:</h3>
				<p>Because you don't have an account with us we will create one fast so you can complete your order. Please choose a password with minimum 6 characters.</p>
				<dl>
					<dt>Password:</dt>
					<dd>
						<input class="input2<?php if(isset($errors['password'])) echo " err"; ?>" type="password" name="password" value="<?php if(isset($formData['password'])) e($formData['password']); ?>" /> <mark>*</mark>
						<?php if(isset($errors['password'])): ?><div class="error"><?php e($errors['password']); ?></div><?php endif; ?>
					</dd>
				</dl>
				<dl>
					<dt>Repeat password:</dt>
					<dd>
						<input class="input2<?php if(isset($errors['password2'])) echo " err"; ?>" type="password" name="password2" value="<?php if(isset($formData['password2'])) e($formData['password2']); ?>" /> <mark>*</mark>
						<?php if(isset($errors['password2'])): ?><div class="error"><?php e($errors['password2']); ?></div><?php endif; ?>
					</dd>
				</dl>
			</section>
			<?php endif; ?>

			<section class="box inputBox">
				<h3>Data delivery</h3>
				<dl>
					<dt style="padding-top:0px;">Person type<mark>*</mark>:</dt>
					<dd>
						<input type="radio" name="person_type" value="Natural person" id="pf"<?php if(isset($formData['person_type']) && $formData['person_type']=="Natural person") echo ' checked="checked"'; ?>><label for="pf">Natural person</label> &nbsp; &nbsp; 
						<input type="radio" name="person_type" value="Juridical person" id="pj"<?php if(isset($formData['person_type']) && $formData['person_type']=="Juridical person") echo ' checked="checked"'; ?>><label for="pj">Juridical person</label>
						<?php if(isset($errors['person_type'])): ?><div class="error"><?php e($errors['person_type']); ?></div><?php endif; ?>
					</dd>
				</dl>
				<dl class="company_only">
					<dt>Company:</dt>
					<dd><input class="input3" type="text" name="company" value="<?php if(isset($formData['company'])) e($formData['company']); ?>" /></dd>
				</dl>
				<dl class="company_only">
					<dt>Commercial Register Number:</dt>
					<dd><input class="input2" type="text" name="commercial_register_number" value="<?php if(isset($formData['commercial_register_number'])) e($formData['commercial_register_number']); ?>" /></dd>
				</dl>
				<dl class="company_only">
					<dt>Tax Identification Number:</dt>
					<dd><input class="input2" type="text" name="tax_identification_number" value="<?php if(isset($formData['tax_identification_number'])) e($formData['tax_identification_number']); ?>" /></dd>
				</dl>
				<dl>
					<dt>Address:</dt>
					<dd>
						<input class="input3<?php if(isset($errors['address'])) echo " err"; ?>" type="text" name="address" value="<?php if(isset($formData['address'])) e($formData['address']); ?>" /> <mark>*</mark>
						<?php if(isset($errors['address'])): ?><div class="error"><?php e($errors['address']); ?></div><?php endif; ?>
					</dd>
				</dl>
				<dl>
					<dt>City:</dt>
					<dd>
						<input class="input3<?php if(isset($errors['city'])) echo " err"; ?>" type="text" name="city" value="<?php if(isset($formData['city'])) e($formData['city']); ?>" /> <mark>*</mark>
						<?php if(isset($errors['city'])): ?><div class="error"><?php e($errors['city']); ?></div><?php endif; ?>
					</dd>
				</dl>
				<dl>
					<dt>Country:</dt>
					<dd><input class="input2" type="text" name="country" /></dd>
				</dl>
			</section>

			<section class="box inputBox">
				<h3>Others...</h3>
				<dl>
					<dt style="padding-top:0px;">Payment method<mark>*</mark>:</dt>
					<dd>
						<input type="radio" name="payment_method" id="pm_ramburs" value="ramburs" checked="checked"><label for="pm_ramburs"> Cash on delivery</label> &nbsp; &nbsp; 
						<input type="radio" disabled="disabled" id="pm_card"><label for="pm_card"> Card payment (soon)</label>
					</dd>
				</dl>
				<dl style="padding-top:10px">
					<dt style="padding-top:0px;">Metoda livrare<mark>*</mark>:</dt>
					<dd>
						<div>
							<input onchange="updateTaxes()" type="radio" name="shipping_method" value="post" id="sm_posta_romana"<?php if((isset($formData['shipping_method']) && $formData['shipping_method']=="post") || !isset($formData['shipping_method'])) echo ' checked="checked"'; ?>><label for="sm_posta_romana"> By post (1-3 working days) <mark>(+3 USD)</mark></label>
						</div>
						<div>
							<input onchange="updateTaxes()" type="radio" name="shipping_method" value="courier" id="sm_curier"<?php if(isset($formData['shipping_method']) && $formData['shipping_method']=="courier") echo ' checked="checked"'; ?>><label for="sm_curier"> Fast courier <mark>(+6 USD)</mark></label>
						</div>
						<div>
							<input onchange="updateTaxes()" type="radio" name="shipping_method" value="pers_lift" id="sm_hq"<?php if(isset($formData['shipping_method']) && $formData['shipping_method']=="pers_lift") echo ' checked="checked"'; ?>><label for="sm_hq"> Headquarters lift <mark>(free)</mark></label>
						</div>
					</dd>
				</dl>
				<dl>
					<dt style="padding-top:3px;">Comments:</dt>
					<dd>
						<textarea class="input3" name="obs" style="height:80px"><?php if(isset($formData['obs'])) e($formData['obs']); ?></textarea><br />
						<small>(delivery hours, indications, intercom number, etc...)</small>
					</dd>
				</dl>
			</section>
			<script>
				function updateTaxes(){
					var sm = $('input[name=shipping_method]:checked').val();
					if(sm=="post") var tax = 3;
					else if(sm=="pers_lift") var tax = 0;
					else if(sm=="courier") var tax = 6;
					var products_cost = parseFloat($("#os_products").html());
					$("#os_transport").html(tax);
					$("#os_total").html(tax + products_cost);
				} 
				updateTaxes();
				$(document).ready(function(){
					$(".err").keydown(function(e){
						$(this).removeClass('err');
						$(".error", $(this).parent()).remove();
					});
				});
			</script>

			<section>
				<button type="submit" name="order_submit" value="Send order">Send order</button> 
				&nbsp; &nbsp; <mark>*</mark><i> - required field</i>
			</section>

		</form>
	</div>

	<div class="clear"></div>

</div>
<?php include(SITE_PATH . "template/_footer.php"); ?>