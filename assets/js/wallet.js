// Wallet JavaScript

$(document).ready(function() {
    // Load wallet balance
    if ($('#activeBalance').length) {
        apiCall('wallet', 'balance')
            .then(response => {
                if (response.success && response.data) {
                    $('#activeBalance').text(formatCurrency(response.data.balance));
                    $('#lockedBalance').text(formatCurrency(response.data.locked_balance));
                    $('#currentBalance').text(formatCurrency(response.data.balance));
                    $('#availableBalance').text(formatCurrency(response.data.balance));
                }
            });
    }
    
    // Load transaction history
    if ($('#transactionHistory').length) {
        apiCall('transaction', 'history')
            .then(response => {
                if (response.success) {
                    let html = '';
                    response.data.forEach(tx => {
                        const statusClass = tx.status === 'completed' ? 'success' : (tx.status === 'failed' ? 'danger' : 'warning');
                        const typeClass = tx.transaction_type === 'deposit' ? 'success' : 'danger';
                        const amountClass = tx.transaction_type === 'deposit' ? 'text-success' : 'text-danger';
                        html += `
                            <tr>
                                <td>${tx.transaction_id}</td>
                                <td><span class="badge bg-${typeClass}">${tx.transaction_type}</span></td>
                                <td class="${amountClass}">${formatCurrency(tx.amount)}</td>
                                <td>${tx.payment_method_name || '-'}</td>
                                <td><span class="badge bg-${statusClass}">${tx.status}</span></td>
                                <td>${formatDate(tx.created_at)}</td>
                            </tr>
                        `;
                    });
                    $('#transactionHistory').html(html || '<tr><td colspan="6" class="text-center">Belum ada transaksi</td></tr>');
                }
            });
    }
    
    // Deposit form
    $('#depositForm').on('submit', function(e) {
        e.preventDefault();
        
        const amount = parseFloat($('#amount').val());
        const payment_method = $('#payment_method').val();
        const reference = $('#reference').val();
        
        if (amount < 10000) {
            alert('Minimal deposit Rp 10.000');
            return;
        }
        
        apiCall('wallet', 'deposit', 'POST', { amount, payment_method, reference })
            .then(response => {
                if (response.success) {
                    alert('Permintaan deposit berhasil diproses');
                    window.location.href = BASE_URL + '/views/wallet/index.php';
                } else {
                    alert(response.message || 'Gagal memproses deposit');
                }
            });
    });
    
    // Withdraw form
    $('#withdrawForm').on('submit', function(e) {
        e.preventDefault();
        
        const amount = parseFloat($('#amount').val());
        const payment_method = $('#payment_method').val();
        const account_number = $('#account_number').val();
        const account_name = $('#account_name').val();
        
        if (amount < 50000) {
            alert('Minimal withdraw Rp 50.000');
            return;
        }
        
        apiCall('wallet', 'withdraw', 'POST', { 
            amount, 
            payment_method, 
            account_number, 
            account_name 
        })
            .then(response => {
                if (response.success) {
                    alert('Permintaan withdraw berhasil diproses');
                    window.location.href = BASE_URL + '/views/wallet/index.php';
                } else {
                    alert(response.message || 'Gagal memproses withdraw');
                }
            });
    });
});
