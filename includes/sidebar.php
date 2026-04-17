<?php
if (!isLoggedIn()) {
    return;
}
?>
<div class="offcanvas offcanvas-start bg-primary text-white" tabindex="-1" id="sidebarMenu">
    <div class="offcanvas-header">
        <h5 class="offcanvas-title"><?php echo APP_NAME; ?></h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="offcanvas"></button>
    </div>
    <div class="offcanvas-body">
        <div class="user-info mb-4 p-3 bg-white bg-opacity-10 rounded">
            <h6 class="mb-1"><?php echo getCurrentUsername(); ?></h6>
            <small class="text-white-50"><?php echo ucfirst(getCurrentUserRole()); ?></small>
        </div>
        
        <ul class="nav flex-column">
            <li class="nav-item">
                <a class="nav-link text-white" href="<?php echo BASE_URL; ?>/dashboard.php">
                    <i class="fas fa-home"></i> Dashboard
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link text-white" href="<?php echo BASE_URL; ?>/views/betting/place-bet.php">
                    <i class="fas fa-dice"></i> Pasang Taruhan
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link text-white" href="<?php echo BASE_URL; ?>/views/betting/history.php">
                    <i class="fas fa-history"></i> Riwayat Taruhan
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link text-white" href="<?php echo BASE_URL; ?>/views/betting/active-bets.php">
                    <i class="fas fa-clock"></i> Taruhan Aktif
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link text-white" href="<?php echo BASE_URL; ?>/views/results/index.php">
                    <i class="fas fa-chart-line"></i> Hasil Pasaran
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link text-white" href="<?php echo BASE_URL; ?>/views/wallet/index.php">
                    <i class="fas fa-wallet"></i> Wallet
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link text-white" href="<?php echo BASE_URL; ?>/views/dashboard/profile.php">
                    <i class="fas fa-user"></i> Profile
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link text-white" href="<?php echo BASE_URL; ?>/views/dashboard/settings.php">
                    <i class="fas fa-cog"></i> Settings
                </a>
            </li>
            
            <?php if (getCurrentUserRole() === ROLE_PENGELOLA || getCurrentUserRole() === ROLE_PEMILIK): ?>
            <li class="nav-item mt-3">
                <div class="text-white-50 small mb-2 px-3">ADMIN</div>
            </li>
            <li class="nav-item">
                <a class="nav-link text-white" href="<?php echo BASE_URL; ?>/views/admin/users.php">
                    <i class="fas fa-users"></i> Manajemen User
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link text-white" href="<?php echo BASE_URL; ?>/views/admin/markets.php">
                    <i class="fas fa-globe"></i> Manajemen Pasaran
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link text-white" href="<?php echo BASE_URL; ?>/views/admin/transactions.php">
                    <i class="fas fa-exchange-alt"></i> Transaksi
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link text-white" href="<?php echo BASE_URL; ?>/views/admin/reports.php">
                    <i class="fas fa-chart-bar"></i> Laporan
                </a>
            </li>
            <?php endif; ?>
            
            <li class="nav-item mt-3">
                <a class="nav-link text-white" href="#" onclick="logout()">
                    <i class="fas fa-sign-out-alt"></i> Logout
                </a>
            </li>
        </ul>
    </div>
</div>
