// Main JavaScript

$(document).ready(function() {
    // Load dashboard data
    if ($('#walletBalance').length) {
        apiCall('wallet', 'balance')
            .then(response => {
                if (response.success && response.data) {
                    $('#walletBalance').text(formatCurrency(response.data.balance));
                }
            });
    }
    
    if ($('#totalBets').length) {
        apiCall('bet', 'history')
            .then(response => {
                if (response.success) {
                    $('#totalBets').text(response.data.length);
                    const wins = response.data.filter(b => b.status === 'won').length;
                    $('#totalWins').text(wins);
                }
            });
    }
    
    if ($('#activeBets').length) {
        apiCall('bet', 'active')
            .then(response => {
                if (response.success) {
                    $('#activeBets').text(response.data.length);
                }
            });
    }
    
    // Load recent bets
    if ($('#recentBets').length) {
        apiCall('bet', 'history')
            .then(response => {
                if (response.success && response.data.length > 0) {
                    let html = '<ul class="list-group">';
                    response.data.slice(0, 5).forEach(bet => {
                        const statusClass = bet.status === 'won' ? 'success' : (bet.status === 'lost' ? 'danger' : 'warning');
                        html += `
                            <li class="list-group-item">
                                <div class="d-flex justify-content-between">
                                    <span>${bet.market_name} - ${bet.game_type_name}</span>
                                    <span class="badge bg-${statusClass}">${bet.status}</span>
                                </div>
                                <small class="text-muted">${bet.bet_number} - ${formatCurrency(bet.amount)}</small>
                            </li>
                        `;
                    });
                    html += '</ul>';
                    $('#recentBets').html(html);
                } else {
                    $('#recentBets').html('<p class="text-muted">Belum ada taruhan</p>');
                }
            });
    }
    
    // Load recent results
    if ($('#recentResults').length) {
        apiCall('market', 'results', 'GET', { code: 'SGP', limit: 5 })
            .then(response => {
                if (response.success && response.data.length > 0) {
                    let html = '<ul class="list-group">';
                    response.data.forEach(result => {
                        html += `
                            <li class="list-group-item">
                                <div class="d-flex justify-content-between">
                                    <span>${result.market_name}</span>
                                    <small>${formatDate(result.draw_date)}</small>
                                </div>
                                <div class="result-display">
                                    <span class="result-digit">${result.as_digit}</span>
                                    <span class="result-digit">${result.kop_digit}</span>
                                    <span class="result-digit">${result.kepala_digit}</span>
                                    <span class="result-digit">${result.ekor_digit}</span>
                                </div>
                            </li>
                        `;
                    });
                    html += '</ul>';
                    $('#recentResults').html(html);
                } else {
                    $('#recentResults').html('<p class="text-muted">Belum ada hasil</p>');
                }
            });
    }
    
    // Load market results
    if ($('#marketResults').length) {
        loadMarketResults('SGP');
        
        $('#marketFilter').on('change', function() {
            loadMarketResults($(this).val());
        });
    }
    
    function loadMarketResults(marketCode) {
        showLoading('marketResults', true);
        
        apiCall('market', 'results', 'GET', { code: marketCode, limit: 10 })
            .then(response => {
                if (response.success && response.data.length > 0) {
                    let html = '';
                    response.data.forEach(result => {
                        html += `
                            <tr>
                                <td>${result.market_name}</td>
                                <td>${formatDate(result.draw_date)}</td>
                                <td><strong>${result.result_number}</strong></td>
                                <td>${result.as_digit}</td>
                                <td>${result.kop_digit}</td>
                                <td>${result.kepala_digit}</td>
                                <td>${result.ekor_digit}</td>
                            </tr>
                        `;
                    });
                    $('#marketResults').html(html);
                } else {
                    $('#marketResults').html('<tr><td colspan="7" class="text-center">Belum ada hasil</td></tr>');
                }
            })
            .finally(() => {
                showLoading('marketResults', false);
            });
    }
    
    // Load user profile
    if ($('#profileForm').length) {
        apiCall('user', 'profile')
            .then(response => {
                if (response.success && response.data) {
                    $('#username').val(response.data.username);
                    $('#email').val(response.data.email);
                    $('#full_name').val(response.data.full_name || '');
                    $('#phone').val(response.data.phone || '');
                    $('#date_of_birth').val(response.data.date_of_birth || '');
                    
                    $('#accountStatus').text(response.data.status).addClass('bg-' + (response.data.status === 'active' ? 'success' : 'danger'));
                    $('#kycStatus').text(response.data.kyc_status).addClass('bg-' + (response.data.kyc_status === 'approved' ? 'success' : 'warning'));
                    $('#joinedDate').text(formatDate(response.data.created_at));
                }
            });
        
        apiCall('user', 'role')
            .then(response => {
                if (response.success) {
                    $('#userRole').text(response.data.role);
                }
            });
    }
    
    // Update profile
    $('#profileForm').on('submit', function(e) {
        e.preventDefault();
        
        const data = {
            full_name: $('#full_name').val(),
            phone: $('#phone').val(),
            date_of_birth: $('#date_of_birth').val()
        };
        
        apiCall('user', 'update', 'POST', data)
            .then(response => {
                if (response.success) {
                    alert('Profile berhasil diupdate');
                } else {
                    alert('Gagal mengupdate profile');
                }
            });
    });
});
