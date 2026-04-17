<?php
require_once __DIR__ . '/../config/database.php';
require_once __DIR__ . '/../config/constants.php';

class User {
    private $db;
    
    public function __construct() {
        $this->db = Database::getInstance();
    }
    
    public function getUserById($userId) {
        $stmt = $this->db->prepare("SELECT u.user_id, u.username, u.email, u.phone, u.full_name, u.country_id, u.status, u.kyc_status, u.created_at, c.name as country_name, c.code as country_code FROM users u LEFT JOIN countries c ON u.country_id = c.country_id WHERE u.user_id = ?");
        $stmt->bind_param("i", $userId);
        $stmt->execute();
        $result = $stmt->get_result();
        
        return $result->fetch_assoc();
    }
    
    public function getUserByUsername($username) {
        $stmt = $this->db->prepare("SELECT * FROM users WHERE username = ?");
        $stmt->bind_param("s", $username);
        $stmt->execute();
        $result = $stmt->get_result();
        
        return $result->fetch_assoc();
    }
    
    public function createUser($username, $email, $passwordHash, $fullName) {
        $stmt = $this->db->prepare("INSERT INTO users (username, email, password_hash, full_name, status, kyc_status) VALUES (?, ?, ?, ?, ?, ?)");
        $status = STATUS_PENDING;
        $kycStatus = KYC_NOT_SUBMITTED;
        $stmt->bind_param("ssssss", $username, $email, $passwordHash, $fullName, $status, $kycStatus);
        
        if ($stmt->execute()) {
            return $this->db->insert_id;
        }
        
        return false;
    }
    
    public function updateUser($userId, $data) {
        $setClauses = [];
        $params = [];
        $types = '';
        
        foreach ($data as $key => $value) {
            if ($key !== 'user_id') {
                $setClauses[] = "$key = ?";
                $params[] = $value;
                $types .= 's';
            }
        }
        
        if (empty($setClauses)) {
            return false;
        }
        
        $params[] = $userId;
        $types .= 'i';
        
        $sql = "UPDATE users SET " . implode(', ', $setClauses) . " WHERE user_id = ?";
        $stmt = $this->db->prepare($sql);
        $stmt->bind_param($types, ...$params);
        
        return $stmt->execute();
    }
    
    public function getAllUsers($limit = 20, $offset = 0) {
        $stmt = $this->db->prepare("SELECT u.user_id, u.username, u.email, u.full_name, u.country_id, u.status, u.kyc_status, u.created_at, c.name as country_name, c.code as country_code FROM users u LEFT JOIN countries c ON u.country_id = c.country_id ORDER BY u.created_at DESC LIMIT ? OFFSET ?");
        $stmt->bind_param("ii", $limit, $offset);
        $stmt->execute();
        $result = $stmt->get_result();
        
        return $result->fetch_all(MYSQLI_ASSOC);
    }
    
    public function getUserRole($userId) {
        $stmt = $this->db->prepare("SELECT role FROM user_roles WHERE user_id = ? AND is_active = true LIMIT 1");
        $stmt->bind_param("i", $userId);
        $stmt->execute();
        $result = $stmt->get_result();
        
        if ($result->num_rows === 1) {
            $row = $result->fetch_assoc();
            return $row['role'];
        }
        
        return ROLE_PEMAIN;
    }
    
    public function setUserRole($userId, $role) {
        $stmt = $this->db->prepare("INSERT INTO user_roles (user_id, role) VALUES (?, ?)");
        $stmt->bind_param("is", $userId, $role);
        
        return $stmt->execute();
    }
}
?>
