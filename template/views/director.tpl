<!--  -->
<?php include(SITE_PATH . "template/_header.php"); ?>
<div class="wrapper director clearfix">
    <!-- daca exista erori in $_SESSION[''] sunt afisate apoi este eliberata variabila pentru a nu fi afisata aceeasi eroare pe mai multe pagini -->
    <?php if(isset($_SESSION['message'])) {echo "<img src='/yourcinema/template/icons/error.png'><font color='red'>".
    $_SESSION['message']."</font>";unset($_SESSION['message']); } ?>
    <div id="film">
    <div class="primary">
        <!-- se afiseaza datele despre regizor -->
        <h2><?php e($regizor['first_name'] . " " . $regizor['last_name']);?></h2>
        <!-- se verifica daca poza este memorata pe server sau este un URL al pozei -->
        <?php if(strpos($regizor['picture'], 'http') == 0): ?>
            <img src="/yourcinema/assets/directors/<?php echo $regizor['picture']; ?>" />
        <?php else: ?>
            <img src="<?php echo urlencode($regizor['picture']); ?>" />
        <?php endif; ?><br>
        <?php if($_isAdmin): ?>
            <!-- daca utilizatorul este administrator atunci poate sa faca unele schimbari in site -->
            <a href="edit_director.php?director_id=<?php e($regizor['id']); ?>"><input type="button" value="Edit director"></a>
            <a href="delete.php?action=director&director_id=<?php e($regizor['id']); ?>"><input type="button" onclick="return window.confirm('Are you sure you want to delete this director?');" value="Delete director"></a>
        <?php endif; ?>
    </div>
    <div class="secondary">
    <h3><b>Birth place:</b> <?php e($regizor['birth_place']); ?></h3>
    <h3><b>Birth date:</b> <?php e($regizor['birth_date']); ?></h3>
    <h3><b>Country:</b> <?php e($regizor['country']); ?></h3>
    <h3><b>Bio:</b> <?php e($regizor['biography']); ?></h3>
    <br />
    <!-- sunt afisate datele despre filmul/filmele pe care le-a mai regizat -->
    <h2><b>Filmography:</b></h2>
    <?php foreach($regizor_movies as $movie): ?>
        <a href="/yourcinema/film.php?movie_id=<?php e($movie['id']); ?>">
        <?php if(strpos($movie['picture'], 'http') == 0): ?>
            <img style='width:70px;height:100px;vertical-align:middle' src="/yourcinema/assets/movies/<?php e($movie['picture']); ?>" />
        <?php else: ?>
            <img style='width:70px;height:100px;vertical-align:middle' src="<?php echo urlencode($movie['picture']); ?>" />
        <?php endif; ?>
        </a>
        <a href="/yourcinema/film.php?movie_id=<?php e($movie['id']); ?>"><?php e(" " . $movie['name']); ?></a>
        <?php e(" (" . $movie['movie_date'] . ")");?><br>
        <?php if($_isAdmin): ?>
            <a href="delete.php?action=moviedirector&movie_id=<?php e($movie['id']); ?>&director_id=<?php e($regizor['id']); ?>"><input type="button" onclick="return window.confirm('Are you sure you want to delete the link between the director and movie?');" value="Delete movie regizor"></a>
        <?php endif; ?>
    <?php endforeach; ?>
    <!-- se preiau datele despre comentul ce urmeaza sa fie introdus -->
    <form action="director.php?actor_id=<?php e($regizor['id']);?>" method="post">
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
                    echo "<a href='director.php?director_id=".$regizor['id']."&comment_id=".$comment['id']."'>";
                        echo "<input type='submit' name='edit_comment' value='Edit comment'>";
                    echo "</a><br>";
                }
                if($_isAdmin) {
                    echo "<a href='delete.php?action=comment&director_id=".$regizor['id']."&comment_id=".$comment['id']."'>";
                        echo "<input type='submit' name='delete_comment' value='Delete comment'>";
                    echo "</a><br>";
                }
            }
        }
    ?>
</div>
</div>
<?php include(SITE_PATH . "template/_footer.php"); ?>