<?php include(SITE_PATH . "template/_header.php"); ?>
<div class="wrapper user clearfix">

<?php if(isset($_SESSION['message'])) {echo "<img src='/yourcinema/template/icons/error.png'><font color='red'>".
    $_SESSION['message']."</font>";unset($_SESSION['message']); } ?>

<div id="film">
    <div class="primary">
        <h3><?php
                if(!empty($unread_message)) {
                    echo("<a href='user_profile.php?action=unread'><font color='red'>" . $unread_message . "</font></a>");
                } else {
                    echo("<a href='user_profile.php?action=messages'><font color='red'>" . "Your messages" . "</font></a>");
                }
            ?></h3>
        <h3><?php e($userAccountData['username']); ?></h3>
        <?php if(strpos($userAccountData['picture'], 'http') == 0): ?>
            <img width="150" src="/yourcinema/assets/users/<?php if(!empty($userAccountData['picture'])) {e($userAccountData['picture']);}
                    else { e('all.jpg'); }?>" />
        <?php else: ?>
            <img width="150" src="<?php echo urlencode($userAccountData['picture']); ?>" />
        <?php endif; ?><br />
        <p><b>Username: <?php e($userAccountData['username']); ?></b></p>
        <p>First name: <?php e($userAccountData['first_name']); ?></p>
        <p>Last name: <?php e($userAccountData['last_name']); ?></p>
        <p>Email: <?php e($userAccountData['email']); ?></p>
        <p>Bio: <?php e($userAccountData['bio']); ?></p>
        <p>Created: <?php e($userAccountData['created']); ?></p>
        <a href="edit_user.php"><input type="button" value="Edit user"></a>
        <?php
            $no = 0;
            $total = 0;
            foreach ($userOrdersData as $order) {
                $total += $order['total'];
                $no++;
            }
        ?>
        <p>Total orders: <?php e($no); ?></p>
        <p>Total cost: <?php e($total); ?></p>
        <h3><b>Change password</b></h3>
        <form action="" method="post">
        <dl>
            <dt>New password:</dt>
            <dd><input class="input2" type="password" name="new_password" /></dd>
        </dl>
        <dl>
            <dt>Repeat password:</dt>
            <dd><input class="input2" type="password" name="new_password2" /></dd>
        </dl>
        <dl>
            <dt></dt>
            <dd><input type="submit" name="chpass_submit" value="Change"></dd>
        </dl>
    </form>
    </div>
    <div class="secondary">
        <form action="" method="post" class="change-pass clearfix">
            <dl>
                <dt>New password:</dt>
                <dd><input class="input2" type="password" name="new_password" /></dd>
            </dl>
            <dl>
                <dt>Repeat password:</dt>
                <dd><input class="input2" type="password" name="new_password2" /></dd>
            </dl>
            <dl>
                <dt></dt>
                <dd><input type="submit" name="chpass_submit" value="Change"></dd>
            </dl>
        </form>

        <h3><b>Personal data</b></h3>
        <form action="" method="post" class="personal-data clearfix">
            <dl>
                <dt>Person type:</dt>
                <dd>
                    <input type="radio" name="person_type" value="Natural person" id="pf"<?php if(isset($userPersonalData['person_type']) && $userPersonalData['person_type']=="Natural person") echo ' checked="checked"'; ?>><label for="pf"> Natural person</label> &nbsp; &nbsp;
                    <input type="radio" name="person_type" value="Juridical person" id="pj"<?php if(isset($userPersonalData['person_type']) && $userPersonalData['person_type']=="Juridical person") echo ' checked="checked"'; ?>><label for="pj"> Juridical person</label>
                </dd>
            </dl>
            <dl>
                <dt>Full name:</dt>
                <dd><input class="input3" type="text" name="full_name" value="<?php if(isset($userPersonalData['full_name'])) e($userPersonalData['full_name']); ?>" /></dd>
            </dl>
            <dl>
                <dt>Company:</dt>
                <dd><input class="input3" type="text" name="company" value="<?php if(isset($userPersonalData['company'])) e($userPersonalData['company']); ?>" /></dd>
            </dl>
            <dl>
                <dt>Commercial Register Number:</dt>
                <dd><input class="input2" type="text" name="commercial_register_number" value="<?php if(isset($userPersonalData['commercial_register_number'])) e($userPersonalData['commercial_register_number']); ?>" /></dd>
            </dl>
            <dl>
                <dt>Tax Identification Number:</dt>
                <dd><input class="input2" type="text" name="tax_identification_number" value="<?php if(isset($userPersonalData['tax_identification_number'])) e($userPersonalData['tax_identification_number']); ?>" /></dd>
            </dl>
            <dl>
                <dt>Telephone:</dt>
                <dd><input class="input2" type="text" name="telephone" value="<?php if(isset($userPersonalData['telephone'])) e($userPersonalData['telephone']); ?>" /></dd>
            </dl>
            <dl>
                <dt>Adress:</dt>
                <dd><input class="input3" type="text" name="adress" value="<?php if(isset($userPersonalData['address'])) e($userPersonalData['address']); ?>" /></dd>
            </dl>
            <dl>
                <dt>City:</dt>
                <dd><input class="input3" type="text" name="city" value="<?php if(isset($userPersonalData['city'])) e($userPersonalData['city']); ?>" /></dd>
            </dl>
            <dl>
                <dt>Country:</dt>
                <dd><input class="input3" type="text" name="country" value="<?php if(isset($userPersonalData['country'])) e($userPersonalData['country']); ?>" /></dd></dd>
            </dl>
            <dl>
                <dt></dt>
                <dd><input type="submit" name="dp_submit" value="Save"></dd>
            </dl>
        </form>

        <h3><b>Orders</b></h3>
        <ul id="ordersList">
            <?php if(count($userOrdersData)): ?>
                <?php foreach ($userOrdersData as $order): ?>
                <li>
                    <div class="order_head">
                        <div class="order_status"><?php e($order['status']); ?></div>
                        <b>Order</b> <mark>#<?php echo $order['order_id']; ?></mark>
                        <span class="order_date">(<?php echo $order['add_date']; ?>)</span>
                        <div class="clear"></div>
                    </div>
                    <div class="order_body">
                        <?php foreach ($order['products'] as $product): ?>
                            <div class="order_product">
                                <div class="op_price"><?php c($order['total']); ?> RON</div>
                                <?php
                                    e($order['full_name']);
                                    if($product['name']) {
                                        echo " <i> - " . e($product['name'], false) . "<img style='vertical-align:middle' width='50' src='/yourcinema/assets/movies/".e($product['picture'], false)."'" . "</i>";
                                    }
                                ?>
                                <div class="clear"></div>
                            </div>
                        <?php endforeach; ?>
                    </div>
                </li>
                <?php endforeach; ?>
            <?php else: ?>
                <hr />
                <p><b>You do not have any orders yet.</b></p>
                <p>You can see the details of your order here as soon as you have one.</p>
            <?php endif; ?>
        </ul>
    </div>
</div>
</div>

<?php include(SITE_PATH . "template/_footer.php"); ?>