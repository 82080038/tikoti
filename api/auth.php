<?php
require_once '../includes/auth.php';
require_once '../includes/functions.php';

$auth = new Auth();
$action = $_GET['action'] ?? '';

switch ($action) {
    case 'login':
        $data = json_decode(file_get_contents('php://input'), true);
        $result = $auth->login($data['username'], $data['password']);
        echo json_encode($result);
        break;
        
    case 'logout':
        $auth->logout();
        echo json_encode(['success' => true]);
        break;
        
    case 'register':
        $data = json_decode(file_get_contents('php://input'), true);
        $result = $auth->register(
            $data['username'],
            $data['email'],
            $data['password'],
            $data['full_name']
        );
        echo json_encode($result);
        break;
        
    case 'check':
        echo json_encode(['logged_in' => isLoggedIn()]);
        break;
        
    default:
        echo json_encode(['error' => 'Invalid action']);
        http_response_code(400);
}
?>
