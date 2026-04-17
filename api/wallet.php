<?php
require_once '../includes/auth.php';
require_once '../models/Wallet.php';
require_once '../includes/functions.php';

$auth = new Auth();
$auth->requireLogin();

$wallet = new Wallet();
$userId = getCurrentUserId();
$action = $_GET['action'] ?? '';

switch ($action) {
    case 'balance':
        $walletData = $wallet->getWalletByUserId($userId);
        echo json_encode(['success' => true, 'data' => $walletData]);
        break;
        
    case 'deposit':
        $data = json_decode(file_get_contents('php://input'), true);
        // Process deposit logic here
        echo json_encode(['success' => true, 'message' => 'Deposit request processed']);
        break;
        
    case 'withdraw':
        $data = json_decode(file_get_contents('php://input'), true);
        // Process withdrawal logic here
        echo json_encode(['success' => true, 'message' => 'Withdrawal request processed']);
        break;
        
    default:
        echo json_encode(['error' => 'Invalid action']);
        http_response_code(400);
}
?>
