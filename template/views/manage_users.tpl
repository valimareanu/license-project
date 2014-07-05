<!--  -->
<?php include(SITE_PATH . "template/_header.php"); ?> 
<div class="wrapper">

<div id="content">
<!-- daca exista erori in $_SESSION[''] sunt afisate apoi este eliberata variabila pentru a nu fi afisata aceeasi eroare pe mai multe pagini -->
<?php if(isset($_SESSION['message'])) {echo "<img src='/yourcinema/template/icons/error.png'><font color='red'>".
	$_SESSION['message']."</font>";unset($_SESSION['message']); } ?>


<h2>Manage Users</h2>
Order by: 
<a href="manage_users.php?action=username" class="normal_button">Username</a>
<a href="manage_users.php?action=admin" class="normal_button">Admin</a>
<a href="manage_users.php?action=status" class="normal_button">Status</a>
	<section>
		<table border='2px solid black' border-collapse='collapse' width="600px">
			<tr>
				<td><b>Username</b></td>
				<td><b>First name</b></td>
				<td><b>Last name</b></td>
				<td><b>Created</b></td>
				<td><b>Email</b></td>
				<td><b>Picture</b></td>
				<td><b>Delete Picture</b></td>
				<td><b>Biography</b></td>
				<td><b>Admin</b></td>
				<td><b>Status</b></td>
				<td><b>Update</b></td>
				<td><b>Change status</b></td>
			</tr>
			<?php foreach($users_list as $user_list): ?>
			<tr>
				<form action="manage_users.php?id=<?php e($user_list['id']); ?>" method="post">
				<td><?php e($user_list['username']); ?></td>
				<td><?php e($user_list['first_name']); ?></td>
				<td><?php e($user_list['last_name']); ?></td>
				<td><?php e($user_list['created']); ?></td>
				<td><?php e($user_list['email']); ?></td>
				<td>
					<?php if(strpos($user_list['picture'], 'http') == 0): ?>
						<img width="60" src="/yourcinema/assets/users/<?php echo $user_list['picture']; ?>" />
					<?php else: ?>
						<img width="60" src="<?php echo urlencode($user_list['picture']); ?>" />
					<?php endif; ?>
				</td>
				<td><a href="manage_users.php?action=picture&id=<?php e($user_list['id']); ?>" class="normal_button">Delete Picture</a></td>	
				<td><textarea type="text" name="bio"><?php if(isset($user_list['bio'])) e($user_list['bio']); ?></textarea></td>
				<td>
					<select name="user_a"> 
        				<option value="" selected="selected"><?php e($user_list['user_a']); ?></option>
        				<option value="0">0</option>
        				<option value="1">1</option>
    				</select>
				</td>
				<td><?php e($user_list['status']); ?></td>
				<td><input type="submit" name="submit" value="Update"></td>
				<td>
					<?php if(!empty($user_list['status']) && $user_list['status'] == 'pending'): ?>
						<a href="manage_users.php?action=activate&id=<?php e($user_list['id']); ?>" class="normal_button">Activate</a>
						<a href="manage_users.php?action=banned&id=<?php e($user_list['id']); ?>" class="normal_button">Ban</a>
					<?php elseif(!empty($user_list['status']) && $user_list['status'] == 'activated'): ?>
						<a href="manage_users.php?action=banned&id=<?php e($user_list['id']); ?>" class="normal_button">Ban</a>
					<?php elseif(!empty($user_list['status']) && $user_list['status'] == 'banned'): ?>
						<a href="manage_users.php?action=activated&id=<?php e($user_list['id']); ?>" class="normal_button">Activated</a>
					<?php endif; ?>
				</td>
				<td><a href="manage_users.php?action='delete'&id=<?php e($user_list['id']); ?>" class="normal_button" onclick="return window.confirm('Are you sure you want to delete this user?');">DELETE</a></td>
				</form>
			</tr>
			<?php endforeach; ?>
		</table>
	</section>
<div id="pagination" style="clear: both;">
		<?php
			if($pagination->total_pages() > 1) {
				if($pagination->has_previous_page()) {
					echo "&nbsp<a href=\"manage_users.php?page=";
					echo $pagination->previous_page();
					echo "\">&laquo; Previous</a>&nbsp";
				}

				for($i=1; $i <= $pagination->total_pages(); $i++) {
					if($i == $page) {
						echo " <span class=\"selected\">{$i}</span> ";
					} else {
						echo "&nbsp<a href=\"manage_users.php?page={$i}\">{$i}</a>&nbsp";
					}
				}

				if($pagination->has_next_page()) {
					echo "&nbsp<a href=\"manage_users.php?page=";
					echo $pagination->next_page(); // htmlentities
					echo "\">Next &raquo;</a>&nbsp";
				}
			}
		?>
	</div>
</div>
</div>
<?php include(SITE_PATH . "template/_footer.php"); ?>