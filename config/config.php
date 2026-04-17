<?php
// Enable all error reporting for development
error_reporting(E_ALL);
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);

session_start();

// Application settings
define('APP_NAME', 'Togeli');
define('BASE_URL', 'http://localhost/tikoti');
define('APP_VERSION', '1.0.0');

// Development mode
define('ENVIRONMENT', 'development');

// Security
define('SESSION_TIMEOUT', 3600); // 1 hour
define('MAX_LOGIN_ATTEMPTS', 5);
define('PASSWORD_MIN_LENGTH', 8);

// File upload settings
define('UPLOAD_DIR', __DIR__ . '/../uploads/');
define('MAX_FILE_SIZE', 5242880); // 5MB
define('ALLOWED_FILE_TYPES', ['jpg', 'jpeg', 'png', 'pdf']);

// Pagination
define('ITEMS_PER_PAGE', 20);

// Timezone
date_default_timezone_set('Asia/Jakarta');
?>
