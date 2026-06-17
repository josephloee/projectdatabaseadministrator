# projectdatabaseadministrator
Implementasi sistem basis data relasional sederhana menggunakan MySQL/MariaDB yang dirancang untuk mengelola transaksi penjualan, data konsumen, dan inventaris barang. Basis data (wda26_joseph) ini mensimulasikan alur kerja sistem Point of Sales (POS) dasar dengan dilengkapi fitur otomatisasi basis data tingkat lanjut.

Fitur Utama:
>Manajemen Data Terstruktur: Memiliki tabel master untuk entitas Barang (inventaris) dan Konsumen (pelanggan).
>Sistem Transaksi Relasional: Menggunakan relasi untuk menghubungkan header transaksi (penjualan) dengan line-item spesifik (detail_penjualan).
>Stored Procedures: Dilengkapi dengan prosedur bawaan (Isi_Barang dan Isi_Konsumen) untuk menyederhanakan dan mengamankan proses input data baru.
>Automasi Stok (Trigger): Memiliki trigger trg_kurangi_stok yang akan secara otomatis memotong jumlah stok di tabel barang setiap kali ada item yang berhasil terjual di tabel detail penjualan.

🛠️ Skema Database (Tabel)
>barang: Menyimpan detail produk (Kode, Nama, Harga, Stok).
>konsumen: Menyimpan profil pelanggan (Kode, Nama, Alamat, Jenis Kelamin, Kota).
>penjualan: Mencatat data utama transaksi (Kode Penjualan, Relasi Konsumen, Tanggal).
>detail_penjualan: Mencatat rincian barang yang dibeli dalam satu transaksi (ID Detail, Relasi Penjualan, Relasi Barang, Jumlah).

💻 Teknologi yang Digunakan
>Database: MySQL / MariaDB
>Konsep: DDL, DML, Primary/Foreign Keys, Stored Procedures, Database Triggers.
