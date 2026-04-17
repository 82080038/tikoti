<?php
require_once __DIR__ . '/../../config/config.php';
$pageTitle = 'Taruhan Aktif - ' . APP_NAME;
require_once __DIR__ . '/../../includes/header.php';
$auth->requireLogin();
?>

<div class="row mb-4">
    <div class="col-12">
        <h1>Taruhan Aktif</h1>
        <p class="text-muted">Taruhan yang sedang menunggu hasil</p>
    </div>
</div>

<div class="card">
    <div class="card-body">
        <div class="table-responsive">
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Pasaran</th>
                        <th>Jenis</th>
                        <th>Angka</th>
                        <th>Nominal</th>
                        <th>Potensi Payout</th>
                        <th>Tanggal</th>
                    </tr>
                </thead>
                <tbody id="activeBets">
                    <tr>
                        <td colspan="7" class="text-center">Memuat data...</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script src="<?php echo BASE_URL; ?>/assets/js/betting.js"></script>

<?php require_once __DIR__ . '/../../includes/footer.php'; ?>
