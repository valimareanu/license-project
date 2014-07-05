<?php 
require("./library/boot.php");

require("./library/handlers/order_submit.php");

if(isset($core->data['_order_succeeded']) && $core->data['_order_succeeded'] == true){ 
	$core->data['title'] = "Order succeeded! - " . site_name;
	$core->template = "order_succeeded"; 
} else {
	if($user->isLogged() && !isset($core->data['formData'])){
		$core->data['formData'] = $user->getPersonalData();
		$userData = $user->getData();
		$core->data['formData']['email'] = $userData['email'];
	}

	$core->data['title'] = "Complete order - " . site_name;
	$core->template = "order";

}

echo $core->render();