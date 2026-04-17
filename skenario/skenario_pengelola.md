# Skenario Pengguna: Pengelola

## Deskripsi
Pengelola adalah admin yang mengelola operasional harian aplikasi seperti approval transaksi, manajemen pasaran, dan dukungan pengguna.

## Alur Penggunaan

### 1. Login
- Login dengan role PENGGELOLA
- Dashboard admin khusus pengelola
- Akses ke menu manajemen

### 2. Dashboard Pengelola
- Statistik harian:
  - Total pemain aktif
  - Total transaksi hari ini
  - Total taruhan hari ini
  - Pending approval
- Grafik aktivitas
- Notifikasi penting

### 3. Manajemen User
- **Daftar User:**
  - Melihat semua user
  - Filter berdasarkan role dan status
  - Search user

- **Detail User:**
  - Melihat profil lengkap
  - Riwayat aktivitas
  - Status akun
  - KYC status

- **Aktivasi/Deaktivasi User:**
  - Mengaktifkan user pending
  - Menonaktifkan user bermasalah
  - Memberikan catatan

### 4. Manajemen Transaksi
- **Deposit:**
  - Melihat permintaan deposit pending
  - Review bukti pembayaran
  - Approve/reject deposit
  - Memberikan catatan jika reject

- **Withdraw:**
  - Melihat permintaan withdraw pending
  - Review nominal dan rekening tujuan
  - Approve/reject withdraw
  - Proses transfer manual jika perlu

- **Komisi:**
  - Melihat permintaan penarikan komisi agen
  - Approve/reject penarikan
  - Catat pembayaran

### 5. Manajemen Pasaran
- **Daftar Pasaran:**
  - Melihat semua pasaran aktif
  - Status pasaran (buka/tutup)
  - Jadwal undian

- **Tambah Pasaran:**
  - Menambah pasaran baru
  - Set jadwal undian
  - Konfigurasi aturan

- **Edit Pasaran:**
  - Update informasi pasaran
  - Ubah jadwal
  - Aktifkan/nonaktifkan

### 6. Input Hasil Undian
- Memilih pasaran
- Memasukkan hasil 4D
- Sistem otomatis menghitung pemenang
- Distribusi kemenangan otomatis

### 7. Laporan
- Laporan transaksi harian
- Laporan taruhan per pasaran
- Laporan keuangan
- Laporan aktivitas user
- Export laporan

### 8. Dukungan Pengguna
- Melihat tiket support
- Balas pertanyaan user
- Resolve masalah teknis
- Escalate ke pemilik jika perlu

## Validasi
- Pengelola tidak bisa mengubah role user
- Tidak bisa menghapus data permanen
- Approval transaksi memerlukan konfirmasi
- Input hasil undian memerlukan otorisasi

## Keamanan
- Semua aktivitas pengelola dicatat log
- Tidak bisa mengakses data keuangan sensitif
- Maksimal approval per hari dibatasi
