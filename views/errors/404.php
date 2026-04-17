<?php
$pageTitle = '404 - Page Not Found';
require_once __DIR__ . '/../../includes/header.php';
?>

<div class="row justify-content-center">
    <div class="col-md-6 text-center">
        <h1 class="display-1">404</h1>
        <h2>Page Not Found</h2>
        <p class="lead">Halaman yang Anda cari tidak ditemukan.</p>
        <a href="<?php echo BASE_URL; ?>" class="btn btn-primary">Kembali ke Beranda</a>
    </div>
</div>

<?php require_once __DIR__ . '/../../includes/footer.php'; ?>
