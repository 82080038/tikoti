<?php
require_once __DIR__ . '/../config/database.php';
require_once __DIR__ . '/../config/constants.php';

class Transaction {
    private $db;
    
    public function __construct() {
        $this->db = Database::getInstance();
    }
    
    public function createTransaction($userId, $type, $amount, $paymentMethodId = null, $referenceId = null) {
        $stmt = $this->db->prepare("
            INSERT INTO transactions (user_id, transaction_type, amount, payment_method_id, reference_id, status) 
            VALUES (?, ?, ?, ?, ?, ?)
        ");
        $status = TRANS_STATUS_PENDING;
        $stmt->bind_param("isdiss", $userId, $type, $amount, $paymentMethodId, $referenceId, $status);
        
        if ($stmt->execute()) {
            return $this->db->insert_id;
        }
        
        return false;
    }
    
    public function updateTransactionStatus($transactionId, $status) {
        $stmt = $this->db->prepare("
            UPDATE transactions SET status = ?, updated_at = NOW() 
            WHERE transaction_id = ?
        ");
        
        if ($status === TRANS_STATUS_COMPLETED) {
            $stmt = $this->db->prepare("
                UPDATE transactions SET status = ?, updated_at = NOW(), completed_at = NOW() 
                WHERE transaction_id = ?
            ");
        }
        
        $stmt->bind_param("si", $status, $transactionId);
        
        return $stmt->execute();
    }
    
    public function getTransactionsByUserId($userId, $limit = 20, $offset = 0) {
        $stmt = $this->db->prepare("
            SELECT t.*, pm.name as payment_method_name, pm.code as payment_method_code, pmt.name as payment_method_type_name 
            FROM transactions t 
            LEFT JOIN payment_methods pm ON t.payment_method_id = pm.payment_method_id 
            LEFT JOIN payment_method_types pmt ON pm.payment_method_type_id = pmt.payment_method_type_id
            WHERE t.user_id = ? 
            ORDER BY t.created_at DESC 
            LIMIT ? OFFSET ?
        ");
        $stmt->bind_param("iii", $userId, $limit, $offset);
        $stmt->execute();
        $result = $stmt->get_result();
        
        return $result->fetch_all(MYSQLI_ASSOC);
    }
    
    public function getTransactionById($transactionId) {
        $stmt = $this->db->prepare("
            SELECT t.*, pm.name as payment_method_name, pm.code as payment_method_code, pmt.name as payment_method_type_name 
            FROM transactions t 
            LEFT JOIN payment_methods pm ON t.payment_method_id = pm.payment_method_id 
            LEFT JOIN payment_method_types pmt ON pm.payment_method_type_id = pmt.payment_method_type_id
            WHERE t.transaction_id = ?
        ");
        $stmt->bind_param("i", $transactionId);
        $stmt->execute();
        $result = $stmt->get_result();
        
        return $result->fetch_assoc();
    }
}
?>
