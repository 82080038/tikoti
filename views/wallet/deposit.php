<?php
require_once __DIR__ . '/../../config/config.php';
$pageTitle = 'Deposit - ' . APP_NAME;
require_once __DIR__ . '/../../includes/header.php';
$auth->requireLogin();
?>

<div class="row mb-4">
    <div class="col-12">
        <h1>Deposit</h1>
        <p class="text-muted">Tambah saldo ke wallet Anda</p>
    </div>
</div>

<div class="row">
    <div class="col-md-8">
        <div class="card">
            <div class="card-header">
                <h5 class="card-title mb-0">Form Deposit</h5>
            </div>
            <div class="card-body">
                <form id="depositForm">
                    <div class="mb-3">
                        <label for="amount" class="form-label">Jumlah Deposit</label>
                        <input type="number" class="form-control" id="amount" name="amount" required min="10000" step="1000">
                        <small class="text-muted">Minimal deposit: Rp 10.000</small>
                    </div>
                    
                    <div class="mb-3">
                        <label for="payment_method" class="form-label">Metode Pembayaran</label>
                        <select class="form-select" id="payment_method" name="payment_method" required>
                            <option value="">Pilih Metode Pembayaran</option>
                            <option value="bank_transfer">Transfer Bank</option>
                            <option value="gopay">GoPay</option>
                            <option value="ovo">OVO</option>
                            <option value="dana">Dana</option>
                        </select>
                    </div>
                    
                    <div class="mb-3">
                        <label for="reference" class="form-label">Referensi (Opsional)</label>
                        <input type="text" class="form-control" id="reference" name="reference" placeholder="Nomor referensi pembayaran">
                    </div>
                    
                    <button type="submit" class="btn btn-success">Deposit</button>
                </form>
            </div>
        </div>
    </div>
    
    <div class="col-md-4">
        <div class="card">
            <div class="card-header">
                <h5 class="card-title mb-0">Saldo Saat Ini</h5>
            </div>
            <div class="card-body">
                <h2 id="currentBalance">Rp 0</h2>
            </div>
        </div>
    </div>
</div>

<script src="<?php echo BASE_URL; ?>/assets/js/wallet.js"></script>

<?php require_once __DIR__ . '/../../includes/footer.php'; ?>
