// Authentication JavaScript

$(document).ready(function() {
    // Login Form
    $('#loginForm').on('submit', function(e) {
        e.preventDefault();
        
        const username = $('#username').val();
        const password = $('#password').val();
        
        $('#loginBtn').prop('disabled', true).html('<span class="spinner-border spinner-border-sm"></span> Login...');
        
        apiCall('auth', 'login', 'POST', { username, password })
            .then(response => {
                if (response.success) {
                    window.location.href = BASE_URL + '/dashboard.php';
                } else {
                    showMessage('loginMessage', response.message, 'danger');
                }
            })
            .finally(() => {
                $('#loginBtn').prop('disabled', false).text('Login');
            });
    });
    
    // Register Form
    $('#registerForm').on('submit', function(e) {
        e.preventDefault();
        
        const username = $('#username').val();
        const email = $('#email').val();
        const full_name = $('#full_name').val();
        const password = $('#password').val();
        const confirm_password = $('#confirm_password').val();
        
        if (password !== confirm_password) {
            showMessage('registerMessage', 'Password tidak cocok', 'danger');
            return;
        }
        
        if (password.length < 8) {
            showMessage('registerMessage', 'Password minimal 8 karakter', 'danger');
            return;
        }
        
        $('#registerBtn').prop('disabled', true).html('<span class="spinner-border spinner-border-sm"></span> Daftar...');
        
        apiCall('auth', 'register', 'POST', { username, email, full_name, password })
            .then(response => {
                if (response.success) {
                    showMessage('registerMessage', 'Pendaftaran berhasil! Silakan login.', 'success');
                    setTimeout(() => {
                        window.location.href = BASE_URL + '/views/auth/login.php';
                    }, 2000);
                } else {
                    showMessage('registerMessage', response.message, 'danger');
                }
            })
            .finally(() => {
                $('#registerBtn').prop('disabled', false).text('Daftar');
            });
    });
    
    // Check login status
    apiCall('auth', 'check')
        .then(response => {
            if (response.logged_in && window.location.pathname.includes('login.php')) {
                window.location.href = BASE_URL + '/dashboard.php';
            }
        });
});
