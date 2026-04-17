<?php
require_once __DIR__ . '/../../config/config.php';
$pageTitle = 'Transaksi - Admin - ' . APP_NAME;
require_once __DIR__ . '/../../includes/header.php';
$auth->requireRole([ROLE_PENGELOLA, ROLE_PEMILIK]);
?>

<div class="row mb-4">
    <div class="col-12">
        <h1>Transaksi</h1>
        <p class="text-muted">Lihat semua transaksi</p>
    </div>
</div>

<div class="card">
    <div class="card-body">
        <div class="alert alert-info">
            Fitur ini akan menampilkan semua transaksi dari semua user.
        </div>
    </div>
</div>

<?php require_once __DIR__ . '/../../includes/footer.php'; ?>
