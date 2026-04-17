<?php
require_once __DIR__ . '/../../config/config.php';
$pageTitle = 'Daftar - ' . APP_NAME;
require_once __DIR__ . '/../../includes/header.php';
?>

<div class="row justify-content-center">
    <div class="col-md-6 col-lg-4">
        <div class="card shadow">
            <div class="card-body p-4">
                <div class="text-center mb-4">
                    <h2><?php echo APP_NAME; ?></h2>
                    <p class="text-muted">Buat akun baru</p>
                </div>
                
                <form id="registerForm">
                    <div class="mb-3">
                        <label for="username" class="form-label">Username</label>
                        <input type="text" class="form-control" id="username" name="username" required>
                    </div>
                    
                    <div class="mb-3">
                        <label for="email" class="form-label">Email</label>
                        <input type="email" class="form-control" id="email" name="email" required>
                    </div>
                    
                    <div class="mb-3">
                        <label for="full_name" class="form-label">Nama Lengkap</label>
                        <input type="text" class="form-control" id="full_name" name="full_name" required>
                    </div>
                    
                    <div class="mb-3">
                        <label for="password" class="form-label">Password</label>
                        <input type="password" class="form-control" id="password" name="password" required minlength="8">
                        <small class="text-muted">Minimal 8 karakter</small>
                    </div>
                    
                    <div class="mb-3">
                        <label for="confirm_password" class="form-label">Konfirmasi Password</label>
                        <input type="password" class="form-control" id="confirm_password" name="confirm_password" required>
                    </div>
                    
                    <div class="d-grid">
                        <button type="submit" class="btn btn-primary" id="registerBtn">Daftar</button>
                    </div>
                    
                    <div class="text-center mt-3">
                        <p>Sudah punya akun? <a href="<?php echo BASE_URL; ?>/views/auth/login.php">Login</a></p>
                    </div>
                </form>
                
                <div id="registerMessage" class="mt-3"></div>
            </div>
        </div>
    </div>
</div>

<script src="<?php echo BASE_URL; ?>/assets/js/auth.js"></script>

<?php require_once __DIR__ . '/../../includes/footer.php'; ?>
