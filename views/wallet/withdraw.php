<?php
require_once __DIR__ . '/../../config/config.php';
$pageTitle = 'Withdraw - ' . APP_NAME;
require_once __DIR__ . '/../../includes/header.php';
$auth->requireLogin();
?>

<div class="row mb-4">
    <div class="col-12">
        <h1>Withdraw</h1>
        <p class="text-muted">Tarik saldo dari wallet Anda</p>
    </div>
</div>

<div class="row">
    <div class="col-md-8">
        <div class="card">
            <div class="card-header">
                <h5 class="card-title mb-0">Form Withdraw</h5>
            </div>
            <div class="card-body">
                <form id="withdrawForm">
                    <div class="mb-3">
                        <label for="amount" class="form-label">Jumlah Withdraw</label>
                        <input type="number" class="form-control" id="amount" name="amount" required min="50000" step="1000">
                        <small class="text-muted">Minimal withdraw: Rp 50.000</small>
                    </div>
                    
                    <div class="mb-3">
                        <label for="payment_method" class="form-label">Metode Penarikan</label>
                        <select class="form-select" id="payment_method" name="payment_method" required>
                            <option value="">Pilih Metode Penarikan</option>
                            <option value="bank_transfer">Transfer Bank</option>
                            <option value="gopay">GoPay</option>
                            <option value="ovo">OVO</option>
                            <option value="dana">Dana</option>
                        </select>
                    </div>
                    
                    <div class="mb-3">
                        <label for="account_number" class="form-label">Nomor Rekening/Account</label>
                        <input type="text" class="form-control" id="account_number" name="account_number" required>
                    </div>
                    
                    <div class="mb-3">
                        <label for="account_name" class="form-label">Nama Pemilik</label>
                        <input type="text" class="form-control" id="account_name" name="account_name" required>
                    </div>
                    
                    <button type="submit" class="btn btn-danger">Withdraw</button>
                </form>
            </div>
        </div>
    </div>
    
    <div class="col-md-4">
        <div class="card">
            <div class="card-header">
                <h5 class="card-title mb-0">Saldo Tersedia</h5>
            </div>
            <div class="card-body">
                <h2 id="availableBalance">Rp 0</h2>
                <small class="text-muted">Minimal withdraw: Rp 50.000</small>
            </div>
        </div>
    </div>
</div>

<script src="<?php echo BASE_URL; ?>/assets/js/wallet.js"></script>

<?php require_once __DIR__ . '/../../includes/footer.php'; ?>
