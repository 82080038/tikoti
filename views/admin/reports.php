<?php
require_once __DIR__ . '/../../config/config.php';
$pageTitle = 'Laporan - Admin - ' . APP_NAME;
require_once __DIR__ . '/../../includes/header.php';
$auth->requireRole([ROLE_PENGELOLA, ROLE_PEMILIK]);
?>

<div class="row mb-4">
    <div class="col-12">
        <h1>Laporan</h1>
        <p class="text-muted">Laporan dan analisis</p>
    </div>
</div>

<div class="row">
    <div class="col-md-3">
        <div class="card text-white bg-primary">
            <div class="card-body">
                <h5 class="card-title">Total User</h5>
                <h2 class="card-text">0</h2>
            </div>
        </div>
    </div>
    <div class="col-md-3">
        <div class="card text-white bg-success">
            <div class="card-body">
                <h5 class="card-title">Total Taruhan</h5>
                <h2 class="card-text">Rp 0</h2>
            </div>
        </div>
    </div>
    <div class="col-md-3">
        <div class="card text-white bg-info">
            <div class="card-body">
                <h5 class="card-title">Total Payout</h5>
                <h2 class="card-text">Rp 0</h2>
            </div>
        </div>
    </div>
    <div class="col-md-3">
        <div class="card text-white bg-warning">
            <div class="card-body">
                <h5 class="card-title">Profit</h5>
                <h2 class="card-text">Rp 0</h2>
            </div>
        </div>
    </div>
</div>

<div class="card mt-4">
    <div class="card-body">
        <div class="alert alert-info">
            Fitur laporan lengkap akan ditambahkan.
        </div>
    </div>
</div>

<?php require_once __DIR__ . '/../../includes/footer.php'; ?>
