<?php
require_once __DIR__ . '/../../config/config.php';
$pageTitle = 'Settings - ' . APP_NAME;
require_once __DIR__ . '/../../includes/header.php';
$auth->requireLogin();
?>

<div class="row mb-4">
    <div class="col-12">
        <h1>Pengaturan</h1>
        <p class="text-muted">Kelola preferensi akun Anda</p>
    </div>
</div>

<div class="row">
    <div class="col-md-8">
        <div class="card mb-4">
            <div class="card-header">
                <h5 class="card-title mb-0">Ubah Password</h5>
            </div>
            <div class="card-body">
                <form id="passwordForm">
                    <div class="mb-3">
                        <label for="current_password" class="form-label">Password Saat Ini</label>
                        <input type="password" class="form-control" id="current_password" required>
                    </div>
                    
                    <div class="mb-3">
                        <label for="new_password" class="form-label">Password Baru</label>
                        <input type="password" class="form-control" id="new_password" required minlength="8">
                    </div>
                    
                    <div class="mb-3">
                        <label for="confirm_password" class="form-label">Konfirmasi Password Baru</label>
                        <input type="password" class="form-control" id="confirm_password" required>
                    </div>
                    
                    <button type="submit" class="btn btn-primary">Ubah Password</button>
                </form>
            </div>
        </div>
        
        <div class="card">
            <div class="card-header">
                <h5 class="card-title mb-0">Preferensi Notifikasi</h5>
            </div>
            <div class="card-body">
                <form id="notificationForm">
                    <div class="form-check mb-3">
                        <input class="form-check-input" type="checkbox" id="notif_email" checked>
                        <label class="form-check-label" for="notif_email">Notifikasi Email</label>
                    </div>
                    
                    <div class="form-check mb-3">
                        <input class="form-check-input" type="checkbox" id="notif_sms">
                        <label class="form-check-label" for="notif_sms">Notifikasi SMS</label>
                    </div>
                    
                    <div class="form-check mb-3">
                        <input class="form-check-input" type="checkbox" id="notif_push" checked>
                        <label class="form-check-label" for="notif_push">Notifikasi Push</label>
                    </div>
                    
                    <button type="submit" class="btn btn-primary">Simpan Preferensi</button>
                </form>
            </div>
        </div>
    </div>
</div>

<script src="<?php echo BASE_URL; ?>/assets/js/main.js"></script>

<?php require_once __DIR__ . '/../../includes/footer.php'; ?>
