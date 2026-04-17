<?php
require_once __DIR__ . '/../../config/config.php';
$pageTitle = 'Riwayat Hasil - ' . APP_NAME;
require_once __DIR__ . '/../../includes/header.php';
$auth->requireLogin();
?>

<div class="row mb-4">
    <div class="col-12">
        <h1>Riwayat Hasil</h1>
        <p class="text-muted">Riwayat lengkap hasil pasaran</p>
    </div>
</div>

<div class="card">
    <div class="card-body">
        <div class="table-responsive">
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>Pasaran</th>
                        <th>Tanggal</th>
                        <th>Hasil</th>
                        <th>As</th>
                        <th>Kop</th>
                        <th>Kepala</th>
                        <th>Ekor</th>
                    </tr>
                </thead>
                <tbody id="resultHistory">
                    <tr>
                        <td colspan="7" class="text-center">Memuat data...</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script src="<?php echo BASE_URL; ?>/assets/js/main.js"></script>

<?php require_once __DIR__ . '/../../includes/footer.php'; ?>
