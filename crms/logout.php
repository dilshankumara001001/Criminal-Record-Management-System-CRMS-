<?php
// ======================================================
// LOGOUT - Destroy Session and Clear LocalStorage
// ======================================================

// Start session
session_start();

// Destroy all session data
$_SESSION = array();
session_unset();
session_destroy();

// Delete session cookie
if (ini_get("session.use_cookies")) {
    $params = session_get_cookie_params();
    setcookie(session_name(), '', time() - 42000,
        $params["path"], $params["domain"],
        $params["secure"], $params["httponly"]
    );
}

// Redirect to login page with logout parameter
header("Location: login.html?logout=success");
exit();
?>