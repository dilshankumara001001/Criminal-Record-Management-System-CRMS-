<?php
// ======================================================
// LOGIN API - Start Session and Authenticate User
// ======================================================

session_start(); // 👈 මෙය එකතු කළා!

header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST');
header('Access-Control-Allow-Headers: Content-Type');

require_once '../config/database.php';

$data = json_decode(file_get_contents('php://input'), true);

if (!isset($data['username']) || !isset($data['password'])) {
    echo json_encode(['status' => 'error', 'message' => 'Username and password required']);
    exit;
}

$username = trim($data['username']);
$password = trim($data['password']);

try {
    $db = Database::getInstance();
    $conn = $db->getConnection();
    
    $sql = "SELECT * FROM users WHERE username = :username AND is_active = 1";
    $stmt = $conn->prepare($sql);
    $stmt->execute(['username' => $username]);
    $user = $stmt->fetch(PDO::FETCH_ASSOC);
    
    if ($user && $password === $user['password_hash']) {
        // 👇 Session variables set කරන්න (මෙය එකතු කළා!)
        $_SESSION['user_id'] = $user['user_id'];
        $_SESSION['username'] = $user['username'];
        $_SESSION['full_name'] = $user['full_name'];
        $_SESSION['role'] = $user['role'];
        $_SESSION['logged_in'] = true;
        
        // Update last login
        $updateSql = "UPDATE users SET last_login = NOW() WHERE user_id = :id";
        $updateStmt = $conn->prepare($updateSql);
        $updateStmt->execute(['id' => $user['user_id']]);
        
        echo json_encode([
            'status' => 'success',
            'message' => 'Login successful',
            'user' => [
                'id' => $user['user_id'],
                'username' => $user['username'],
                'full_name' => $user['full_name'],
                'email' => $user['email'],
                'role' => $user['role']
            ]
        ]);
    } else {
        echo json_encode(['status' => 'error', 'message' => 'Invalid username or password!']);
    }
} catch (Exception $e) {
    echo json_encode(['status' => 'error', 'message' => 'Server error: ' . $e->getMessage()]);
}
?>