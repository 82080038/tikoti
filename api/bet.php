<?php
require_once '../includes/auth.php';
require_once '../models/Bet.php';
require_once '../models/Wallet.php';
require_once '../includes/functions.php';

$auth = new Auth();
$auth->requireLogin();

$bet = new Bet();
$wallet = new Wallet();
$userId = getCurrentUserId();
$action = $_GET['action'] ?? '';

switch ($action) {
    case 'place':
        $data = json_decode(file_get_contents('php://input'), true);
        
        // Validate input
        if (!validateRequired($data, ['market_id', 'game_type_id', 'bet_number', 'amount'])) {
            echo json_encode(['success' => false, 'message' => 'Missing required fields']);
            exit();
        }
        
        // Check wallet balance
        $walletData = $wallet->getWalletByUserId($userId);
        if (!$walletData || $walletData['balance'] < $data['amount']) {
            echo json_encode(['success' => false, 'message' => 'Insufficient balance']);
            exit();
        }
        
        // Place bet
        $betId = $bet->placeBet(
            $userId,
            $data['market_id'],
            $data['game_type_id'],
            $data['bet_number'],
            $data['amount']
        );
        
        if ($betId) {
            // Deduct from wallet
            $wallet->updateBalance($walletData['wallet_id'], $data['amount'], 'subtract');
            echo json_encode(['success' => true, 'bet_id' => $betId]);
        } else {
            echo json_encode(['success' => false, 'message' => 'Failed to place bet']);
        }
        break;
        
    case 'history':
        $bets = $bet->getBetsByUserId($userId, 20, 0);
        echo json_encode(['success' => true, 'data' => $bets]);
        break;
        
    case 'active':
        $activeBets = $bet->getActiveBetsByUserId($userId);
        echo json_encode(['success' => true, 'data' => $activeBets]);
        break;
        
    default:
        echo json_encode(['error' => 'Invalid action']);
        http_response_code(400);
}
?>
