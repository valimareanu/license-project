<!--  -->
<?php include(SITE_PATH . "template/_header.php"); ?>
<div class="wrapper">
<!-- daca exista erori in $_SESSION[''] sunt afisate apoi este eliberata variabila pentru a nu fi afisata aceeasi eroare pe mai multe pagini -->
<?php if(isset($_SESSION['message'])) {echo "<img src='/yourcinema/template/icons/error.png'><font color='red'>".
$_SESSION['message']."</font>";unset($_SESSION['message']); } ?>
<form action="" method="post" id="forgot_password_form">
	<!-- utilizatorul este rugat sa insereze emailul pentru a-i fi trimis un email cu noua parola -->
	<p>Please insert your email. We will send an email with a new password.</p>
	<input type="text" name="email" <?php if(isset($_POST['email'])) echo ' value="' . e($_POST['email'], false) . '"'; ?>/> 
	<input  align="center" type="submit" name="fp_submit" value="Send Email" />
</form>

</div>
<?php include(SITE_PATH . "template/_footer.php"); ?>