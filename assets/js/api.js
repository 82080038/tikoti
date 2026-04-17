// API Helper Functions

function apiCall(endpoint, action, method = 'GET', data = null) {
    const url = `${BASE_URL}/api/index.php?endpoint=${endpoint}&action=${action}`;
    
    const options = {
        method: method,
        headers: {
            'Content-Type': 'application/json'
        }
    };
    
    if (data && (method === 'POST' || method === 'PUT')) {
        options.body = JSON.stringify(data);
    }
    
    return fetch(url, options)
        .then(response => response.json())
        .catch(error => {
            console.error('API Error:', error);
            return { success: false, message: 'Terjadi kesalahan koneksi' };
        });
}

function formatCurrency(amount) {
    return new Intl.NumberFormat('id-ID', {
        style: 'currency',
        currency: 'IDR'
    }).format(amount);
}

function formatDate(dateString) {
    const date = new Date(dateString);
    return date.toLocaleDateString('id-ID', {
        day: '2-digit',
        month: 'short',
        year: 'numeric',
        hour: '2-digit',
        minute: '2-digit'
    });
}

function showMessage(elementId, message, type = 'info') {
    const element = document.getElementById(elementId);
    if (element) {
        element.innerHTML = `<div class="alert alert-${type}">${message}</div>`;
        element.style.display = 'block';
        
        setTimeout(() => {
            element.style.display = 'none';
        }, 5000);
    }
}

function showLoading(elementId, show = true) {
    const element = document.getElementById(elementId);
    if (element) {
        element.innerHTML = show ? 
            '<div class="text-center"><div class="spinner-border text-primary" role="status"></div></div>' : '';
    }
}
