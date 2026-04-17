<?php
require_once '../models/Market.php';
require_once '../models/GameType.php';
require_once '../includes/functions.php';

$market = new Market();
$gameType = new GameType();
$action = $_GET['action'] ?? '';

switch ($action) {
    case 'list':
        $markets = $market->getActiveMarkets();
        echo json_encode(['success' => true, 'data' => $markets]);
        break;
        
    case 'game-types':
        $gameTypes = $gameType->getActiveGameTypes();
        echo json_encode(['success' => true, 'data' => $gameTypes]);
        break;
        
    case 'results':
        $code = $_GET['code'] ?? 'SGP';
        $limit = $_GET['limit'] ?? 10;
        $results = $market->getMarketResults($code, $limit);
        echo json_encode(['success' => true, 'data' => $results]);
        break;
        
    default:
        echo json_encode(['error' => 'Invalid action']);
        http_response_code(400);
}
?>
