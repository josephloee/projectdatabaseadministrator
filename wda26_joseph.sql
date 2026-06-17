-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 31 Jan 2026 pada 11.24
-- Versi server: 10.4.32-MariaDB
-- Versi PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `wda26_joseph`
--

DELIMITER $$
--
-- Prosedur
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `Isi_Barang` (`p_kd` VARCHAR(10), `p_nm` VARCHAR(50), `p_harga` INT, `p_stok` INT)   BEGIN
    INSERT INTO barang VALUES (p_kd, p_nm, p_harga, p_stok);
    SELECT * FROM barang;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Isi_Konsumen` (`p_kd` VARCHAR(10), `p_nm` VARCHAR(50), `p_alamat` VARCHAR(100), `p_kel` CHAR(1), `p_kota` VARCHAR(30))   BEGIN
    INSERT INTO konsumen VALUES (p_kd, p_nm, p_alamat, p_kel, p_kota);
    SELECT * FROM konsumen;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `barang`
--

CREATE TABLE `barang` (
  `kd_barang` varchar(10) NOT NULL,
  `nm_barang` varchar(50) DEFAULT NULL,
  `harga` int(11) DEFAULT NULL,
  `stok` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `barang`
--

INSERT INTO `barang` (`kd_barang`, `nm_barang`, `harga`, `stok`) VALUES
('BR01', 'Pulpen', 3000, 100),
('BR02', 'Buku Tulis', 5000, 50),
('BR03', 'Penghapus', 2000, 80);

-- --------------------------------------------------------

--
-- Struktur dari tabel `detail_penjualan`
--

CREATE TABLE `detail_penjualan` (
  `id_detail` int(11) NOT NULL,
  `kd_penjualan` varchar(10) DEFAULT NULL,
  `kd_barang` varchar(10) DEFAULT NULL,
  `jumlah` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `detail_penjualan`
--

INSERT INTO `detail_penjualan` (`id_detail`, `kd_penjualan`, `kd_barang`, `jumlah`) VALUES
(3, 'PJ01', 'BR01', 2),
(4, 'PJ01', 'BR02', 1);

--
-- Trigger `detail_penjualan`
--
DELIMITER $$
CREATE TRIGGER `trg_kurangi_stok` AFTER INSERT ON `detail_penjualan` FOR EACH ROW BEGIN
    UPDATE barang
    SET stok = stok - NEW.jumlah
    WHERE kd_barang = NEW.kd_barang;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `konsumen`
--

CREATE TABLE `konsumen` (
  `kd_konsumen` varchar(10) NOT NULL,
  `nm_konsumen` varchar(50) DEFAULT NULL,
  `alamat` varchar(100) DEFAULT NULL,
  `kelamin` char(1) DEFAULT NULL,
  `kota` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `konsumen`
--

INSERT INTO `konsumen` (`kd_konsumen`, `nm_konsumen`, `alamat`, `kelamin`, `kota`) VALUES
('LSP01', 'Budi Santoso', 'Jl. Mawar 1', 'L', 'Solo'),
('LSP02', 'Siti Aminah', 'Jl. Melati 2', 'P', 'Semarang'),
('LSP03', 'Andi Wijaya', 'Jl. Kenanga 4', 'L', 'Magelang'),
('LSP04', 'Arina Wati', 'Jl. Belimbing 3', 'P', 'Semarang'),
('LSP05', 'Joko Suyono', 'Jl. Parkit 5', 'L', 'Salatiga');

-- --------------------------------------------------------

--
-- Struktur dari tabel `penjualan`
--

CREATE TABLE `penjualan` (
  `kd_penjualan` varchar(10) NOT NULL,
  `kd_konsumen` varchar(10) DEFAULT NULL,
  `tgl` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `penjualan`
--

INSERT INTO `penjualan` (`kd_penjualan`, `kd_konsumen`, `tgl`) VALUES
('PJ01', 'LSP02', '2025-01-10');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `barang`
--
ALTER TABLE `barang`
  ADD PRIMARY KEY (`kd_barang`);

--
-- Indeks untuk tabel `detail_penjualan`
--
ALTER TABLE `detail_penjualan`
  ADD PRIMARY KEY (`id_detail`),
  ADD KEY `fk_penjualan` (`kd_penjualan`),
  ADD KEY `fk_barang` (`kd_barang`);

--
-- Indeks untuk tabel `konsumen`
--
ALTER TABLE `konsumen`
  ADD PRIMARY KEY (`kd_konsumen`);

--
-- Indeks untuk tabel `penjualan`
--
ALTER TABLE `penjualan`
  ADD PRIMARY KEY (`kd_penjualan`),
  ADD KEY `fk_konsumen` (`kd_konsumen`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `detail_penjualan`
--
ALTER TABLE `detail_penjualan`
  MODIFY `id_detail` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `detail_penjualan`
--
ALTER TABLE `detail_penjualan`
  ADD CONSTRAINT `fk_barang` FOREIGN KEY (`kd_barang`) REFERENCES `barang` (`kd_barang`),
  ADD CONSTRAINT `fk_penjualan` FOREIGN KEY (`kd_penjualan`) REFERENCES `penjualan` (`kd_penjualan`);

--
-- Ketidakleluasaan untuk tabel `penjualan`
--
ALTER TABLE `penjualan`
  ADD CONSTRAINT `fk_konsumen` FOREIGN KEY (`kd_konsumen`) REFERENCES `konsumen` (`kd_konsumen`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
