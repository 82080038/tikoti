# Skenario Pengguna: Agen

## Deskripsi
Agen adalah perantara yang mengelola pemain di bawahnya dan mendapatkan komisi dari taruhan pemain.

## Alur Penggunaan

### 1. Registrasi Agen
- Agen mendaftar melalui form khusus
- Mengisi data diri lengkap
- Sistem memberikan role AGENT
- Membutuhkan approval dari pemilik

### 2. Login
- Sama seperti pemain biasa
- Dashboard agen berbeda dari pemain
- Menu tambahan untuk manajemen pemain

### 3. Dashboard Agen
- Melihat ringkasan performa
- Total pemain terdaftar
- Total komisi yang diperoleh
- Aktivitas pemain terbaru
- Target penjualan

### 4. Manajemen Pemain
- **Daftar Pemain:**
  - Melihat semua pemain di bawah agen
  - Informasi: nama, username, saldo, aktivitas
  - Filter berdasarkan status

- **Tambah Pemain:**
  - Agen bisa mendaftarkan pemain baru
  - Pemain otomatis terhubung ke agen
  - Agen mendapatkan referal code

- **Detail Pemain:**
  - Melihat profil lengkap pemain
  - Riwayat taruhan pemain
  - Riwayat transaksi pemain
  - Status akun pemain

### 5. Komisi
- **Lihat Komisi:**
  - Komisi dari setiap taruhan pemain
  - Persentase komisi sesuai aturan
  - Riwayat pembayaran komisi

- **Tarik Komisi:**
  - Mengajukan penarikan komisi
  - Menunggu approval pemilik
  - Komisi ditransfer ke rekening agen

### 6. Laporan
- Laporan harian penjualan
- Laporan performa pemain
- Laporan komisi bulanan
- Export laporan ke CSV/PDF

### 7. Notifikasi
- Notifikasi ketika pemain baru mendaftar
- Notifikasi ketika pemain melakukan deposit besar
- Notifikasi pembayaran komisi
- Notifikasi aktivitas mencurigakan

## Validasi
- Agen harus disetujui oleh pemilik sebelum aktif
- Komisi dihitung berdasarkan aturan sistem
- Penarikan komisi memerlukan approval
- Agen tidak bisa menghapus pemain

## Keamanan
- Agen hanya bisa melihat data pemain di bawahnya
- Tidak bisa mengakses data agen lain
- Semua aktivitas agen dicatat log
