<?php

final class Catalog {

    private static $_instance;
    private $db;
    private $lang;

    public $categories;
    public $actors;
    public $directors;

    private function __construct(&$dbc) {
        $this->db = $dbc;
    	$this->_init();
    }

    private final function __clone() { }

    public static function getInstance(&$dbc) {
        if(self::$_instance === null) {
            self::$_instance = new Catalog($dbc);
        }
        return self::$_instance;
    }

    // genereaza toate cateogoriile fimelor, toti actorii si toti regizorii
    private function _init(){
        $this->categories = $this->db->query("SELECT * FROM gen ORDER BY name ASC")->rows;
        $this->actors = $this->db->query("SELECT * FROM actor ORDER BY first_name ASC, last_name ASC")->rows;
        $this->directors = $this->db->query("SELECT * FROM regizor ORDER BY first_name ASC, last_name ASC")->rows;
    }

    // numara cate randuri sunt in baza de date cu filters
    public function count($filters = null, $forced_limit = false){
        $sql = "SELECT * FROM filme";
        if(is_array($filters) && count($filters)){
            $sql .= " WHERE " . implode(" AND ", $filters);
        }
        if($forced_limit){
            $sql .= " LIMIT " . intval($forced_limit);
        }
        return $this->db->query($sql)->num_rows;
    }

    // sterge din baza de date
    public function deleteFromTable($table_name, $filters) {
        if($table_name) {
            $sql = "DELETE FROM {$table_name}";
            if(is_array($filters) && count($filters)) {
                $sql .= " WHERE " . implode(" AND ", $filters);
            } elseif(!empty($filters)) {
                $sql .= " WHERE " . $filters;
            }
            return $this->db->query($sql);
        }
    }

    // select din tabelul filme cu filters
    public function fetch($filters = null, $order = null, $offset = 0, $limit = null, $force_limit = null){
        if($limit == null) {
            $limit = query_limit;
        }
        if($order == null){
            $order = array(
                'id' => 'desc'
                );
        }
        $sql = "SELECT * FROM filme";
        if(is_array($filters) && count($filters)){
            $sql .= " WHERE " . implode(" AND ", $filters);
        }
        if(is_array($order) && count($order)){
            $cond = array();
            foreach ($order as $key => $direction) {
                $cond[] = $key . " " . $direction;
            }
            $sql .= " ORDER BY " . implode(", ", $cond);
        }
        $sql .= " LIMIT " . intval($offset) . ", " . intval($limit);
        //die($sql);
        return $this->db->query($sql);
    }

    // selecteaza din baza de date filmele care sunt noi
    public function fetchNewProducts($limit = null, $offset = 0){
        $data = array( );
        $countFilters = array(
            'stoc > 0',
            'price > 0',
            'visible > 0',
            'add_date > ' . (time() - new_label_timespan)
            );
        $data['total'] = $this->count($countFilters);
        $filters = array(
            'picture != ""', 
            'stoc > 0',
            'price > 0',
            'visible > 0',
            'add_date > ' . (time() - new_label_timespan)
            );
        if(defined("EXCLUDE_PRODUCT_ID")){
            $filters[] = 'pid != ' . EXCLUDE_PRODUCT_ID;
        }
        $order['add_date'] = "DESC";
        $query = $this->fetch($filters, $order, $offset, $limit);
        $data['items'] = $query->rows;
        $data['totalWithPics'] = $query->num_rows;
        return $data;
    }

    // selecteaza numele din gen
    public function getGen() {
        return $this->db->query("SELECT name FROM gen")->rows;
    }

    // functie care pune poza in loc de trailer la film
    public function getPictureForTrailer($embed) {
        $part_one_cde = explode("/",$embed);
        $part_2_cde = explode("\"",$part_one_cde[4]);
        $img = "http://img.youtube.com/vi/$part_2_cde[0]/0.jpg";
        return "<img src=\"$img\" width=\"200\" height=\"200\" />";
    }

    // select trailer where limit 1
    public function getTrailer($id) {
        return $this->db->query("SELECT * FROM trailer WHERE filme_id = " . intval($id))->rows;
    }

    // incrementeaza view
    public function increaseViewCount($id){
        $this->db->query("UPDATE filme SET views = views + 1 WHERE id = " . intval($id) . " LIMIT 1");
    }

    // introduce filmul in baza de date
    public function insertMovie($name, $movie_date, $add_date, $movie_year, $sinopsis, $picture, $stoc, $price, $id_gen, $visible) {
        $this->db->query("INSERT INTO filme (name, movie_date, movie_year, add_date, sinopsis, picture, stoc, price, id_gen, visible) 
                            VALUES ('{$name}', '{$movie_date}', {$movie_year}, '{$add_date}', '{$sinopsis}', '{$picture}', 
                                    {$stoc}, {$price}, '{$id_gen}', {$visible})"
                        );
    }

    // selecteaza un produs din filme unde se indeplinesc conditiile
    public function product($id){
        $query = $this->fetch(array(
            'id = ' . intval($id),
            'visible > 0',
            'price > 0'
            ), null, null, 1);
        if(!$query->num_rows) {
            return false;
        }
        return $query->rows[0];
    }

    // selecteaza toate filmele din o categorie de filme
    public function productsFromCategory($category, $limit = null) {
        // SELECT * FROM filme WHERE find_in_set($categoy,id_gen) AND
        $filters = array(
            'find_in_set(' . $category . ',id_gen)',
            'visible > 0',
            'stoc > 0'
            );
        $order = array(
            'add_date' => "DESC"
        );
        return $this->fetch($filters, $order, null, $limit)->rows;
    }

    // redirect la alta pagina
    public function redirect($location = NULL) {
        if($location != NULL) {
            header("Location: {$location}");
            exit;
        }
    }

    // select din orice tabel cu where
    public function selectFromTableWhere($table_name, $where_name = null, $where = null, $limit = null) {
        if($table_name) {
            if($where && $limit) { 
                return $this->db->query("SELECT * FROM " . $table_name . " WHERE " . $where_name . " = " . $where . " LIMIT {$limit}")->rows[0];
            } elseif($where) {
                 return $this->db->query("SELECT * FROM " . $table_name . " WHERE " . $where_name . " = " . $where)->rows;
            } else {
                return $this->db->query("SELECT * FROM " . $table_name)->rows;
            }
        }
    }

    // select din tabel cu LIKE
    public function selectFromTableWhereLike($table_name, $where_name1 = null, $like1 = null, $where_name2 = null, $like2 = null) {
        if($table_name) {
            $query = "SELECT * FROM {$table_name} WHERE {$where_name1} LIKE '%" . $like1 . "%'";
            if(isset($where_name2) && isset($like2)) {
                $query .= " AND {$where_name2} LIKE '%" . $like2 . "%'";
            }
            return $this->db->query($query)->rows;
        }
    }

    // select cu inner join intre 3 tabele pentru a face legatura intre film si actori, regizori
    public function selectWithDoubleInnerJoin($id, $first_table, $inner_table, $last_table) {
        if(isset($first_table) && isset($inner_table) && isset($last_table)) {
            return $this->db->query("SELECT {$first_table}.* FROM {$first_table} 
                                        INNER JOIN {$inner_table} 
                                        ON {$first_table}.id = {$inner_table}.{$first_table}_id 
                                        INNER JOIN {$last_table} 
                                        ON {$inner_table}.{$last_table}_id = {$last_table}.id 
                                        WHERE {$last_table}.id = " . intval($id))->rows;
        } else {
            return false;
        }
    }

    // selecteaza filmele care au views cel mai mare
    public function top10($table) {
        if($table == "filme") {
            return $this->db->query("SELECT id, name, movie_date, picture, views  FROM {$table} ORDER BY views DESC LIMIT 10")->rows;
        } else {
            return $this->db->query("SELECT id, first_name, last_name, birth_place, birth_date, country, picture, views  FROM {$table} ORDER BY views DESC LIMIT 10")->rows;
        }
    }
}