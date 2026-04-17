<?php
// User Roles
define('ROLE_PEMAIN', 'pemain');
define('ROLE_AGEN', 'agen');
define('ROLE_PENGELOLA', 'pengelola');
define('ROLE_PEMILIK', 'pemilik');

// User Status
define('STATUS_PENDING', 'pending');
define('STATUS_ACTIVE', 'active');
define('STATUS_SUSPENDED', 'suspended');
define('STATUS_BANNED', 'banned');
define('STATUS_DELETED', 'deleted');

// KYC Status
define('KYC_NOT_SUBMITTED', 'not_submitted');
define('KYC_PENDING', 'pending');
define('KYC_APPROVED', 'approved');
define('KYC_REJECTED', 'rejected');
define('KYC_EXPIRED', 'expired');

// Transaction Types
define('TRANSACTION_DEPOSIT', 'deposit');
define('TRANSACTION_WITHDRAWAL', 'withdrawal');
define('TRANSACTION_BET', 'bet');
define('TRANSACTION_PAYOUT', 'payout');
define('TRANSACTION_REFUND', 'refund');
define('TRANSACTION_COMMISSION', 'commission');
define('TRANSACTION_BONUS', 'bonus');
define('TRANSACTION_ADJUSTMENT', 'adjustment');

// Transaction Status
define('TRANS_STATUS_PENDING', 'pending');
define('TRANS_STATUS_PROCESSING', 'processing');
define('TRANS_STATUS_COMPLETED', 'completed');
define('TRANS_STATUS_FAILED', 'failed');
define('TRANS_STATUS_CANCELLED', 'cancelled');
define('TRANS_STATUS_REVERSED', 'reversed');

// Bet Status
define('BET_STATUS_PENDING', 'pending');
define('BET_STATUS_WON', 'won');
define('BET_STATUS_LOST', 'lost');
define('BET_STATUS_CANCELLED', 'cancelled');
define('BET_STATUS_REFUNDED', 'refunded');

// Discount Rate
define('DISCOUNT_RATE', 0.29); // 29%
?>
