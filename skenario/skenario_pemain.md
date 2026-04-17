# Skenario Pengguna: Pemain

## Deskripsi
Pemain adalah pengguna utama aplikasi yang memasang taruhan pada pasaran togel.

## Alur Penggunaan

### 1. Registrasi
- Pemain mengakses halaman registrasi
- Mengisi form: username, email, nama lengkap, password
- Sistem membuat akun dengan status PENDING
- Sistem otomatis membuat wallet dengan saldo 0
- Pemain mendapatkan role PEMAIN secara default

### 2. Login
- Pemain mengakses halaman login
- Memasukkan username/email dan password
- Sistem melakukan autentikasi
- Jika berhasil, redirect ke dashboard
- Sesi dibuat dengan timeout 1 jam

### 3. Dashboard
- Pemain melihat ringkasan aktivitas
- Informasi yang ditampilkan:
  - Saldo wallet
  - Taruhan aktif
  - Riwayat transaksi terakhir
  - Notifikasi penting

### 4. Pasang Taruhan
- Pemain memilih pasaran (SGP, HK, SDY)
- Memilih jenis permainan (4D, 3D, 2D)
- Memasukkan angka prediksi
- Memasukkan nominal taruhan
- Sistem memvalidasi saldo cukup
- Sistem mengunci saldo di wallet
- Taruhan dicatat dengan status PENDING

### 5. Cek Hasil
- Pemain mengakses halaman hasil
- Melihat hasil undian per pasaran
- Hasil ditampilkan dengan format 4D (As, Kop, Kepala, Ekor)
- Pemain bisa melihat riwayat hasil

### 6. Kelola Wallet
- **Deposit:**
  - Pemain mengajukan deposit
  - Memilih metode pembayaran
  - Memasukkan nominal
  - Menunggu konfirmasi admin
  - Saldo bertambah setelah konfirmasi

- **Withdraw:**
  - Pemain mengajukan withdraw
  - Memasukkan nominal (tidak melebihi saldo)
  - Menunggu konfirmasi admin
  - Saldo berkurang setelah konfirmasi

### 7. Riwayat Taruhan
- Pemain melihat semua taruhan yang pernah dipasang
- Informasi: pasaran, jenis permainan, angka, nominal, status, hasil
- Filter berdasarkan status (aktif, menang, kalah)

### 8. Profil
- Pemain bisa melihat dan mengedit profil
- Informasi: username, email, nama lengkap
- Bisa mengubah password
- Upload foto profil (KYC)

## Validasi
- Username harus unik
- Email harus valid dan unik
- Password minimal 8 karakter
- Saldo tidak boleh negatif
- Taruhan tidak boleh melebihi saldo yang tersedia

## Keamanan
- Sesi timeout setelah 1 jam inaktivitas
- Password di-hash menggunakan bcrypt
- Maksimal 5 percobaan login gagal
- Transaksi memerlukan autentikasi
