<?php
require_once __DIR__ . '/../../config/config.php';
$pageTitle = 'Login - ' . APP_NAME;
require_once __DIR__ . '/../../includes/header.php';
?>

<div class="row justify-content-center">
    <div class="col-md-6 col-lg-4">
        <div class="card shadow">
            <div class="card-body p-4">
                <div class="text-center mb-4">
                    <h2><?php echo APP_NAME; ?></h2>
                    <p class="text-muted">Masuk ke akun Anda</p>
                </div>
                
                <form id="loginForm">
                    <div class="mb-3">
                        <label for="username" class="form-label">Username atau Email</label>
                        <input type="text" class="form-control" id="username" name="username" required>
                    </div>
                    
                    <div class="mb-3">
                        <label for="password" class="form-label">Password</label>
                        <input type="password" class="form-control" id="password" name="password" required>
                    </div>
                    
                    <div class="mb-3 form-check">
                        <input type="checkbox" class="form-check-input" id="remember">
                        <label class="form-check-label" for="remember">Ingat saya</label>
                    </div>
                    
                    <div class="d-grid">
                        <button type="submit" class="btn btn-primary" id="loginBtn">Login</button>
                    </div>
                    
                    <div class="text-center mt-3">
                        <p>Belum punya akun? <a href="<?php echo BASE_URL; ?>/views/auth/register.php">Daftar</a></p>
                    </div>
                </form>
                
                <div id="loginMessage" class="mt-3"></div>
            </div>
        </div>
    </div>
</div>

<script src="<?php echo BASE_URL; ?>/assets/js/auth.js"></script>

<?php require_once __DIR__ . '/../../includes/footer.php'; ?>
