<?php
require_once __DIR__ . '/../config/config.php';
require_once __DIR__ . '/../config/constants.php';

function formatCurrency($amount, $currency = 'IDR') {
    return number_format($amount, 0, ',', '.') . ' ' . $currency;
}

function formatDate($date, $format = 'd M Y H:i') {
    return date($format, strtotime($date));
}

function sanitizeInput($input) {
    return htmlspecialchars(strip_tags(trim($input)));
}

function generateRandomString($length = 32) {
    return bin2hex(random_bytes($length / 2));
}

function sendResponse($success, $data = null, $message = '') {
    header('Content-Type: application/json');
    echo json_encode([
        'success' => $success,
        'data' => $data,
        'message' => $message
    ]);
    exit;
}

function validateRequired($data, $required) {
    foreach ($required as $field) {
        if (!isset($data[$field]) || empty($data[$field])) {
            return false;
        }
    }
    return true;
}

function logError($message, $context = []) {
    $logMessage = date('Y-m-d H:i:s') . ' - ' . $message;
    if (!empty($context)) {
        $logMessage .= ' - ' . json_encode($context);
    }
    error_log($logMessage, 3, __DIR__ . '/../logs/error.log');
}

function isLoggedIn() {
    return isset($_SESSION['user_id']) && 
           isset($_SESSION['last_activity']) &&
           (time() - $_SESSION['last_activity']) < SESSION_TIMEOUT;
}

function getCurrentUserId() {
    return $_SESSION['user_id'] ?? null;
}

function getCurrentUserRole() {
    return $_SESSION['role'] ?? null;
}

function getCurrentUsername() {
    return $_SESSION['username'] ?? null;
}

function updateSessionActivity() {
    $_SESSION['last_activity'] = time();
}
?>
