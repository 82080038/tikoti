<?php
require_once __DIR__ . '/../config/database.php';

class GameType {
    private $db;
    
    public function __construct() {
        $this->db = Database::getInstance();
    }
    
    public function getAllGameTypes() {
        $stmt = $this->db->prepare("SELECT * FROM game_types ORDER BY code");
        $stmt->execute();
        $result = $stmt->get_result();
        
        return $result->fetch_all(MYSQLI_ASSOC);
    }
    
    public function getActiveGameTypes() {
        $stmt = $this->db->prepare("SELECT * FROM game_types WHERE is_active = true ORDER BY code");
        $stmt->execute();
        $result = $stmt->get_result();
        
        return $result->fetch_all(MYSQLI_ASSOC);
    }
    
    public function getGameTypeById($gameTypeId) {
        $stmt = $this->db->prepare("SELECT * FROM game_types WHERE game_type_id = ?");
        $stmt->bind_param("i", $gameTypeId);
        $stmt->execute();
        $result = $stmt->get_result();
        
        return $result->fetch_assoc();
    }
    
    public function getGameTypeByCode($code) {
        $stmt = $this->db->prepare("SELECT * FROM game_types WHERE code = ?");
        $stmt->bind_param("s", $code);
        $stmt->execute();
        $result = $stmt->get_result();
        
        return $result->fetch_assoc();
    }
}
?>
