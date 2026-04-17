<?php
require_once __DIR__ . '/../config/database.php';

class Market {
    private $db;
    
    public function __construct() {
        $this->db = Database::getInstance();
    }
    
    public function getAllMarkets() {
        $stmt = $this->db->prepare("SELECT m.*, c.name as country_name, c.code as country_code FROM markets m LEFT JOIN countries c ON m.country_id = c.country_id ORDER BY m.code");
        $stmt->execute();
        $result = $stmt->get_result();
        
        return $result->fetch_all(MYSQLI_ASSOC);
    }
    
    public function getActiveMarkets() {
        $stmt = $this->db->prepare("SELECT m.*, c.name as country_name, c.code as country_code FROM markets m LEFT JOIN countries c ON m.country_id = c.country_id WHERE m.is_active = true ORDER BY m.code");
        $stmt->execute();
        $result = $stmt->get_result();
        
        return $result->fetch_all(MYSQLI_ASSOC);
    }
    
    public function getMarketById($marketId) {
        $stmt = $this->db->prepare("SELECT m.*, c.name as country_name, c.code as country_code FROM markets m LEFT JOIN countries c ON m.country_id = c.country_id WHERE m.market_id = ?");
        $stmt->bind_param("i", $marketId);
        $stmt->execute();
        $result = $stmt->get_result();
        
        return $result->fetch_assoc();
    }
    
    public function getMarketByCode($code) {
        $stmt = $this->db->prepare("SELECT m.*, c.name as country_name, c.code as country_code FROM markets m LEFT JOIN countries c ON m.country_id = c.country_id WHERE m.code = ?");
        $stmt->bind_param("s", $code);
        $stmt->execute();
        $result = $stmt->get_result();
        
        return $result->fetch_assoc();
    }
    
    public function getMarketResults($marketCode, $limit = 10) {
        $stmt = $this->db->prepare("
            SELECT mr.*, m.name as market_name 
            FROM market_results mr 
            JOIN markets m ON mr.market_id = m.market_id 
            WHERE m.code = ? 
            ORDER BY mr.draw_date DESC 
            LIMIT ?
        ");
        $stmt->bind_param("si", $marketCode, $limit);
        $stmt->execute();
        $result = $stmt->get_result();
        
        return $result->fetch_all(MYSQLI_ASSOC);
    }
    
    public function addMarketResult($marketCode, $drawDate, $resultNumber) {
        $market = $this->getMarketByCode($marketCode);
        if (!$market) {
            return false;
        }
        
        // Parse result digits
        $asDigit = substr($resultNumber, 0, 1);
        $kopDigit = substr($resultNumber, 1, 1);
        $kepalaDigit = substr($resultNumber, 2, 1);
        $ekorDigit = substr($resultNumber, 3, 1);
        
        $stmt = $this->db->prepare("
            INSERT INTO market_results (market_id, draw_date, result_number, as_digit, kop_digit, kepala_digit, ekor_digit) 
            VALUES (?, ?, ?, ?, ?, ?, ?)
        ");
        $stmt->bind_param("issiiii", $market['market_id'], $drawDate, $resultNumber, $asDigit, $kopDigit, $kepalaDigit, $ekorDigit);
        
        return $stmt->execute();
    }
    
    public function getMarketDrawSchedules($marketId) {
        $stmt = $this->db->prepare("SELECT day_of_week FROM market_draw_schedules WHERE market_id = ? AND is_active = true ORDER BY day_of_week");
        $stmt->bind_param("i", $marketId);
        $stmt->execute();
        $result = $stmt->get_result();
        
        return $result->fetch_all(MYSQLI_ASSOC);
    }
    
    public function getMarketResultTimes($marketId) {
        $stmt = $this->db->prepare("SELECT mrt.*, t.name as timezone_name, t.offset FROM market_result_times mrt LEFT JOIN timezones t ON mrt.timezone_id = t.timezone_id WHERE mrt.market_id = ? AND mrt.is_active = true");
        $stmt->bind_param("i", $marketId);
        $stmt->execute();
        $result = $stmt->get_result();
        
        return $result->fetch_all(MYSQLI_ASSOC);
    }
}
?>
