<!--  -->
<?php include(SITE_PATH . "template/_header.php"); ?>
<div class="wrapper actors">

<h2>Actors</h2>
<div id="new_products">
    <!-- afisez toti actorii din baza de date -->
    <?php foreach($actors as $actor): ?>
    <div class="product">
        <div class="product-top">
            <h3><a href="/yourcinema/actor.php?actor_id=<?php echo $actor['id']; ?>"><?php e($actor['first_name'] . " " . $actor['last_name']); ?></a></h3>
            <a href="/yourcinema/actor.php?actor_id=<?php echo $actor['id']; ?>">
            <?php if(strpos($actor['picture'], 'http') == 0): ?>
                <img width="150" src="/yourcinema/assets/actors/<?php echo $actor['picture']; ?>" />
            <?php else: ?>
                <img width="150" src="<?php echo urlencode($actor['picture']); ?>" />
            <?php endif; ?>
            </a>
            <!-- daca utilizatorul este administrator atunci poate sa faca unele schimbari in site -->
            <?php if($_isAdmin): ?>
                <a href="edit_actor.php?actor_id=<?php e($actor['id']); ?>"><input type="submit" name="submit" value="Edit actor"></a>
            <?php endif;?>
        </div>
    </div>
    <?php endforeach; ?>
    <div class="clear"></div>
</div>
<div id="pagination" style="clear: both;">
        <?php
            if($pagination->total_pages() > 1) {
                if($pagination->has_previous_page()) {
                    echo "&nbsp<a href=\"actors.php?page=";
                    echo $pagination->previous_page();
                    echo "\">&laquo; Previous</a>&nbsp";
                }

                for($i=1; $i <= $pagination->total_pages(); $i++) {
                    if($i == $page) {
                        echo " <span class=\"selected\">{$i}</span> ";
                    } else {
                        echo "&nbsp<a href=\"actors.php?page={$i}\">{$i}</a>&nbsp";
                    }
                }

                if($pagination->has_next_page()) {
                    echo "&nbsp<a href=\"actors.php?page=";
                    echo $pagination->next_page(); // htmlentities
                    echo "\">Next &raquo;</a>&nbsp";
                }
            }
        ?>
    </div>
</div>
<?php include(SITE_PATH . "template/_footer.php"); ?>
