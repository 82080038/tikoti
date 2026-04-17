<?php
$pageTitle = '500 - Server Error';
require_once __DIR__ . '/../../includes/header.php';
?>

<div class="row justify-content-center">
    <div class="col-md-6 text-center">
        <h1 class="display-1">500</h1>
        <h2>Server Error</h2>
        <p class="lead">Terjadi kesalahan pada server. Silakan coba lagi nanti.</p>
        <a href="<?php echo BASE_URL; ?>" class="btn btn-primary">Kembali ke Beranda</a>
    </div>
</div>

<?php require_once __DIR__ . '/../../includes/footer.php'; ?>
