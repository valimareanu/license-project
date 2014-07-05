<?php include(SITE_PATH . "template/_header.php"); ?>
<div class="wrapper">

	<h2>Welcome to YourCinema</h2>
	<?php 
		if(!isset($login)) {	
			$login = "";
		}
		if(!isset($edit_user)) {	
			$edit_user = "";
		} else {
			echo "<img src='/yourcinema/template/icons/error.png'><font color='red'>If you want to change your account data you must insert your password.</font>";
		}

	?>
	<?php if(isset($_SESSION['message'])) {echo "<img src='/yourcinema/template/icons/error.png'><font color='red'>".
	$_SESSION['message']."</font>";unset($_SESSION['message']); } ?>

	<table>
		<form action="" method="post" enctype="multipart/form-data">
			<?php if(!$login || !$user->isLogged()): ?>
			<tr>
				<td>
					<a href="user.php?sign_in=1">Allready have an account?</a>
				</td>
			</tr>
			<?php endif; ?>
			<tr>
				<td><?php if((isset($error_field)) && ($error_field == 'username')) echo "<font color='red'>"; ?>Username:</font></td>
				<td><input type="text" size="24" name="username" value="<?php if(isset($userAccountData)) {echo $userAccountData['username'];} elseif(isset($username)) {echo $username;} ?>" autofocus><mark>*</mark></td>
			</tr>
			<tr>
				<td><?php if((isset($error_field)) && ($error_field == 'password')) echo "<font color='red'>"; ?>Password:</font></td>
				<td><input type="password" size="24" name="password"><mark>*</mark></td>
			</tr>
			<?php if(!$login): ?>
			<?php if(!$edit_user): ?>
			<tr>
				<td><?php if((isset($error_field)) && ($error_field == 'password')) echo "<font color='red'>"; ?>Repeat password:</font></td>
				<td><input type="password" size="24" name="password1"><mark>*</mark></td>
			</tr>
			<?php endif; ?>
			<tr>
				<td><?php if((isset($error_field)) && ($error_field == 'first_name')) echo "<font color='red'>"; ?>First name:</font></td>
				<td><input type="text" size="24" name="first_name" value="<?php if(isset($userAccountData)) {echo $userAccountData['first_name'];} elseif(isset($first_name)) {echo $first_name;} ?>"><mark>*</mark></td>
			</tr>
			<tr>
				<td><?php if((isset($error_field)) && ($error_field == 'last_name')) echo "<font color='red'>"; ?>Last name:</font></td>
				<td><input type="text" size="24" name="last_name" value="<?php if(isset($userAccountData)) {echo $userAccountData['last_name'];} elseif(isset($last_name)) {echo $last_name;} ?>"><mark>*</mark></td>
			</tr>
			<tr>	
				<td><?php if((isset($error_field)) && ($error_field == 'email')) echo "<font color='red'>"; ?>Email:</font></td>
				<td><input type="text" size="24" name="email" value="<?php if(isset($userAccountData)) {echo $userAccountData['email'];} elseif(isset($email)) {echo $email;} ?>"><mark>*</mark></td>
			</tr>
			<tr>
				<td>Picture:</td>
				<td>
					<input type="hidden" name="MAX_FILE_SIZE" value="2000000">
		    		<input type="file" name="file" size="30">
		    	</td>
			</tr>
			<tr>
				<td>Or add an URL for picture:</td>
				<td><input type="text" size="24" name="picture_url" value=""></td>
			</tr>
			<tr>
				<td>Some things about you:</font></td>
				<td>
					<textarea name="bio" cols="35" rows="10">
						<?php if(isset($userAccountData)) {e($userAccountData['bio']);} elseif(isset($bio)) {echo $bio;} ?>
					</textarea>
				</td>
			</tr>
			<?php endif; ?>
			<tr>
				<td>
					<?php if($edit_user): ?>
					 	<input  align="center" type="submit" "name='submit' value='Edit User'"/>
					<?php else: ?>
						<input  align="center" type="submit" <?php if($login) e("name='login' value='Login'"); else {e("name='submit' value='Create User'");} ?>/>
					<?php endif; ?>	
				</td>
			</tr>
		</form>
	</table>

</div>
<?php include(SITE_PATH . "template/_footer.php"); ?>