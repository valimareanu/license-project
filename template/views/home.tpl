<!--  -->
<?php include(SITE_PATH . "template/_header.php"); ?>
<div class="wrapper">

<!-- daca exista erori in $_SESSION[''] sunt afisate apoi este eliberata variabila pentru a nu fi afisata aceeasi eroare pe mai multe pagini -->
<?php if(isset($_SESSION['message'])) {echo "<img src='/yourcinema/template/icons/error.png'><font color='red'>".
$_SESSION['message']."</font>";unset($_SESSION['message']); } ?>
<!-- daca utilizatorul a folosit cautarea atunci prima pagina ii va arata rezultatele cautarii -->
<?php if(isset($search_movie) || isset($search_actor) || isset($search_director)) { ?>
<?php if(isset($search_movie)) { ?>
    <div id="new_products">
            <?php foreach($search_movie as $product_movie) { ?>
            <div class="product">
                <div class="product-top">
                    <h3><a href="/yourcinema/film.php?movie_id=<?php echo $product_movie['id']; ?>"><?php e($product_movie['name']); ?></a></h3>
                    <div class="mdate"><?php e($product_movie['movie_date']); ?></div>
                </div>
                <a href="/yourcinema/film.php?movie_id=<?php echo $product_movie['id']; ?>">
                    <?php if(strpos($product_movie['picture'], 'http') == 0): ?>
                        <img width="150" src="/yourcinema/assets/movies/<?php echo $product_movie['picture']; ?>" />
                    <?php else: ?>
                        <img width="150" src="<?php echo urlencode($product_movie['picture']); ?>" />
                    <?php endif; ?>
                </a>
                <?php if(isset($product_movie['sinopsis'])) echo $product_movie['sinopsis']; ?>
            </div>
            <?php } ?>
            </div>
    <?php } if(isset($search_actor)) { ?>
        <div id="new_products">
            <?php foreach($search_actor as $product_actor): ?>
            <div class="product">
                <div class="product-top">
                    <h3><a href="/yourcinema/actor.php?actor_id=<?php echo $product_actor['id']; ?>"><?php e($product_actor['first_name']." ".$product_actor['last_name']); ?></a></h3>
                    <div class="mdate"><?php e($product_actor['birth_date']); ?></div>
                </div>
                <a href="/yourcinema/actor.php?actor_id=<?php echo $product_actor['id']; ?>">
                    <?php if(strpos($product_actor['picture'], 'http') == 0): ?>
                        <img width="150" src="/yourcinema/assets/actors/<?php echo $product_actor['picture']; ?>" />
                    <?php else: ?>
                        <img width="150" src="<?php echo urlencode($product_actor['picture']); ?>" />
                    <?php endif; ?>
                </a>
            </div>
            <?php endforeach; ?>
    <?php } if(isset($search_director)) { ?>
            <?php foreach($search_director as $product_director): ?>
            <div class="product">
                <div class="product-top">
                    <h3><a href="/yourcinema/director.php?director_id=<?php echo $product_director['id']; ?>"><?php e($product_director['first_name']." ".$product_director['last_name']); ?></a></h3>
                    <div class="mdate"><?php e($product_director['birth_date']); ?></div>
                </div>
                <a href="/yourcinema/director.php?director_id=<?php echo $product_director['id']; ?>">
                    <?php if(strpos($product_director['picture'], 'http') == 0): ?>
                        <img width="150" src="/yourcinema/assets/directors/<?php echo $product_director['picture']; ?>" />
                    <?php else: ?>
                        <img width="150" src="<?php echo urlencode($product_director['picture']); ?>" />
                    <?php endif; ?>
                </a>
            </div>
            <?php endforeach; ?>
    <?php } ?>
    <div class="clear"></div>
    </div>
<?php } else { ?>
    <!-- daca nu a fost cautat nimic atunci prima pagina va afisa ultimele filme introduse in functie de data -->
    <h2>Latest movies</h2>
    <div id="new_products">
        <?php foreach($new_products['items'] as $product): ?>
        <div class="product">
            <div class="product-top">
                <h3><a href="/yourcinema/film.php?movie_id=<?php echo $product['id']; ?>"><?php e($product['name']); ?></a></h3>
                <div class="mdate"><?php e($product['movie_date']); ?></div>
            </div>
            <a href="/yourcinema/film.php?movie_id=<?php echo $product['id']; ?>">
            <?php if(strpos($product['picture'], 'http') == 0): ?>
                <img width="150" src="/yourcinema/assets/movies/<?php echo $product['picture']; ?>" />
            <?php else: ?>
                <img width="150" src="<?php echo urlencode($product['picture']); ?>" />
            <?php endif; ?>
            </a>
            <?php echo $product['sinopsis']; ?>
        </div>
        <?php endforeach; ?>
        <div class="clear"></div>
    </div>
    <div id="pagination" style="clear: both;">
        <?php
            if($pagination->total_pages() > 1) {
                if($pagination->has_previous_page()) {
                    echo "&nbsp<a href=\"index.php?page=";
                    echo $pagination->previous_page();
                    echo "\">&laquo; Previous</a>&nbsp";
                }

                for($i=1; $i <= $pagination->total_pages(); $i++) {
                    if($i == $page) {
                        echo " <span class=\"selected\">{$i}</span> ";
                    } else {
                        echo "&nbsp<a href=\"index.php?page={$i}\">{$i}</a>&nbsp";
                    }
                }

                if($pagination->has_next_page()) {
                    echo "&nbsp<a href=\"index.php?page=";
                    echo $pagination->next_page(); // htmlentities
                    echo "\">Next &raquo;</a>&nbsp";
                }
            }
        ?>
    </div>
    <?php } ?>
</div>
<?php include(SITE_PATH . "template/_footer.php"); ?>
