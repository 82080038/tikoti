<?php
require_once __DIR__ . '/../../config/config.php';
$pageTitle = 'Wallet - ' . APP_NAME;
require_once __DIR__ . '/../../includes/header.php';
$auth->requireLogin();
?>

<div class="row mb-4">
    <div class="col-12">
        <h1>Wallet</h1>
        <p class="text-muted">Kelola saldo dan transaksi Anda</p>
    </div>
</div>

<div class="row mb-4">
    <div class="col-md-6">
        <div class="card text-white bg-success">
            <div class="card-body">
                <h5 class="card-title">Saldo Aktif</h5>
                <h2 class="card-text" id="activeBalance">Rp 0</h2>
            </div>
        </div>
    </div>
    <div class="col-md-6">
        <div class="card text-white bg-warning">
            <div class="card-body">
                <h5 class="card-title">Saldo Terkunci</h5>
                <h2 class="card-text" id="lockedBalance">Rp 0</h2>
            </div>
        </div>
    </div>
</div>

<div class="row mb-4">
    <div class="col-md-6">
        <a href="<?php echo BASE_URL; ?>/views/wallet/deposit.php" class="btn btn-success btn-lg w-100">
            <i class="fas fa-plus"></i> Deposit
        </a>
    </div>
    <div class="col-md-6">
        <a href="<?php echo BASE_URL; ?>/views/wallet/withdraw.php" class="btn btn-danger btn-lg w-100">
            <i class="fas fa-minus"></i> Withdraw
        </a>
    </div>
</div>

<div class="card">
    <div class="card-header">
        <h5 class="card-title mb-0">Riwayat Transaksi</h5>
    </div>
    <div class="card-body">
        <div class="table-responsive">
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Tipe</th>
                        <th>Jumlah</th>
                        <th>Metode</th>
                        <th>Status</th>
                        <th>Tanggal</th>
                    </tr>
                </thead>
                <tbody id="transactionHistory">
                    <tr>
                        <td colspan="6" class="text-center">Memuat data...</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script src="<?php echo BASE_URL; ?>/assets/js/wallet.js"></script>

<?php require_once __DIR__ . '/../../includes/footer.php'; ?>
