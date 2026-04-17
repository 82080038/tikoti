<?php
require_once __DIR__ . '/../config/database.php';
require_once __DIR__ . '/../config/constants.php';

class Bet {
    private $db;
    
    public function __construct() {
        $this->db = Database::getInstance();
    }
    
    public function placeBet($userId, $marketId, $gameTypeId, $betNumber, $amount, $discountRate = DISCOUNT_RATE) {
        // Get game type for payout multiplier
        $stmt = $this->db->prepare("SELECT payout_multiplier FROM game_types WHERE game_type_id = ?");
        $stmt->bind_param("i", $gameTypeId);
        $stmt->execute();
        $result = $stmt->get_result();
        $gameType = $result->fetch_assoc();
        
        $payoutMultiplier = $gameType['payout_multiplier'] ?? 0;
        
        // Calculate discount and net amount
        $discountAmount = $amount * $discountRate;
        $netAmount = $amount - $discountAmount;
        $potentialPayout = $netAmount * $payoutMultiplier;
        
        // Insert bet
        $stmt = $this->db->prepare("
            INSERT INTO bets (user_id, market_id, game_type_id, bet_number, amount, discount_amount, net_amount, potential_payout, status) 
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
        ");
        $status = BET_STATUS_PENDING;
        $stmt->bind_param("iisddddss", $userId, $marketId, $gameTypeId, $betNumber, $amount, $discountAmount, $netAmount, $potentialPayout, $status);
        
        if ($stmt->execute()) {
            return $this->db->insert_id;
        }
        
        return false;
    }
    
    public function getBetsByUserId($userId, $limit = 20, $offset = 0) {
        $stmt = $this->db->prepare("
            SELECT b.*, m.name as market_name, m.code as market_code, c.name as country_name, c.code as country_code, gt.name as game_type_name, gt.code as game_type_code 
            FROM bets b 
            JOIN markets m ON b.market_id = m.market_id 
            LEFT JOIN countries c ON m.country_id = c.country_id
            JOIN game_types gt ON b.game_type_id = gt.game_type_id 
            WHERE b.user_id = ? 
            ORDER BY b.placed_at DESC 
            LIMIT ? OFFSET ?
        ");
        $stmt->bind_param("iii", $userId, $limit, $offset);
        $stmt->execute();
        $result = $stmt->get_result();
        
        return $result->fetch_all(MYSQLI_ASSOC);
    }
    
    public function getActiveBetsByUserId($userId) {
        $stmt = $this->db->prepare("
            SELECT b.*, m.name as market_name, m.code as market_code, c.name as country_name, c.code as country_code, gt.name as game_type_name, gt.code as game_type_code 
            FROM bets b 
            JOIN markets m ON b.market_id = m.market_id 
            LEFT JOIN countries c ON m.country_id = c.country_id
            JOIN game_types gt ON b.game_type_id = gt.game_type_id 
            WHERE b.user_id = ? AND b.status = ? 
            ORDER BY b.placed_at DESC
        ");
        $status = BET_STATUS_PENDING;
        $stmt->bind_param("is", $userId, $status);
        $stmt->execute();
        $result = $stmt->get_result();
        
        return $result->fetch_all(MYSQLI_ASSOC);
    }
    
    public function updateBetStatus($betId, $status, $payoutAmount = 0) {
        $stmt = $this->db->prepare("
            UPDATE bets SET status = ?, payout_amount = ?, result_time = NOW(), updated_at = NOW() 
            WHERE bet_id = ?
        ");
        $stmt->bind_param("sdi", $status, $payoutAmount, $betId);
        
        return $stmt->execute();
    }
}
?>
