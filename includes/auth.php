<?php
require_once __DIR__ . '/../config/database.php';
require_once __DIR__ . '/functions.php';
require_once __DIR__ . '/../config/constants.php';

class Auth {
    private $db;
    
    public function __construct() {
        $this->db = Database::getInstance();
    }
    
    public function login($username, $password) {
        $stmt = $this->db->prepare("SELECT * FROM users WHERE username = ? OR email = ?");
        $stmt->bind_param("ss", $username, $username);
        $stmt->execute();
        $result = $stmt->get_result();
        
        if ($result->num_rows === 1) {
            $user = $result->fetch_assoc();
            
            if (password_verify($password, $user['password_hash'])) {
                if ($user['status'] === STATUS_ACTIVE) {
                    $_SESSION['user_id'] = $user['user_id'];
                    $_SESSION['username'] = $user['username'];
                    $_SESSION['role'] = $this->getUserRole($user['user_id']);
                    $_SESSION['last_activity'] = time();
                    
                    $this->updateLastLogin($user['user_id']);
                    
                    return [
                        'success' => true,
                        'user' => $this->getUserData($user['user_id'])
                    ];
                } else {
                    return ['success' => false, 'message' => 'Account tidak aktif'];
                }
            }
        }
        
        return ['success' => false, 'message' => 'Username atau password salah'];
    }
    
    public function logout() {
        session_destroy();
        unset($_SESSION);
    }
    
    public function requireLogin() {
        if (!isLoggedIn()) {
            header('Location: ' . BASE_URL . '/views/auth/login.php');
            exit();
        }
    }
    
    public function requireRole($requiredRoles) {
        $this->requireLogin();
        
        if (!in_array($_SESSION['role'], $requiredRoles)) {
            header('Location: ' . BASE_URL . '/dashboard.php');
            exit();
        }
    }
    
    private function getUserRole($userId) {
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
    
    private function getUserData($userId) {
        $stmt = $this->db->prepare("SELECT user_id, username, email, full_name, status FROM users WHERE user_id = ?");
        $stmt->bind_param("i", $userId);
        $stmt->execute();
        $result = $stmt->get_result();
        
        return $result->fetch_assoc();
    }
    
    private function updateLastLogin($userId) {
        $stmt = $this->db->prepare("UPDATE users SET last_login_at = NOW(), last_login_ip = ? WHERE user_id = ?");
        $ip = $_SERVER['REMOTE_ADDR'];
        $stmt->bind_param("si", $ip, $userId);
        $stmt->execute();
    }
    
    public function register($username, $email, $password, $fullName) {
        // Check if username exists
        $stmt = $this->db->prepare("SELECT user_id FROM users WHERE username = ? OR email = ?");
        $stmt->bind_param("ss", $username, $email);
        $stmt->execute();
        
        if ($stmt->get_result()->num_rows > 0) {
            return ['success' => false, 'message' => 'Username atau email sudah digunakan'];
        }
        
        // Hash password
        $passwordHash = password_hash($password, PASSWORD_BCRYPT);
        
        // Insert user
        $stmt = $this->db->prepare("INSERT INTO users (username, email, password_hash, full_name, status, kyc_status) VALUES (?, ?, ?, ?, ?, ?)");
        $status = STATUS_PENDING;
        $kycStatus = KYC_NOT_SUBMITTED;
        $stmt->bind_param("ssssss", $username, $email, $passwordHash, $fullName, $status, $kycStatus);
        
        if ($stmt->execute()) {
            $userId = $this->db->insert_id;
            
            // Assign default role
            $stmt = $this->db->prepare("INSERT INTO user_roles (user_id, role) VALUES (?, ?)");
            $role = ROLE_PEMAIN;
            $stmt->bind_param("is", $userId, $role);
            $stmt->execute();
            
            // Create wallet with default currency (IDR)
            // Get currency_id for IDR
            $currencyStmt = $this->db->prepare("SELECT currency_id FROM currencies WHERE code = 'IDR'");
            $currencyStmt->execute();
            $currencyResult = $currencyStmt->get_result();
            $currency = $currencyResult->fetch_assoc();
            
            if ($currency) {
                $stmt = $this->db->prepare("INSERT INTO wallets (user_id, balance, locked_balance, currency_id) VALUES (?, 0, 0, ?)");
                $stmt->bind_param("ii", $userId, $currency['currency_id']);
                $stmt->execute();
            }
            
            return ['success' => true, 'user_id' => $userId];
        }
        
        return ['success' => false, 'message' => 'Gagal mendaftar'];
    }
}
?>
