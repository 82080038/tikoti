# Tikoti - Aplikasi Togel Online

Platform togel online terpercaya dan aman dengan fitur lengkap untuk pemain, agen, pengelola, dan pemilik.

## 🌟 Fitur Utama

### Untuk Pemain
- Registrasi dan login aman
- Pasang taruhan pada berbagai pasaran (SGP, HK, SDY)
- Kelola wallet (deposit dan withdraw)
- Cek hasil undian pasaran
- Lihat riwayat taruhan dan transaksi
- Profil pengguna dengan KYC

### Untuk Agen
- Manajemen pemain di bawah agen
- Lihat dan tarik komisi
- Laporan performa pemain
- Notifikasi aktivitas pemain

### Untuk Pengelola
- Approval transaksi deposit dan withdraw
- Manajemen pasaran togel
- Input hasil undian
- Manajemen user
- Laporan operasional

### Untuk Pemilik
- Konfigurasi sistem
- Laporan keuangan lengkap
- Manajemen pengelola dan agen
- Audit dan log aktivitas
- Laporan eksekutif

## 🚀 Instalasi

### Persyaratan
- PHP 8.0 atau lebih tinggi
- MySQL 5.7 atau lebih tinggi
- Apache/Nginx web server
- Composer (untuk dependency management)
- Node.js dan npm (untuk development)

### Langkah Instalasi

1. **Clone repository**
```bash
git clone https://github.com/82080038/tikoti.git
cd tikoti
```

2. **Setup Database**
```bash
# Import database schema
mysql -u root -p togeli_db < database.sql
```

3. **Konfigurasi**
```bash
# Edit file config/database.php
# Sesuaikan dengan kredensial database Anda
```

4. **Setup Permissions**
```bash
# Pastikan direktori berikut writable
chmod 755 uploads/
chmod 755 logs/
```

5. **Setup Web Server**
```bash
# Untuk Apache, pastikan mod_rewrite aktif
# Untuk Nginx, konfigurasi virtual host
```

6. **Akses Aplikasi**
```
http://localhost/tikoti
```

## 📁 Struktur Proyek

```
tikoti/
├── api/                    # API endpoints
│   ├── auth.php           # Authentication API
│   ├── bet.php            # Betting API
│   ├── market.php         # Market API
│   ├── transaction.php    # Transaction API
│   ├── user.php           # User API
│   ├── wallet.php         # Wallet API
│   └── admin.php          # Admin API
├── assets/                 # Static assets
│   ├── css/              # Stylesheets
│   ├── js/               # JavaScript files
│   ├── images/           # Images
│   └── fonts/            # Fonts
├── config/                 # Configuration files
│   ├── config.php        # Main configuration
│   ├── database.php      # Database configuration
│   └── constants.php     # Application constants
├── includes/               # Shared PHP files
│   ├── auth.php          # Authentication class
│   ├── functions.php     # Helper functions
│   ├── header.php        # Header template
│   ├── footer.php        # Footer template
│   └── sidebar.php       # Sidebar template
├── models/                 # Database models
│   ├── User.php          # User model
│   ├── Wallet.php        # Wallet model
│   ├── Bet.php           # Bet model
│   ├── Market.php        # Market model
│   ├── Transaction.php   # Transaction model
│   └── GameType.php      # Game type model
├── views/                  # View templates
│   ├── auth/             # Authentication views
│   ├── dashboard/        # Dashboard views
│   ├── betting/          # Betting views
│   ├── wallet/           # Wallet views
│   ├── results/          # Results views
│   ├── admin/            # Admin views
│   └── errors/           # Error pages
├── skenario/              # User scenarios
├── uploads/               # User uploads (KYC, profile)
├── logs/                  # Application logs
├── database.sql           # Database export
├── index.php             # Entry point
├── dashboard.php          # Dashboard redirect
├── .htaccess             # Apache configuration
└── README.md             # This file
```

## 🔧 Konfigurasi

### Database
Edit `config/database.php`:
```php
define('DB_HOST', 'localhost');
define('DB_PORT', '3306');
define('DB_USER', 'root');
define('DB_PASS', 'your_password');
define('DB_NAME', 'togeli_db');
```

### Application
Edit `config/config.php`:
```php
define('APP_NAME', 'Tikoti');
define('BASE_URL', 'http://localhost/tikoti');
define('ENVIRONMENT', 'development');
```

## 👥 Role Pengguna

1. **PEMAIN** - Pengguna biasa yang memasang taruhan
2. **AGENT** - Agen yang mengelola pemain dan mendapatkan komisi
3. **PENGGELOLA** - Admin yang mengelola operasional harian
4. **PEMILIK** - Pemilik dengan akses penuh ke sistem

## 🔐 Keamanan

- Password di-hash menggunakan bcrypt
- Session management dengan timeout
- SQL injection prevention
- XSS protection
- CSRF protection
- Rate limiting
- Audit logging

## 📊 Database Schema

Database terdiri dari tabel-tabel utama:
- `users` - Data pengguna
- `user_roles` - Role pengguna
- `wallets` - Wallet pengguna
- `transactions` - Transaksi deposit/withdraw
- `markets` - Pasaran togel
- `game_types` - Jenis permainan
- `bets` - Taruhan pemain
- `bet_results` - Hasil taruhan
- `market_results` - Hasil undian pasaran
- `currencies` - Mata uang yang didukung
- `countries` - Negara untuk pasaran

## 🧪 Testing

### Automated Testing
```bash
# Install dependencies
npm install

# Run Puppeteer tests
node puppeteer_test.js
```

### Manual Testing
- Test semua alur registrasi dan login
- Test pasang taruhan
- Test deposit dan withdraw
- Test input hasil undian
- Test laporan

## 📝 API Documentation

### Authentication
- `POST /api/auth.php?action=login` - Login user
- `POST /api/auth.php?action=register` - Register user
- `POST /api/auth.php?action=logout` - Logout user

### Betting
- `GET /api/bet.php?action=list` - List taruhan user
- `POST /api/bet.php?action=create` - Pasang taruhan baru
- `GET /api/bet.php?action=active` - Taruhan aktif

### Wallet
- `GET /api/wallet.php?action=balance` - Cek saldo
- `POST /api/wallet.php?action=deposit` - Request deposit
- `POST /api/wallet.php?action=withdraw` - Request withdraw

### Market
- `GET /api/market.php?action=list` - List pasaran aktif
- `GET /api/market.php?action=results` - Hasil undian
- `GET /api/market.php?action=game-types` - Jenis permainan

## 🤝 Kontribusi

1. Fork repository
2. Buat branch feature (`git checkout -b feature/AmazingFeature`)
3. Commit perubahan (`git commit -m 'Add some AmazingFeature'`)
4. Push ke branch (`git push origin feature/AmazingFeature`)
5. Buka Pull Request

## 📄 Lisensi

Project ini dilisensikan di bawah lisensi MIT - lihat file LICENSE untuk detail.

## 👨‍💻 Pengembang

- 82080038

## 📞 Kontak

Untuk pertanyaan atau dukungan, silakan buka issue di repository GitHub.

## 🙏 Terima Kasih

- Bootstrap 5 untuk UI framework
- jQuery untuk JavaScript library
- PHP untuk backend
- MySQL untuk database
- Puppeteer untuk testing

## 📅 Changelog

### Version 1.0.0 (2026-04-17)
- Initial release
- Core features: authentication, betting, wallet, market
- Admin features: user management, transaction approval
- Responsive design
- Comprehensive testing
