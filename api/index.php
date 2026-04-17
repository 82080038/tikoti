<?php
require_once '../config/database.php';
require_once '../config/config.php';

header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type, Authorization');

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

$endpoint = $_GET['endpoint'] ?? '';
$method = $_SERVER['REQUEST_METHOD'];

switch ($endpoint) {
    case 'auth':
        require_once 'auth.php';
        break;
    case 'user':
        require_once 'user.php';
        break;
    case 'bet':
        require_once 'bet.php';
        break;
    case 'market':
        require_once 'market.php';
        break;
    case 'wallet':
        require_once 'wallet.php';
        break;
    case 'transaction':
        require_once 'transaction.php';
        break;
    case 'admin':
        require_once 'admin.php';
        break;
    default:
        echo json_encode(['error' => 'Invalid endpoint']);
        http_response_code(404);
}
?>
