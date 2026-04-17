<?php
require_once __DIR__ . '/includes/auth.php';

$auth = new Auth();

// Redirect to login if not logged in, otherwise to dashboard
if (isLoggedIn()) {
    header('Location: ' . BASE_URL . '/dashboard.php');
} else {
    header('Location: ' . BASE_URL . '/views/auth/login.php');
}
exit();
?>
