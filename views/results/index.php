<?php
require_once __DIR__ . '/../../config/config.php';
$pageTitle = 'Hasil Pasaran - ' . APP_NAME;
require_once __DIR__ . '/../../includes/header.php';
$auth->requireLogin();
?>

<div class="row mb-4">
    <div class="col-12">
        <h1>Hasil Pasaran</h1>
        <p class="text-muted">Lihat hasil undian pasaran togel</p>
    </div>
</div>

<div class="row mb-4">
    <div class="col-md-4">
        <select class="form-select" id="marketFilter">
            <option value="SGP">Singapore (SGP)</option>
            <option value="HK">Hong Kong (HK)</option>
            <option value="SDY">Sydney (SDY)</option>
        </select>
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
                <tbody id="marketResults">
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
