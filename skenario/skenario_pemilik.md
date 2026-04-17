# Skenario Pengguna: Pemilik

## Deskripsi
Pemilik adalah pengguna dengan akses penuh ke sistem, termasuk konfigurasi sistem, laporan keuangan, dan manajemen pengelola.

## Alur Penggunaan

### 1. Login
- Login dengan role PEMILIK
- Dashboard dengan akses penuh
- Menu khusus pemilik

### 2. Dashboard Pemilik
- Overview bisnis:
  - Total revenue
  - Total pemain
  - Total agen
  - Pertumbuhan bulanan
- Grafik performa
- KPI utama
- Alert penting

### 3. Manajemen Pengelola
- **Daftar Pengelola:**
  - Melihat semua pengelola
  - Status aktif/nonaktif

- **Tambah Pengelola:**
  - Membuat akun pengelola baru
  - Set hak akses
  - Assign area tanggung jawab

- **Edit Pengelola:**
  - Update hak akses
  - Aktifkan/nonaktifkan
  - Reset password

### 4. Manajemen Agen
- **Approval Agen:**
  - Review aplikasi agen baru
  - Approve/reject pendaftaran
  - Set komisi agen

- **Monitoring Agen:**
  - Performa agen
  - Komisi yang harus dibayar
  - Aktivitas agen

- **Konfigurasi Komisi:**
  - Set persentase komisi global
  - Set komisi per agen
  - Aturan tier komisi

### 5. Keuangan
- **Overview Keuangan:**
  - Revenue total
  - Profit
  - Pengeluaran
  - Cash flow

- **Laporan Detail:**
  - Laporan pendapatan
  - Laporan pengeluaran
  - Laporan komisi
  - Laporan kemenangan

- **Bank:**
  - Saldo bank
  - Riwayat transfer
  - Rekening aktif

### 6. Konfigurasi Sistem
- **Pengaturan Umum:**
  - Nama aplikasi
  - Email notifikasi
  - Zona waktu

- **Pengaturan Taruhan:**
  - Minimal taruhan
  - Maksimal taruhan
  - Batas harian
  - Diskon per permainan

- **Pengaturan Keamanan:**
  - Kebijakan password
  - Batas login gagal
  - Timeout sesi
  - 2FA

- **Pengaturan Pembayaran:**
  - Metode deposit
  - Metode withdraw
  - Rekening tujuan
  - Fee transaksi

### 7. Audit & Log
- **Log Aktivitas:**
  - Semua aktivitas user
  - Filter berdasarkan user/tanggal
  - Export log

- **Audit Trail:**
  - Perubahan data penting
  - Siapa mengubah apa
  - Kapan perubahan dilakukan

### 8. Laporan Eksekutif
- Laporan bulanan
- Laporan kuartalan
- Laporan tahunan
- Forecast
- Export ke PDF/Excel

## Validasi
- Pemilik adalah satu-satunya yang bisa mengubah konfigurasi sistem
- Perubahan konfigurasi memerlukan konfirmasi
- Tidak bisa menghapus data permanen
- Akses penuh tetap tercatat di log

## Keamanan
- 2FA wajib untuk pemilik
- IP whitelist untuk akses pemilik
- Semua aktivitas pemilik dicatat
- Backup otomatis harian
