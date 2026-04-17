<?php
require_once __DIR__ . '/../config/database.php';

class Wallet {
    private $db;
    
    public function __construct() {
        $this->db = Database::getInstance();
    }
    
    public function getWalletByUserId($userId) {
        $stmt = $this->db->prepare("SELECT w.*, c.code as currency_code, c.name as currency_name, c.symbol as currency_symbol FROM wallets w LEFT JOIN currencies c ON w.currency_id = c.currency_id WHERE w.user_id = ? AND w.is_active = true");
        $stmt->bind_param("i", $userId);
        $stmt->execute();
        $result = $stmt->get_result();
        
        return $result->fetch_assoc();
    }
    
    public function createWallet($userId, $currencyCode = 'IDR') {
        // Get currency_id from code
        $stmt = $this->db->prepare("SELECT currency_id FROM currencies WHERE code = ?");
        $stmt->bind_param("s", $currencyCode);
        $stmt->execute();
        $result = $stmt->get_result();
        $currency = $result->fetch_assoc();
        
        if (!$currency) {
            return false;
        }
        
        $stmt = $this->db->prepare("INSERT INTO wallets (user_id, balance, locked_balance, currency_id) VALUES (?, 0, 0, ?)");
        $stmt->bind_param("ii", $userId, $currency['currency_id']);
        
        return $stmt->execute();
    }
    
    public function updateBalance($walletId, $amount, $type = 'add') {
        if ($type === 'add') {
            $sql = "UPDATE wallets SET balance = balance + ? WHERE wallet_id = ?";
        } else {
            $sql = "UPDATE wallets SET balance = balance - ? WHERE wallet_id = ?";
        }
        
        $stmt = $this->db->prepare($sql);
        $stmt->bind_param("di", $amount, $walletId);
        
        return $stmt->execute();
    }
    
    public function checkSufficientBalance($walletId, $amount) {
        $stmt = $this->db->prepare("SELECT balance FROM wallets WHERE wallet_id = ?");
        $stmt->bind_param("i", $walletId);
        $stmt->execute();
        $result = $stmt->get_result();
        $wallet = $result->fetch_assoc();
        
        return $wallet && $wallet['balance'] >= $amount;
    }
}
?>
