<?php
require_once __DIR__ . '/../../config/config.php';
$pageTitle = 'Manajemen User - Admin - ' . APP_NAME;
require_once __DIR__ . '/../../includes/header.php';
$auth->requireRole([ROLE_PENGELOLA, ROLE_PEMILIK]);
?>

<div class="row mb-4">
    <div class="col-12">
        <h1>Manajemen User</h1>
        <p class="text-muted">Kelola semua user aplikasi</p>
    </div>
</div>

<div class="card">
    <div class="card-header">
        <h5 class="card-title mb-0">Daftar User</h5>
    </div>
    <div class="card-body">
        <div class="table-responsive">
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Username</th>
                        <th>Email</th>
                        <th>Nama Lengkap</th>
                        <th>Status</th>
                        <th>KYC</th>
                        <th>Bergabung</th>
                        <th>Aksi</th>
                    </tr>
                </thead>
                <tbody id="userList">
                    <tr>
                        <td colspan="8" class="text-center">Memuat data...</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script>
$(document).ready(function() {
    $.get(BASE_URL + '/api/index.php?endpoint=admin&action=users', function(data) {
        if (data.success) {
            let html = '';
            data.data.forEach(user => {
                html += `
                    <tr>
                        <td>${user.user_id}</td>
                        <td>${user.username}</td>
                        <td>${user.email}</td>
                        <td>${user.full_name || '-'}</td>
                        <td><span class="badge bg-${user.status === 'active' ? 'success' : 'danger'}">${user.status}</span></td>
                        <td><span class="badge bg-${user.kyc_status === 'approved' ? 'success' : 'warning'}">${user.kyc_status}</span></td>
                        <td>${formatDate(user.created_at)}</td>
                        <td>
                            <button class="btn btn-sm btn-primary">Edit</button>
                            <button class="btn btn-sm btn-danger">Ban</button>
                        </td>
                    </tr>
                `;
            });
            $('#userList').html(html);
        }
    });
});
</script>

<?php require_once __DIR__ . '/../../includes/footer.php'; ?>
