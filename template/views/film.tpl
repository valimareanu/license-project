<!--  -->
<?php include(SITE_PATH . "template/_header.php"); ?>
<div class="wrapper clearfix pdp">
<?php
    // preiau ratingul pentru filmul cu id-ul $_GET['']
    $id = $_GET['movie_id'];
    foreach($rating_rows as $row) {
        $rating_rows = $row;
    }
    for($i=0;$i<1;$i++) {
        // daca total votes exista in baza de date si este diferit de 0 atunci ratingul este (valoarea totala)/(nr total de voturi)
        if(isset($row['total_votes']) && isset($row['total_value']) && $row['total_votes'] != 0) {
            $v = $row['total_votes'];
            $tv = $row['total_value'];
            $rat = $tv/$v;
        } else {
            // daca nr total de voturi este 0 si ratingul o sa fie tot 0
            $v=0;
            $rat=0;
        }

        // afisez ratingul
        echo'<div class="product1">
                Rate Movie
                <div id="rating_'.$id.'" class="ratings">';
        for($k=1;$k<6;$k++) {
            if($rat+0.5>$k)$class="star_".$k."  ratings_stars ratings_vote";
            else $class="star_".$k." ratings_stars ratings_blank";
            echo '<div class="'.$class.'"></div>';
        }
        echo' <div class="total_votes"><p class="voted"> Rating: <strong>'.@number_format($rat).'</strong>/5 ('.$v. '  vote(s) cast)
        </div>
        </div></div>';
    }
?>
    <div class="primary">
        <!-- daca exista erori in $_SESSION[''] sunt afisate apoi este eliberata variabila pentru a nu fi afisata aceeasi eroare pe mai multe pagini -->
        <?php if(isset($_SESSION['message'])) {echo "<img src='/yourcinema/template/icons/error.png'><font color='red'>".
        $_SESSION['message']."</font>";unset($_SESSION['message']); } ?>
        <!-- se afiseaza datele despre film -->
        <h3><?php e($film['name']); ?></h3>
        <div class="mdate"><?php e($film['movie_date']); ?></div>
        <!-- se verifica daca poza este memorata pe server sau este un URL al pozei -->
        <?php if(strpos($film['picture'], 'http') == 0): ?>
            <img src="/yourcinema/assets/movies/<?php e($film['picture']); ?>" />
        <?php else: ?>
            <img src="<?php echo urlencode($film['picture']); ?>" />
        <?php endif; ?><br />
        <?php if($_isLogged): ?>
            <!-- daca utilizatorul este logat poate sa adauge filmul la una din urmatoarele liste, verificand daca utilizatorul este sigur -->
            <a href="list.php?movie_id=<?php e($film['id']); ?>&action=like"><input type="submit" name="submit" onclick="return window.confirm('Are you sure you want add this movie into the Movies that i like list?');" value="I like this movie"></a>
            <a href="list.php?movie_id=<?php e($film['id']); ?>&action=to_see"><input type="submit" name="submit" onclick="return window.confirm('Are you sure you want add this movie into the Movies that i need to see list?');" value="I want to see this movie"></a>
            <a href="list.php?movie_id=<?php e($film['id']); ?>&action=hate"><input type="submit" name="submit" onclick="return window.confirm('Are you sure you want add this movie into the Movies that i hate list?');" value="I hated this movie"></a><br>
        <?php endif;?>
        <?php if($_isAdmin): ?>
            <!-- daca utilizatorul este administrator atunci poate sa faca unele schimbari in site -->
            <a href="edit_movie.php?movie_id=<?php e($film['id']); ?>"><input type="button" value="Edit movie"></a>
            <a href="delete.php?action=movie&movie_id=<?php e($film['id']); ?>"><input type="button" onclick="return window.confirm('Are you sure you want to delete this movie?');" value="Delete movie"></a>
        <?php endif;?>
        <br /><br />
        <!-- buton pentru adaugare in cos a filmului -->
        Products remaining: <?php e($film['stoc']); ?><br /><br />
        <?php if($is_in_cart): ?>
            <a href="/yourcinema/film.php?movie_id=<?php e($film['id']); ?>&add_to_cart=add" class="buy_button pdp-cta">BUY</a>
        <?php endif; ?>
    </div>
    <div class="secondary">
        <h3><b>Sinopsis:</b></h3>
        <?php e($film['sinopsis']); ?><br>
        <?php
            if(isset($trailers)) { ?>
                <?php foreach($trailers as $trailer): ?>
                    <a href="trailer.php?trailer_id=<?php e($trailer['id']); ?>&movie_id=<?php e($trailer['filme_id']); ?>">
                        <?php echo $catalog->getPictureForTrailer($trailer['trailer']); ?>
                    </a>
                <?php endforeach; ?>
                <?php if($_isAdmin): ?>
                <a href="edit_trailer.php?trailer_id=<?php e($trailer['id']); ?>"><input type="button" value="Edit trailer"></a>
                <a href="delete.php?action=trailer&trailer_id=<?php e($trailer['id']); ?>"><input type="button" onclick="return window.confirm('Are you sure you want to delete this trailer?');" value="Delete trailer"></a>
                <?php endif; ?>
        <?php } ?>

        <br />
        <!-- sunt afisate datele despre regizor/regizori -->
        <h3><b>Director/Directors:</b></h3>
        <?php foreach($regizors as $regizor): ?>
            <h3><a href="/yourcinema/director.php?director_id=<?php e($regizor['id']); ?>"><?php e($regizor['first_name'] . " " . $regizor['last_name']); ?></a></h3>
            <a href="/yourcinema/director.php?director_id=<?php e($regizor['id']); ?>">
            <?php if(strpos($regizor['picture'], 'http') == 0): ?>
                <img width="100" src="/yourcinema/assets/directors/<?php e($regizor['picture']); ?>" />
            <?php else: ?>
                <img width="100" src="<?php echo urlencode($regizor['picture']); ?>" />
            <?php endif; ?></a> <br />
            <?php if($_isAdmin): ?>
                <a href="delete.php?action=moviedirector&movie_id=<?php e($film['id']); ?>&director_id=<?php e($regizor['id']); ?>"><input type="button" onclick="return window.confirm('Are you sure you want to delete the link between the director and movie?');" value="Delete movie regizor"></a>
            <?php endif; ?>
        <?php endforeach; ?>
        <br />
        <!-- sunt afisate datele despre actor/actori -->
        <h3><b>Actor/Actors:</b></h3>
        <div class="actors-pdp-wrapper">
        <?php foreach($actors as $actor): ?>
            <div class="actor-section">
                <h3><a href="/yourcinema/actor.php?actor_id=<?php e($actor['id']); ?>"><?php e($actor['first_name'] . " " . $actor['last_name']); ?></a></h3>
                <a href="/yourcinema/actor.php?actor_id=<?php e($actor['id']); ?>">
                <?php if(strpos($actor['picture'], 'http') == 0): ?>
                    <img width="100" src="/yourcinema/assets/actors/<?php e($actor['picture']); ?>" />
                <?php else: ?>
                    <img width="100" src="<?php echo urlencode($actor['picture']); ?>" />
                <?php endif; ?></a> <br />
                <?php if($_isAdmin): ?>
                    <a href="delete.php?action=movieactor&movie_id=<?php e($film['id']); ?>&actor_id=<?php e($actor['id']); ?>"><input type="button" onclick="return window.confirm('Are you sure you want to delete the link between the actor and movie?');" value="Delete movie actor"></a>
                <?php endif; ?>
            </div>
        <?php endforeach; ?>
        </div>
        <!-- se preiau datele despre comentul ce urmeaza sa fie introdus -->
        <form action="film.php?movie_id=<?php e($film['id']); if(isset($_GET['comment_id'])) echo("&comment_id=".$_GET['comment_id']);?>" method="post">
            <?php if(!$_isLogged): ?>
                <p class="form-label">Name:</p>
                <input type="text" name="name" value="<?php if(isset($name)) {echo $name;} ?>"><br>
            <?php endif; ?>
                <p class="form-label">Comment:</p>
                <textarea name="comment" cols="35" rows="10"><?php
                if(isset($edit_comment['comment'])) {
                    echo($edit_comment['comment']);
                } elseif(isset($comment)) {
                    echo($comment);
                }
            ?></textarea><br>
            <input  align="center" type="submit" <?php if(isset($_GET['comment_id'])) echo "name='edit_submit'"; else echo "name='submit'";?> value="Insert" />
        </form><bt>
        <!-- se afiseaza comenturile din baza de date despre filmul curent -->
        <?php
            foreach($comments as $comment) {
                if($comment['user_id'] == 0) {
                    // daca user_id == 0 atunci utilizatorul nu era logat atunci cand a lasat comentul deci nu pot sa redirectionez catre profilul
                    // utilizatorului care a lasat comentul
                    echo "<img width='40px' src='/yourcinema/assets/users/".$comment['picture'] . "'> " . $comment['author'];
                } elseif(isset($_SESSION['user_id']) && $_SESSION['user_id'] == $comment['user_id']) {
                    // daca utilizatorul era logat cand a scris comentul si este chiar utilizatorul care foloseste in prezent site-ul web atunci
                    // el va fi redirectionat catre pagina lui de profil
                    echo "<a href=user.php?user_id=" . $comment['user_id'] . "><img width='40px' src='/yourcinema/assets/users/".$comment['picture']."'>" . $comment['author'] . "</a>";
                } else {
                    // daca utilizatorul era logat cand a scris comentul dar nu este utilizatorul care foloseste in prezent site-ul web atunci
                    // el va fi redirectionat catre pagina de profil a celui care a lasat comentul, putand astfel sa ii lase un mesaj privat
                    echo "<a href=user_profile.php?user_id=" . $comment['user_id'] . "><img width='40px' src='/yourcinema/assets/users/";
                        if(strpos($comment['picture'], 'http') == 0) {
                            echo $comment['picture'];
                        } else {
                        echo urlencode($comment['picture']);
                        }
                    echo "'>" . $comment['author'] . "</a>";
                }
                echo " at " . $comment['add_date'];
                echo " wrote:<br>";
                e($comment['comment']);echo "<br>";
                if($_isLogged) {
                    if(($comment['user_id'] == $_SESSION['user_id']) || $_isAdmin) {
                        echo "<a href='film.php?movie_id=".$film['id']."&comment_id=".$comment['id']."'>";
                            echo "<input type='button' name='edit_comment' value='Edit comment'>";
                        echo "</a><br>";
                    }
                    if($_isAdmin) {
                        echo "<a href='delete.php?action=comment&movie_id=".$film['id']."&comment_id=".$comment['id']."'>";
                            echo "<input type='button' name='delete_comment' value='Delete comment'>";
                        echo "</a><br>";
                    }
                }
            }
        ?>
    </div>
    </div>
</div>
<?php include(SITE_PATH . "template/_footer.php"); ?>
