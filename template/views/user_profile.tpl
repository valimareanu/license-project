<?php include(SITE_PATH . "template/_header.php"); ?> 
<div class="wrapper">
<?php if(isset($_SESSION['message'])) {echo "<img src='/yourcinema/template/icons/error.png'><font color='red'>".
	$_SESSION['message']."</font>";unset($_SESSION['message']); } ?>
<div id="film">
<?php if(empty($messages) && (isset($_GET['action']) && $_GET['action'] == "unread")) {
		$catalog->redirect("user_profile.php?action=messages");} ?>
<?php if(isset($messages)): ?>
	<h3><b>Private messages</b></h3>
	<br /><?php if(empty($messages)) echo "You have no private messages"; ?>
	<?php foreach($messages as $message){ ?>
		<p>Sender name: <?php e($message['sender_name']); ?></p>
		<p>Message: <?php e($message['message']); ?></p>
		<?php
			if($message['sender_id'] != 0) {
				echo '<a href="user_profile.php?sender=' . $message['sender_id'] . '&id=' . $message['id'] . '"><input type="button" value="Reply"></a>';
			}
			if(isset($_GET['sender']) && isset($_GET['id']) && $_GET['id'] == $message['id']) { ?>
				<form action="user_profile.php?sender=<?php e($message['sender_id']);?>&id=<?php e($message['id']);?>" method="post">
					Message:<textarea name="message" cols="35" rows="10"><?php if(isset($message)) {echo $message;} ?></textarea><br>
					<input  align="center" type="submit" name="submit" value="Send"/>
				</form><bt>
		<?php }
			echo "<br />"; 
		} ?>
		<?php 
			if($_GET['action'] == "unread") { 
				echo '<a href="user_profile.php?action=messages"><input type="button" value="My messages"></a>';
			} 
		?>
<?php else: ?>
<?php echo $user_profile['first_name'] . " " . $user_profile['last_name']; ?><br>
<?php echo "Username: " . $user_profile['username']; ?><br>
<?php if(strpos($user_profile['picture'], 'http') == 0): ?>
	<img width="150" src="/yourcinema/assets/users/<?php if(!empty($user_profile['picture'])) {e($user_profile['picture']);} 
				else { e('all.jpg'); }?>" />
	<?php else: ?>
		<img width="150" src="<?php echo urlencode($user_profile['picture']); ?>" />
<?php endif; ?><br />
<h3>Send private message</h3>
<form action="user_profile.php?user_id=<?php echo $user_profile['id']; ?>" method="post">
	<?php if(!$_isLogged): ?>Name: <input type="text" name="name" value="<?php if(isset($name)) {echo $name;} ?>"><br><?php endif; ?>
	Message: <textarea name="message" cols="35" rows="10"><?php if(isset($message)) {echo $message;} ?></textarea><br>
	<input  align="center" type="submit" name="submit" value="Send message" />
</form>
</div>
<?php endif; ?>
</div>
<?php include(SITE_PATH . "template/_footer.php"); ?>