<?php
require_once '../includes/auth.php';
require_once '../models/User.php';
require_once '../includes/functions.php';

$auth = new Auth();
$auth->requireLogin();

$userModel = new User();
$userId = getCurrentUserId();
$action = $_GET['action'] ?? '';

switch ($action) {
    case 'profile':
        $user = $userModel->getUserById($userId);
        echo json_encode(['success' => true, 'data' => $user]);
        break;
        
    case 'update':
        $data = json_decode(file_get_contents('php://input'), true);
        $result = $userModel->updateUser($userId, $data);
        echo json_encode(['success' => $result]);
        break;
        
    case 'role':
        $role = $userModel->getUserRole($userId);
        echo json_encode(['success' => true, 'data' => ['role' => $role]]);
        break;
        
    default:
        echo json_encode(['error' => 'Invalid action']);
        http_response_code(400);
}
?>
