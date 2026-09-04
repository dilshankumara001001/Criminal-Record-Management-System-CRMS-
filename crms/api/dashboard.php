<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');

require_once '../config/database.php';

$db = Database::getInstance();
$conn = $db->getConnection();

try {
    $grave = $conn->query("SELECT COUNT(*) as count FROM criminals WHERE status = 'arrested'")->fetch(PDO::FETCH_ASSOC);
    $solved = $conn->query("SELECT COUNT(*) as count FROM cases WHERE status = 'closed'")->fetch(PDO::FETCH_ASSOC);
    $invest = $conn->query("SELECT COUNT(*) as count FROM cases WHERE status IN ('open', 'ongoing')")->fetch(PDO::FETCH_ASSOC);
    $today = $conn->query("SELECT COUNT(*) as count FROM complaints WHERE DATE(created_at) = CURDATE()")->fetch(PDO::FETCH_ASSOC);
    
    // Recent Activities
    $recent = $conn->query("SELECT 'criminal' as type, full_name as title, created_at FROM criminals ORDER BY created_at DESC LIMIT 2
                             UNION ALL
                             SELECT 'complaint' as type, complainant_name as title, created_at FROM complaints ORDER BY created_at DESC LIMIT 2
                             UNION ALL
                             SELECT 'case' as type, case_title as title, created_at FROM cases ORDER BY created_at DESC LIMIT 2
                             ORDER BY created_at DESC LIMIT 5")->fetchAll();
    
    echo json_encode([
        'status' => 'success',
        'grave_crimes' => (int)$grave['count'],
        'solved_cases' => (int)$solved['count'],
        'under_investigation' => (int)$invest['count'],
        'today_complaints' => (int)$today['count'],
        'recent_activities' => $recent
    ]);
} catch(Exception $e) {
    echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
}
?>