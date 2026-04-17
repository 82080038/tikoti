// Betting JavaScript

$(document).ready(function() {
    // Load markets and game types
    apiCall('market', 'list')
        .then(response => {
            if (response.success) {
                let html = '<option value="">Pilih Pasaran</option>';
                response.data.forEach(market => {
                    html += `<option value="${market.market_id}">${market.code} - ${market.name}</option>`;
                });
                $('#marketSelect').html(html);
            }
        });
    
    apiCall('market', 'game-types')
        .then(response => {
            if (response.success) {
                let html = '<option value="">Pilih Jenis</option>';
                response.data.forEach(game => {
                    html += `<option value="${game.game_type_id}" data-multiplier="${game.payout_multiplier}">${game.name} (x${game.payout_multiplier})</option>`;
                });
                $('#gameTypeSelect').html(html);
            }
        });
    
    // Calculate bet information
    $('#betAmount, #marketSelect, #gameTypeSelect').on('change', calculateBetInfo);
    $('#betNumber').on('input', validateBetNumber);
    
    function calculateBetInfo() {
        const amount = parseFloat($('#betAmount').val()) || 0;
        const discountRate = 0.29;
        const discountAmount = amount * discountRate;
        const netAmount = amount - discountAmount;
        
        const gameTypeOption = $('#gameTypeSelect option:selected');
        const multiplier = parseFloat(gameTypeOption.data('multiplier')) || 0;
        const potentialPayout = netAmount * multiplier;
        
        $('#displayAmount').text(formatCurrency(amount));
        $('#displayDiscount').text('-' + formatCurrency(discountAmount));
        $('#displayNetAmount').text(formatCurrency(netAmount));
        $('#displayPayout').text(formatCurrency(potentialPayout));
        $('#discountInfo').text(`Diskon 29%: -${formatCurrency(discountAmount)}`);
        
        // Enable/disable place bet button
        const isValid = amount > 0 && $('#marketSelect').val() && $('#gameTypeSelect').val() && $('#betNumber').val();
        $('#placeBetBtn').prop('disabled', !isValid);
    }
    
    function validateBetNumber() {
        const value = $('#betNumber').val();
        const gameTypeOption = $('#gameTypeSelect option:selected');
        const gameTypeName = gameTypeOption.text().split(' ')[0] || '';
        
        let isValid = true;
        let message = '';
        
        if (gameTypeName === '4D' && value.length !== 4) {
            isValid = false;
            message = '4D membutuhkan 4 digit angka';
        } else if (gameTypeName === '3D' && value.length !== 3) {
            isValid = false;
            message = '3D membutuhkan 3 digit angka';
        } else if (gameTypeName === '2D' && value.length !== 2) {
            isValid = false;
            message = '2D membutuhkan 2 digit angka';
        }
        
        if (!/^\d+$/.test(value)) {
            isValid = false;
            message = 'Hanya angka yang diperbolehkan';
        }
        
        $('#numberValidation').html(isValid ? '' : `<small class="text-danger">${message}</small>`);
        calculateBetInfo();
    }
    
    // Place bet
    $('#placeBetBtn').on('click', function() {
        const data = {
            market_id: $('#marketSelect').val(),
            game_type_id: $('#gameTypeSelect').val(),
            bet_number: $('#betNumber').val(),
            amount: parseFloat($('#betAmount').val())
        };
        
        $('#placeBetBtn').prop('disabled', true).html('<span class="spinner-border spinner-border-sm"></span> Memproses...');
        
        apiCall('bet', 'place', 'POST', data)
            .then(response => {
                if (response.success) {
                    alert('Taruhan berhasil dipasang!');
                    window.location.href = BASE_URL + '/views/betting/active-bets.php';
                } else {
                    alert(response.message || 'Gagal memasang taruhan');
                }
            })
            .finally(() => {
                $('#placeBetBtn').prop('disabled', false).text('Pasang Taruhan');
            });
    });
    
    // Load bet history
    if ($('#betHistory').length) {
        apiCall('bet', 'history')
            .then(response => {
                if (response.success) {
                    let html = '';
                    response.data.forEach(bet => {
                        const statusClass = bet.status === 'won' ? 'success' : (bet.status === 'lost' ? 'danger' : 'warning');
                        html += `
                            <tr>
                                <td>${bet.bet_id}</td>
                                <td>${bet.market_name}</td>
                                <td>${bet.game_type_name}</td>
                                <td>${bet.bet_number}</td>
                                <td>${formatCurrency(bet.amount)}</td>
                                <td><span class="badge bg-${statusClass}">${bet.status}</span></td>
                                <td>${formatCurrency(bet.payout_amount || 0)}</td>
                                <td>${formatDate(bet.placed_at)}</td>
                            </tr>
                        `;
                    });
                    $('#betHistory').html(html || '<tr><td colspan="8" class="text-center">Belum ada riwayat taruhan</td></tr>');
                }
            });
    }
    
    // Load active bets
    if ($('#activeBets').length) {
        apiCall('bet', 'active')
            .then(response => {
                if (response.success) {
                    let html = '';
                    response.data.forEach(bet => {
                        html += `
                            <tr>
                                <td>${bet.bet_id}</td>
                                <td>${bet.market_name}</td>
                                <td>${bet.game_type_name}</td>
                                <td>${bet.bet_number}</td>
                                <td>${formatCurrency(bet.amount)}</td>
                                <td>${formatCurrency(bet.potential_payout)}</td>
                                <td>${formatDate(bet.placed_at)}</td>
                            </tr>
                        `;
                    });
                    $('#activeBets').html(html || '<tr><td colspan="7" class="text-center">Tidak ada taruhan aktif</td></tr>');
                }
            });
    }
});
