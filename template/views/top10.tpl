<?php include(SITE_PATH . "template/_header.php"); ?>
<div class="wrapper topten clearfix">
<?php if(isset($_SESSION['message'])) {echo "<img src='/yourcinema/template/icons/error.png'><font color='red'>".
    $_SESSION['message']."</font>";unset($_SESSION['message']); } ?>
<div id="film">

<?php
    if(isset($_GET['name']) && ($_GET['name'] == 'actor' || $_GET['name'] == 'regizor' || $_GET['name'] == 'trailer' ||$_GET['name'] == '   filme')) {
        if($_GET['name'] == "filme") {
            $table = "movie";
        } elseif($_GET['name'] == "regizor") {
            $table = "director";
        } else {
            $table = trim(mysql_real_escape_string($_GET['name']));
        }
    } else {
        $table = "movie";
    }
?>

<h2>Top 10 movies</h2>
<div id="new_products">
    <?php foreach($top10 as $top): ?>
    <div class="product">
        <h3>
            <a href="/yourcinema/film.php?movie_id=<?php echo $top['id']; ?>">
                <?php
                    if($table == "movie") {
                        e($top['name'] . " " . $top['views'] . " hits");
                    } elseif($table == "trailer") {
                        e($top['views'] . " hits");
                    } else {
                        e($top['first_name'] . " " . $top['last_name'] . " " . $top['views'] . " hits");
                    }
                ?>
            </a>
        </h3>
        <div class="mdate">
            <?php
                if($table == "movie") {
                    e($top['movie_date']);
                } elseif($table == "trailer") {
                    e($top['data']);
                } else {
                    e($top['birth_place'] . " " . $top['birth_date'] . " " . $top['country']);
                }
            ?>
        </div>
        <?php
            if($table == "trailer") {
                echo($top['trailer']);
            } else {
        ?>
            <a href="/yourcinema/<?php echo($table); ?>.php?film_id=<?php e($top['id']); ?>">
                <?php if(strpos($top['picture'], 'http') == 0): ?>
                    <img width="150" src="/yourcinema/assets/<?php echo $table . "s/" . $top['picture']; ?>" />
                <?php else: ?>
                    <img width="150" src="<?php echo urlencode($top['picture']); ?>" />
                <?php endif; ?>
            </a>
        <?php
            }
        ?>
    </div>
    <?php endforeach; ?>
    <div class="clear"></div>
</div>
</div>




</div>
<?php include(SITE_PATH . "template/_footer.php"); ?>
