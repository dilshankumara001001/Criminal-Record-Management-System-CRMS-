<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE');

require_once '../config/database.php';

$db = Database::getInstance();
$method = $_SERVER['REQUEST_METHOD'];

// GET - Fetch all criminals
if ($method === 'GET') {
    try {
        $sql = "SELECT c.*, ps.station_name 
                FROM criminals c 
                LEFT JOIN police_stations ps ON c.police_station_id = ps.station_id 
                ORDER BY c.criminal_id DESC";
        $criminals = $db->select($sql);
        
        echo json_encode([
            'status' => 'success',
            'data' => $criminals,
            'count' => count($criminals)
        ]);
    } catch(Exception $e) {
        echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
    }
}

// POST - Add new criminal
if ($method === 'POST') {
    $data = json_decode(file_get_contents('php://input'), true);
    
    if (!$data) {
        echo json_encode(['status' => 'error', 'message' => 'Invalid data']);
        exit;
    }
    
    try {
        // Generate criminal code
        $count = $db->selectOne("SELECT COUNT(*) as cnt FROM criminals");
        $code = 'CRM-' . str_pad(($count['cnt'] + 1), 3, '0', STR_PAD_LEFT);
        $data['criminal_code'] = $code;
        
        $db->insert('criminals', $data);
        
        echo json_encode([
            'status' => 'success',
            'message' => 'Criminal added successfully',
            'id' => $db->getConnection()->lastInsertId()
        ]);
    } catch(Exception $e) {
        echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
    }
}

// DELETE - Remove criminal
if ($method === 'DELETE') {
    $id = $_GET['id'] ?? null;
    if (!$id) {
        echo json_encode(['status' => 'error', 'message' => 'ID required']);
        exit;
    }
    
    try {
        $db->delete('criminals', 'criminal_id = :id', ['id' => $id]);
        echo json_encode(['status' => 'success', 'message' => 'Criminal deleted']);
    } catch(Exception $e) {
        echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
    }
}
?>