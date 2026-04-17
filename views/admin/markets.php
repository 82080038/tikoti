<?php
require_once __DIR__ . '/../../config/config.php';
$pageTitle = 'Manajemen Pasaran - Admin - ' . APP_NAME;
require_once __DIR__ . '/../../includes/header.php';
$auth->requireRole([ROLE_PENGELOLA, ROLE_PEMILIK]);
?>

<div class="row mb-4">
    <div class="col-12">
        <h1>Manajemen Pasaran</h1>
        <p class="text-muted">Kelola pasaran togel</p>
    </div>
</div>

<div class="card">
    <div class="card-header">
        <h5 class="card-title mb-0">Daftar Pasaran</h5>
    </div>
    <div class="card-body">
        <div class="table-responsive">
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Kode</th>
                        <th>Nama</th>
                        <th>Negara</th>
                        <th>Otoritas</th>
                        <th>Hari</th>
                        <th>Jam</th>
                        <th>Status</th>
                        <th>Aksi</th>
                    </tr>
                </thead>
                <tbody id="marketList">
                    <tr>
                        <td colspan="9" class="text-center">Memuat data...</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script>
$(document).ready(function() {
    $.get(BASE_URL + '/api/index.php?endpoint=admin&action=markets', function(data) {
        if (data.success) {
            let html = '';
            data.data.forEach(market => {
                html += `
                    <tr>
                        <td>${market.market_id}</td>
                        <td>${market.code}</td>
                        <td>${market.name}</td>
                        <td>${market.country || '-'}</td>
                        <td>${market.authority || '-'}</td>
                        <td>${market.draw_days || '-'}</td>
                        <td>${market.result_time || '-'}</td>
                        <td><span class="badge bg-${market.is_active ? 'success' : 'danger'}">${market.is_active ? 'Aktif' : 'Nonaktif'}</span></td>
                        <td>
                            <button class="btn btn-sm btn-primary">Edit</button>
                            <button class="btn btn-sm btn-warning">Toggle</button>
                        </td>
                    </tr>
                `;
            });
            $('#marketList').html(html);
        }
    });
});
</script>

<?php require_once __DIR__ . '/../../includes/footer.php'; ?>
