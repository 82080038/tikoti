<?php
require_once '../includes/auth.php';
require_once '../models/Transaction.php';
require_once '../includes/functions.php';

$auth = new Auth();
$auth->requireLogin();

$transaction = new Transaction();
$userId = getCurrentUserId();
$action = $_GET['action'] ?? '';

switch ($action) {
    case 'history':
        $transactions = $transaction->getTransactionsByUserId($userId, 20, 0);
        echo json_encode(['success' => true, 'data' => $transactions]);
        break;
        
    case 'create':
        $data = json_decode(file_get_contents('php://input'), true);
        $transactionId = $transaction->createTransaction(
            $userId,
            $data['type'],
            $data['amount'],
            $data['payment_method_id'] ?? null,
            $data['reference_id'] ?? null
        );
        echo json_encode(['success' => $transactionId > 0, 'transaction_id' => $transactionId]);
        break;
        
    default:
        echo json_encode(['error' => 'Invalid action']);
        http_response_code(400);
}
?>
