<?php
require_once __DIR__ . '/includes/auth.php';

$auth = new Auth();
$auth->requireLogin();

// Redirect to dashboard index
header('Location: ' . BASE_URL . '/views/dashboard/index.php');
exit();
?>
