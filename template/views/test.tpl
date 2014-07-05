<?php include(SITE_PATH . "template/_header.php"); ?>
<?php if(isset($_SESSION['message'])) {echo "<font color='red'>".$_SESSION['message']."</font>";unset($_SESSION['message']);} ?>
<div class="wrapper">
<form method="POST" action="test.php">
    <input type="text" name="img">
    <input type="submit">
</form>
</div>
<?php include(SITE_PATH . "template/_footer.php"); ?>