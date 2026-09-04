<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST');

require_once '../config/database.php';

$db = Database::getInstance();
$method = $_SERVER['REQUEST_METHOD'];

if ($method === 'GET') {
    try {
        $sql = "SELECT c.*, ps.station_name 
                FROM cases c 
                LEFT JOIN police_stations ps ON c.police_station_id = ps.station_id 
                ORDER BY c.case_id DESC";
        $cases = $db->select($sql);
        
        echo json_encode([
            'status' => 'success',
            'data' => $cases,
            'count' => count($cases)
        ]);
    } catch(Exception $e) {
        echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
    }
}

if ($method === 'POST') {
    $data = json_decode(file_get_contents('php://input'), true);
    if (!$data) {
        echo json_encode(['status' => 'error', 'message' => 'Invalid data']);
        exit;
    }
    
    try {
        $count = $db->selectOne("SELECT COUNT(*) as cnt FROM cases");
        $code = 'C-' . date('Y') . '-' . str_pad(($count['cnt'] + 1), 3, '0', STR_PAD_LEFT);
        $data['case_code'] = $code;
        
        $db->insert('cases', $data);
        echo json_encode(['status' => 'success', 'message' => 'Case added']);
    } catch(Exception $e) {
        echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
    }
}
?>