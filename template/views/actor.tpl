<!--  -->
<?php include(SITE_PATH . "template/_header.php"); ?>
<div class="wrapper actor clearfix">

<div id="film">
    <!-- daca exista erori in $_SESSION[''] sunt afisate apoi este eliberata variabila pentru a nu fi afisata aceeasi eroare pe mai multe pagini -->
    <?php if(isset($_SESSION['message'])) {echo "<img src='/yourcinema/template/icons/error.png'><font color='red'>".
    $_SESSION['message']."</font>";unset($_SESSION['message']); } ?>
    <!-- se afiseaza datele despre actor -->
    <div class="primary">
        <h2><?php e($actor_data['first_name'] . " " . $actor_data['last_name']);?></h2>
        <!-- se verifica daca poza este memorata pe server sau este un URL al pozei -->
        <?php if(strpos($actor_data['picture'], 'http') == 0): ?>
            <img src="/yourcinema/assets/actors/<?php echo $actor_data['picture']; ?>" />
        <?php else: ?>
            <img src="<?php echo urlencode($actor_data['picture']); ?>" />
        <?php endif; ?><br />
        <?php if($_isAdmin): ?>
            <!-- daca utilizatorul este administrator atunci poate sa faca unele schimbari in site -->
            <a href="edit_actor.php?actor_id=<?php e($actor_data['id']); ?>"><input type="button" value="Edit actor"></a>
            <a href="delete.php?action=actor&actor_id=<?php e($actor_data['id']); ?>"><input type="button" onclick="return window.confirm('Are you sure you want to delete the actor?');"  value="Delete actor"></a>
        <?php endif;?>
    </div>
    <div class="secondary">
        <h3><b>Birth place:</b> <?php e($actor_data['birth_place']); ?></h3>
        <h3><b>Birth date:</b> <?php e($actor_data['birth_date']); ?></h3>
        <h3><b>Country:</b> <?php e($actor_data['country']); ?></h3>
        <h3><b>Bio:</b> <?php e($actor_data['biography']); ?></h3>
        <br />
        <!-- sunt afisate datele despre filmul/filmele in care a mai jucat -->
        <h2><b>Filmography:</b></h2>
        <?php foreach($actor_movies as $movie): ?>
            <a href="/yourcinema/film.php?movie_id=<?php e($movie['id']); ?>">
            <?php if(strpos($movie['picture'], 'http') == 0): ?>
                <img style='width:70px;height:100px;vertical-align:middle' src="/yourcinema/assets/movies/<?php e($movie['picture']); ?>" />
            <?php else: ?>
                <img style='width:70px;height:100px;vertical-align:middle' width="100" src="<?php echo urlencode($movie['picture']); ?>" />
            <?php endif; ?>
            </a>
            <a href="/yourcinema/film.php?movie_id=<?php e($movie['id']); ?>"><?php e(" " . $movie['name']); ?></a>
            <?php e(" (" . $movie['movie_date'] . ")");?>
            as <?php e($movie['aka']); ?><br>
            <?php if($_isAdmin): ?>
                <a href="delete.php?action=movieactor&movie_id=<?php e($movie['id']); ?>&actor_id=<?php e($actor_data['id']); ?>"><input type="button" onclick="return window.confirm('Are you sure you want to delete the link between the actor and the movie?');" value="Delete movie actor"></a>
            <?php endif; ?>
        <?php endforeach; ?>
        <!-- se preiau datele despre comentul ce urmeaza sa fie introdus -->
        <form action="actor.php?actor_id=<?php e($actor['id']); if(isset($_GET['comment_id'])) echo("&comment_id=".$_GET['comment_id']);?>" method="post">
            <?php if(!$_isLogged): ?>
                <p class="form-label">Name:</p>
                <input type="text" name="name" value="<?php if(isset($name)) {echo $name;} ?>"><br>
            <?php endif; ?>
             <p class="form-label">Comment:</p>
             <textarea name="comment" cols="35" rows="10">
                <?php if(isset($edit_comment['comment'])) {echo($edit_comment['comment']);} elseif(isset($comment)) {echo($comment);}?>
            </textarea><br>
            <input  align="center" type="submit" name="submit" value="Insert"<?php //if(empty($edit)) {echo "value='Insert'";} else {echo "value='Edit'";}?> />
        </form><bt>
        <!-- se afiseaza comenturile din baza de date despre actorul curent -->
        <?php
            foreach($comments as $comment) {
                if($comment['user_id'] == 0) {
                    // daca user_id == 0 atunci utilizatorul nu era logat atunci cand a lasat comentul deci nu pot sa redirectionez catre profilul
                    // utilizatorului care a lasat comentul
                    echo "<img width='40px' src='/yourcinema/assets/users/".$comment['picture'] . "'> " . $comment['author'];
                } elseif(isset($_SESSION['user_id']) && $_SESSION['user_id'] == $comment['user_id']) {
                    // daca utilizatorul era logat cand a scris comentul si este chiar utilizatorul care foloseste in prezent site-ul web atunci
                    // el va fi redirectionat catre pagina lui de profil
                    echo "<a href=user.php?user_id=" . $comment['user_id'] . "><img width='40px' src='yourcinema/assets/users/".$comment['picture']."'>" . $comment['author'] . "</a>";
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
                        echo "<a href='actor.php?movie_id=".$actor_data['id']."&comment_id=".$comment['id']."'>";
                            echo "<input type='submit' name='edit_comment' value='Edit comment'>";
                        echo "</a><br>";
                    }
                    if($_isAdmin) {
                        echo "<a href='delete.php?action=comment&movie_id=".$actor_data['id']."&comment_id=".$comment['id']."'>";
                            echo "<input type='submit' name='delete_comment' value='Delete comment'>";
                        echo "</a><br>";
                    }
                }
            }
        ?>
        <br />

    </div>
</div>
</div>
<?php include(SITE_PATH . "template/_footer.php"); ?>