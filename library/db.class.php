<?php
class DB {
	private $driver = null;

	public function __construct($driver, $hostname, $username, $password, $database, $port = 3306) {
		if (file_exists(SITE_PATH . "library/drivers/" . $driver . '.php')) {
			require_once(SITE_PATH . "library/drivers/" . $driver . '.php');
		} else {
			exit('Error: Could not load database file ' . $driver . '!');
		}
				
		$this->driver = new $driver($hostname, $username, $password, $database, $port);
	}
		
  	public function query($sql) {
		return $this->driver->query($sql);
  	}
	
	public function escape($value) {
		return $this->driver->escape($value);
	}
	
  	public function countAffected() {
		return $this->driver->countAffected();
  	}

  	public function getLastId() {
		return $this->driver->getLastId();
  	}	
}
?>