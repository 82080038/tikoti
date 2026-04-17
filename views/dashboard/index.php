<?php
require_once __DIR__ . '/../../config/config.php';
$pageTitle = 'Dashboard - ' . APP_NAME;
require_once __DIR__ . '/../../includes/header.php';
$auth->requireLogin();
?>

<div class="row mb-4">
    <div class="col-12">
        <h1>Selamat Datang, <?php echo getCurrentUsername(); ?>!</h1>
        <p class="text-muted">Ringkasan aktivitas akun Anda</p>
    </div>
</div>

<div class="row mb-4">
    <div class="col-md-3">
        <div class="card text-white bg-primary">
            <div class="card-body">
                <h5 class="card-title">Saldo Wallet</h5>
                <h2 class="card-text" id="walletBalance">Rp 0</h2>
            </div>
        </div>
    </div>
    <div class="col-md-3">
        <div class="card text-white bg-success">
            <div class="card-body">
                <h5 class="card-title">Total Taruhan</h5>
                <h2 class="card-text" id="totalBets">0</h2>
            </div>
        </div>
    </div>
    <div class="col-md-3">
        <div class="card text-white bg-info">
            <div class="card-body">
                <h5 class="card-title">Menang</h5>
                <h2 class="card-text" id="totalWins">0</h2>
            </div>
        </div>
    </div>
    <div class="col-md-3">
        <div class="card text-white bg-warning">
            <div class="card-body">
                <h5 class="card-title">Taruhan Aktif</h5>
                <h2 class="card-text" id="activeBets">0</h2>
            </div>
        </div>
    </div>
</div>

<div class="row mb-4">
    <div class="col-md-6">
        <div class="card">
            <div class="card-header">
                <h5 class="card-title mb-0">Taruhan Terakhir</h5>
            </div>
            <div class="card-body">
                <div id="recentBets">
                    <p class="text-muted">Memuat data...</p>
                </div>
            </div>
        </div>
    </div>
    <div class="col-md-6">
        <div class="card">
            <div class="card-header">
                <h5 class="card-title mb-0">Hasil Pasaran Terakhir</h5>
            </div>
            <div class="card-body">
                <div id="recentResults">
                    <p class="text-muted">Memuat data...</p>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="<?php echo BASE_URL; ?>/assets/js/main.js"></script>

<?php require_once __DIR__ . '/../../includes/footer.php'; ?>
