<!--  -->
<?php include(SITE_PATH . "template/_header.php"); ?>
<div class="wrapper directors">

<h2>Directors</h2>
<div id="new_products">
    <!-- afisez toti regizorii din baza de date -->
    <?php foreach($directors as $director): ?>
    <div class="product">
        <h3><a href="/yourcinema/director.php?actor_id=<?php echo $director['id']; ?>"><?php e($director['first_name'] . " " . $director['last_name']); ?></a></h3>
        <a href="/yourcinema/director.php?director_id=<?php echo $director['id']; ?>">
        <?php if(strpos($director['picture'], 'http') == 0): ?>
            <img width="150" src="/yourcinema/assets/directors/<?php echo $director['picture']; ?>" />
        <?php else: ?>
            <img width="150" src="<?php echo urlencode($director['picture']); ?>" />
        <?php endif; ?>
        </a>
        <!-- daca utilizatorul este administrator atunci poate sa faca unele schimbari in site -->
        <?php if($_isAdmin):?>
            <a href="edit_director.php?director_id=<?php e($director['id']); ?>"><input type="submit" name="submit" value="Edit director"></a>
        <?php endif;?>
    </div>
    <?php endforeach; ?>
    <div class="clear"></div>
</div>
<div id="pagination" style="clear: both;">
        <?php
            if($pagination->total_pages() > 1) {
                if($pagination->has_previous_page()) {
                    echo "&nbsp<a href=\"directors.php?page=";
                    echo $pagination->previous_page();
                    echo "\">&laquo; Previous</a>&nbsp";
                }

                for($i=1; $i <= $pagination->total_pages(); $i++) {
                    if($i == $page) {
                        echo " <span class=\"selected\">{$i}</span> ";
                    } else {
                        echo "&nbsp<a href=\"directors.php?page={$i}\">{$i}</a>&nbsp";
                    }
                }

                if($pagination->has_next_page()) {
                    echo "&nbsp<a href=\"directors.php?page=";
                    echo $pagination->next_page(); // htmlentities
                    echo "\">Next &raquo;</a>&nbsp";
                }
            }
        ?>
    </div>
</div>
<?php include(SITE_PATH . "template/_footer.php"); ?>
