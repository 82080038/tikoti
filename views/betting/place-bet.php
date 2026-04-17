<?php
require_once __DIR__ . '/../../config/config.php';
$pageTitle = 'Pasang Taruhan - ' . APP_NAME;
require_once __DIR__ . '/../../includes/header.php';
$auth->requireLogin();
?>

<div class="row mb-4">
    <div class="col-12">
        <h1>Pasang Taruhan</h1>
        <p class="text-muted">Pilih pasaran dan jenis permainan</p>
    </div>
</div>

<div class="row">
    <div class="col-md-4 mb-3">
        <div class="card">
            <div class="card-header">
                <h5 class="card-title mb-0">Pilih Pasaran</h5>
            </div>
            <div class="card-body">
                <select class="form-select" id="marketSelect">
                    <option value="">Pilih Pasaran</option>
                </select>
            </div>
        </div>
    </div>
    
    <div class="col-md-4 mb-3">
        <div class="card">
            <div class="card-header">
                <h5 class="card-title mb-0">Pilih Jenis Permainan</h5>
            </div>
            <div class="card-body">
                <select class="form-select" id="gameTypeSelect">
                    <option value="">Pilih Jenis</option>
                </select>
            </div>
        </div>
    </div>
    
    <div class="col-md-4 mb-3">
        <div class="card">
            <div class="card-header">
                <h5 class="card-title mb-0">Nominal Taruhan</h5>
            </div>
            <div class="card-body">
                <input type="number" class="form-control" id="betAmount" placeholder="Masukkan nominal" min="1000" step="1000">
                <div id="discountInfo" class="mt-2 text-muted small"></div>
            </div>
        </div>
    </div>
</div>

<div class="row">
    <div class="col-md-6 mb-3">
        <div class="card">
            <div class="card-header">
                <h5 class="card-title mb-0">Masukkan Angka</h5>
            </div>
            <div class="card-body">
                <input type="text" class="form-control form-control-lg" id="betNumber" placeholder="Contoh: 1234" maxlength="4">
                <div id="numberValidation" class="mt-2"></div>
            </div>
        </div>
    </div>
    
    <div class="col-md-6 mb-3">
        <div class="card">
            <div class="card-header">
                <h5 class="card-title mb-0">Informasi Taruhan</h5>
            </div>
            <div class="card-body">
                <div class="row mb-2">
                    <div class="col-6">Nominal:</div>
                    <div class="col-6 text-end" id="displayAmount">Rp 0</div>
                </div>
                <div class="row mb-2">
                    <div class="col-6">Diskon:</div>
                    <div class="col-6 text-end text-success" id="displayDiscount">-Rp 0</div>
                </div>
                <div class="row mb-2">
                    <div class="col-6">Net Amount:</div>
                    <div class="col-6 text-end fw-bold" id="displayNetAmount">Rp 0</div>
                </div>
                <div class="row mb-2">
                    <div class="col-6">Potensi Payout:</div>
                    <div class="col-6 text-end text-primary fw-bold" id="displayPayout">Rp 0</div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="row">
    <div class="col-12">
        <button class="btn btn-primary btn-lg w-100" id="placeBetBtn" disabled>
            Pasang Taruhan
        </button>
    </div>
</div>

<script src="<?php echo BASE_URL; ?>/assets/js/betting.js"></script>

<?php require_once __DIR__ . '/../../includes/footer.php'; ?>
