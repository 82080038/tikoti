<?php
require_once __DIR__ . '/../../config/config.php';
$pageTitle = 'Profile - ' . APP_NAME;
require_once __DIR__ . '/../../includes/header.php';
$auth->requireLogin();
?>

<div class="row mb-4">
    <div class="col-12">
        <h1>Profile</h1>
        <p class="text-muted">Kelola informasi profil Anda</p>
    </div>
</div>

<div class="row">
    <div class="col-md-8">
        <div class="card">
            <div class="card-header">
                <h5 class="card-title mb-0">Informasi Profil</h5>
            </div>
            <div class="card-body">
                <form id="profileForm">
                    <div class="mb-3">
                        <label for="username" class="form-label">Username</label>
                        <input type="text" class="form-control" id="username" readonly>
                    </div>
                    
                    <div class="mb-3">
                        <label for="email" class="form-label">Email</label>
                        <input type="email" class="form-control" id="email" readonly>
                    </div>
                    
                    <div class="mb-3">
                        <label for="full_name" class="form-label">Nama Lengkap</label>
                        <input type="text" class="form-control" id="full_name" name="full_name">
                    </div>
                    
                    <div class="mb-3">
                        <label for="phone" class="form-label">No. Telepon</label>
                        <input type="tel" class="form-control" id="phone" name="phone">
                    </div>
                    
                    <div class="mb-3">
                        <label for="date_of_birth" class="form-label">Tanggal Lahir</label>
                        <input type="date" class="form-control" id="date_of_birth" name="date_of_birth">
                    </div>
                    
                    <button type="submit" class="btn btn-primary">Simpan</button>
                </form>
            </div>
        </div>
    </div>
    
    <div class="col-md-4">
        <div class="card">
            <div class="card-header">
                <h5 class="card-title mb-0">Status Akun</h5>
            </div>
            <div class="card-body">
                <p><strong>Status:</strong> <span id="accountStatus" class="badge"></span></p>
                <p><strong>KYC Status:</strong> <span id="kycStatus" class="badge"></span></p>
                <p><strong>Role:</strong> <span id="userRole"></span></p>
                <p><strong>Bergabung:</strong> <span id="joinedDate"></span></p>
            </div>
        </div>
    </div>
</div>

<script src="<?php echo BASE_URL; ?>/assets/js/main.js"></script>

<?php require_once __DIR__ . '/../../includes/footer.php'; ?>
