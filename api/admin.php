<?php
require_once '../includes/auth.php';
require_once '../models/User.php';
require_once '../models/Market.php';
require_once '../includes/functions.php';

$auth = new Auth();
$auth->requireRole([ROLE_PENGELOLA, ROLE_PEMILIK]);

$userModel = new User();
$marketModel = new Market();
$action = $_GET['action'] ?? '';

switch ($action) {
    case 'users':
        $users = $userModel->getAllUsers(50, 0);
        echo json_encode(['success' => true, 'data' => $users]);
        break;
        
    case 'markets':
        $markets = $marketModel->getAllMarkets();
        echo json_encode(['success' => true, 'data' => $markets]);
        break;
        
    default:
        echo json_encode(['error' => 'Invalid action']);
        http_response_code(400);
}
?>
