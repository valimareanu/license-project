<?php
if(isset($_POST['order_submit'])) {

	$formData = $_POST;
	$cart = $shop->getCart();
	$add_date = strftime("%Y-%m-%d %H:%M:%S", time());
	do {
		$enough_stock = true;
		foreach ($cart as $item) {
			$stoc = $catalog->selectFromTableWhere('filme', 'id', $item['filme_id'], 1);
			if($item['qty'] >= $stoc['stoc']) {
				$enough_stock = false;
				$_SESSION['message'] = "Sorry not enough stock for movie ". $item['film_name'];
			} 
		}
		
		if(!count($cart)) {
			$_SESSION['message'] = "Your shopping cart is empty.";
			break;
		}
		if(strlen(trim($formData['full_name'])) < 2){
			$_SESSION['full_name'] = "Your full name was invalid.";
		}

		if(!$user->isLogged()){
			if(!$user->validateEmail(trim($formData['email']))){
				$_SESSION['message'] = "Email address is invalid.";
			} elseif($user->isEmailTaken(trim($formData['email']))){
				$_SESSION['message'] = "There allready is an email account with this email address.";
			}
			if(!$user->validatePassword($formData['password'])){
				$_SESSION['message'] = "Password is too short. Please use a longer one.";
				$formData['password'] = "";
				$formData['password2'] = "";
			}
			if($formData['password'] != $formData['password2']){
				$_SESSION['message'] = "Confirmation password doesn't match.";
				$formData['password'] = "";
				$formData['password2'] = "";
			}
		}

		if(!isset($formData['person_type']) || !in_array($formData['person_type'], array("Natural person", "Juridical person"))){
			$_SESSION['message'] = "You have chosen the wrong person type.";
		}
		if(strlen(trim($formData['address'])) < 10 || str_word_count(trim($formData['address'])) < 3){
			$_SESSION['message'] = "Your address is invalid.";
		}
		if(strlen(trim($formData['city'])) < 3){
			$_SESSION['message'] = "Your city is invalid.";
		}

		// am testat datele si continui daca totul este in regula sau ma opresc
		if(isset($_SESSION['message'])){
			$core->data['formData'] = &$formData;
			break;
		} 

		// validarea datelor este corecta, incep sa adaug in baza de date
		$mails = array();
		$total = 0;

		// preiau datele utilizatorului sau creez un cont nou pentru utilizator
		if($user->isLogged()){
			$userData = $user->getData();
			$formData['email'] = $userData['email'];
			$user_id = $userData['id'];
		} else {
			$token = $user->generateToken(6);
			$user_id = $user->register($username = "", $formData['password'], $first_name = "", $last_name = "", 
				$formData['email'], $picture = "all.jpg", $bio = "", $status = "pending", $token, $add_date);
			if($user_id){
				$new_account_mail_body = "Hello,".PHP_EOL.PHP_EOL."To activate your account please click on the following link:".PHP_EOL."http://www".site_domain."activate.php?email=".$formData['email']."/".$token.PHP_EOL.PHP_EOL."We hope you like our services,".PHP_EOL."YourCinema team.";
				$mails[0] = array(
					"to"      => $formData['email'],
					"subject" => "Account activation",
					"body"    => $new_account_mail_body,
					"headers" => "From: YourCinema.com <noreply@yourcinema.com>"
					);
			} else {
				$_SESSION['message'] = "Your account wasn't created. Please try again later or contact the administrator at E-mail address ".administrator_email.".";
				break;
			}
		}
		if(isset($enough_stock) && $enough_stock) {
			// introduc in tabelul order si de asemenea adaug datele in mail
			$delivery = "Address: " . $formData['address'] . PHP_EOL . "City: " . $formData['city'];
			$contact = "Full name: " . $formData['full_name'] . PHP_EOL . "Telephone: " . $formData['telephone'] . PHP_EOL . "E-mail: " . $formData['email'];
			$billing = "Full name: " . $formData['full_name'] . PHP_EOL . "Person type: " . $formData['person_type'] . PHP_EOL . "Address: " . $formData['address'] . PHP_EOL . "City: " . $formData['city'];
			if($formData['person_type'] == "Juridical person"){
				$billing .= PHP_EOL . "Company: " . $formData['company'] . PHP_EOL . "Commercial register number: " . $formData['commercial_register_number'] . PHP_EOL . "Tax identification number: " . $formData['tax_identification_number'];
			}
			$core->db->query("INSERT INTO orders(user_id,full_name,address,telephone,billing_details,add_date,payment_method,shipping_method,obs) 
				VALUES (
				".intval($user_id).",
				'".$core->db->escape($formData['full_name'])."',
				'".$core->db->escape($delivery)."',
				'".$core->db->escape($formData['telephone'])."',
				'".$core->db->escape($billing)."',
				'".$add_date."',
				'".$core->db->escape($formData['payment_method'])."',
				'".$core->db->escape($formData['shipping_method'])."',
				'".$core->db->escape($formData['obs'])."'
				)"
			);
			$order_id = $core->db->getLastId();
			if($order_id){
				$order_mail_body = "Order/Full name: ".$formData['full_name'].PHP_EOL."Person type: ".$formData['person_type'].PHP_EOL."Address: ".$formData['address'].PHP_EOL."City: ".$formData['city'].PHP_EOL."E-mail: ".$formData['email'].PHP_EOL."Telephone: ".$formData['telephone'].PHP_EOL;
				if($formData['person_type']=="Juridical person"){
					$order_mail_body .= "Company: ".$formData['person_type'].PHP_EOL."Commercial register number: ".$formData['commercial_register_number'].PHP_EOL."Tax identification number: ".$formData['tax_identification_number'].PHP_EOL;
				}
				$order_mail_body .= "Payment method: ".$formData['payment_method'].PHP_EOL."Shipping method: ".$formData['shipping_method'].PHP_EOL.PHP_EOL."ORDER #".$order_id.PHP_EOL."Observations: ".$formData['obs'].PHP_EOL.PHP_EOL;
				$mails[1] = array(
					"to"      => $formData['email'],
					"subject" => "Your order details",
					"body"    => $order_mail_body,
					"headers" => "From: YourCinema.com <noreply@yourcinema.com>"
				);
			} else {
				$_SESSION['message'] = "An error has occurred. Please contact the administrator at E-mail address".administrator_email.".";
				break;
			}

			// introduc in tabelul order products si de asemenea adaug datele in email
			$sql = "INSERT INTO order_product (order_id,filme_id,film_name,data,price,qty) VALUES ";
			$itemsStrArr = array( );
			foreach ($cart as $item) {
				$total += $item['price'] * $item['qty'];
				$itemsStrArr[] = "(".$order_id.",".$item['filme_id'].",'".$item['film_name']."', '".$add_date."',".floatval($item['price']).",".$item['qty'].")";
				$mails[1]['body'] .= $item['film_name']." --- ".$item['price']." USD".PHP_EOL;
			}
			$mails[1]['body'] .= PHP_EOL . "TOTAL: " . $total . " USD (without shipping)";
			$sql .= implode(", ", $itemsStrArr);
			$core->db->query($sql);
			if(!$core->db->countAffected()){
				$_SESSION['message'] = "An error has occurred. Please contact the administrator at E-mail address ".administrator_email.".";
				break;
			}

			// scot din stocul; filmului produsele care au fost cumparate
			$core->db->query("UPDATE filme SET stoc=stoc-".$item['qty']." WHERE id=".$item['filme_id']);
		}

		// trimit email administratorului si utilizatorului 
		if(isset($mails[0])) {
			$core->data['_new_account_mail_sent']    = $core->php_mail($mails[0]['to'], $mails[0]['subject'], $mails[0]['body']); // mail catre cont nou
		}
		if(isset($enough_stock) && $enough_stock) {
			$core->data['_order_mail_sent']          = $core->php_mail($mails[1]['to'], $mails[1]['subject'], $mails[1]['body']); // mail catre utilizator
			$core->data['_order_mail_sent_to_admin'] = $core->php_mail(administrator_email, "New Order", $mails[1]['body']); // mail catre administrator
			$core->data['_order_succeeded']          = true;
		}

		// inserez datele personale ale utilizatorului daca este logat
		if($user->isLogged()) {
			$update = $core->db->query("SELECT * FROM user_details WHERE user_id=".$user_id." LIMIT 1")->rows;
			if(empty($update)) {
				$sql = "INSERT INTO user_details (person_type, full_name, address, city, user_id";
				if(isset($formData['company'])) $sql .= ", company";
				if(isset($formData['commercial_register_number'])) $sql .= ", commercial_register_number";
				if(isset($formData['tax_identification_number'])) $sql .= ", tax_identification_number";
				if(isset($formData['telephone'])) $sql .= ", telephone";
				if(isset($formData['country'])) $sql .= ", country";
				$sql .= ") VALUES ( '".$formData['person_type']."', '".$formData['full_name']."', '".$formData['address']."', '".
						$formData['city']."', ".$user_id;
				if(isset($formData['company'])) $sql .= ", '".$formData['company']."'";
				if(isset($formData['commercial_register_number'])) $sql .= ", '".$formData['commercial_register_number']."'";
				if(isset($formData['tax_identification_number'])) $sql .= ", '".$formData['tax_identification_number']."'";
				if(isset($formData['telephone'])) $sql .= ", ".$formData['telephone'];
				if(isset($formData['country'])) $sql .= ", '".$formData['country']."'";
				$sql .= ");";
			} else {
				$sql = "UPDATE user_details SET ";
				if($update['person_type'] != $formData['person_type']) $sql .= "person_type='".$formData['person_type']."'";
				if($update['full_name'] != $formData['full_name']) $sql .= "full_name='".$formData['full_name']."'";
				if($update['company'] != $formData['company']) $sql .= "company='".$formData['company']."'";
				if($update['commercial_register_number'] != $formData['commercial_register_number']) $sql .= "commercial_register_number='".$formData['commercial_register_number']."'";
				if($update['tax_identification_number'] != $formData['tax_identification_number']) $sql .= "tax_identification_number='".$formData['tax_identification_number']."'";
				if($update['telephone'] != $formData['telephone']) $sql .= "telephone=".$formData['telephone'];
				if($update['address'] != $formData['address']) $sql .= "address='".$formData['address']."'";
				if($update['country'] != $formData['country']) $sql .= "country='".$formData['country']."'";
				$sql .= "WHERE user_id=".$user_id;
			}
			$core->db->query($sql);
		}
		if(isset($enough_stock) && $enough_stock) {
			// golesc cosul de cumparaturi
			$shop->emptyCart();
		}
	} while(false);
}