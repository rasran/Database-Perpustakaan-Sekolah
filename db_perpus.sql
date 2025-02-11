-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 11 Feb 2025 pada 04.16
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
-- Database: `db_perpus`
--

DELIMITER $$
--
-- Prosedur
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `daftar_siswa_peminjam` ()   BEGIN
    SELECT DISTINCT s.id_siswa, s.nama, s.kelas 
    FROM siswa s
    JOIN peminjaman p ON s.id_siswa = p.id_siswa;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `deletebuku` (IN `id_buku_new` INT)   BEGIN 
DELETE FROM buku WHERE id_buku = id_buku_new;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `deletepeminjaman` (IN `id_peminjaman_new` INT)   BEGIN
DELETE FROM peminjaman WHERE id_peminjaman = id_peminjaman_new;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `deletesiswa` (IN `id_siswa_new` INT)   BEGIN 
DELETE FROM siswa WHERE id_siswa = id_siswa_new;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertbuku` (IN `id_buku_new` INT, IN `judul_buku_new` VARCHAR(255), IN `penulis_new` VARCHAR(255), IN `kategori_new` VARCHAR(255), IN `stok_new` INT)   BEGIN
INSERT INTO buku (id_buku, judul_buku, penulis, kategori, stok) values (
id_buku_new, judul_buku_new, penulis_new, kategori_new, stok_new);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertpeminjaman` (IN `id_peminjaman_new` INT, IN `id_siswa_new` INT, IN `id_buku_new` INT, IN `tanggal_pinjam_new` DATE, IN `tanggal_kembali_new` DATE, IN `status_new` ENUM('Dipinjam','Dikembalikan'))   BEGIN
INSERT INTO peminjaman (id_peminjaman, id_siswa, id_buku, tanggal_pinjam, tanggal_kembali, status) VALUES (
id_peminjaman_new, id_siswa_new, id_buku_new, tanggal_pinjam_new, tanggal_kembali_new, status_new);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertsiswa` (IN `id_siswa_new` INT, IN `nama_new` VARCHAR(255), IN `kelas_new` VARCHAR(255))   BEGIN 
INSERT INTO siswa (id_siswa, nama, kelas) values (id_siswa_new, nama_new, kelas_new);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `kembalikan_buku` (IN `id_peminjaman_new` INT)   BEGIN
UPDATE peminjaman SET tanggal_kembali = CURRENT_DATE, status = 'Dikembalikan' WHERE id_peminjaman = id_peminjaman_new;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `selectbuku` ()   BEGIN
SELECT * FROM buku;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `selectpeminjaman` ()   BEGIN
SELECT * FROM peminjaman;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `selectsiswa` ()   BEGIN
SELECT * FROM siswa;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `tampilkan_semua_buku` ()   BEGIN 
SELECT buku.id_buku, buku.judul_buku,peminjaman.id_peminjaman,peminjaman.tanggal_pinjam,peminjaman.tanggal_kembali,peminjaman.status
FROM buku
LEFT JOIN peminjaman ON buku.id_buku = peminjaman.id_buku;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `tampilkan_semua_siswa` ()   BEGIN
SELECT siswa.id_siswa,siswa.nama, siswa.kelas,peminjaman.id_peminjaman
FROM siswa
LEFT JOIN peminjaman ON siswa.id_siswa = peminjaman.id_siswa;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `updatebuku` (IN `id_buku_new` INT, IN `judul_buku_new` VARCHAR(255), IN `penulis_new` VARCHAR(255), IN `kategori_new` VARCHAR(255), IN `stok_new` INT)   BEGIN 
UPDATE buku SET judul_buku = judul_buku_new, penulis = penulis_new, kategori = kategori_new, stok = stok_new WHERE id_buku = id_buku_new;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `updatepeminjaman` (IN `id_peminjaman_new` INT, IN `id_siswa_new` INT, IN `id_buku_new` INT, IN `tanggal_pinjam_new` DATE, IN `tanggal_kembali_new` DATE, IN `status_new` ENUM('Dipinjam','Dikembalikan'))   BEGIN
UPDATE peminjaman SET id_siswa = id_siswa_new, id_buku = id_buku_new, tanggal_pinjam = tanggal_pinjam_new, tanggal_kembali = tanggal_kembali_new, status = status_new WHERE id_peminjaman = id_peminjaman_new;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `updatesiswa` (IN `id_siswa_new` INT, IN `nama_new` VARCHAR(255), IN `kelas_new` VARCHAR(255))   BEGIN 
UPDATE siswa SET nama = nama_new, kelas = kelas_new WHERE id_siswa = id_siswa_new;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `buku`
--

CREATE TABLE `buku` (
  `id_buku` int(11) NOT NULL,
  `judul_buku` varchar(255) DEFAULT NULL,
  `penulis` varchar(255) DEFAULT NULL,
  `kategori` varchar(255) DEFAULT NULL,
  `stok` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `buku`
--

INSERT INTO `buku` (`id_buku`, `judul_buku`, `penulis`, `kategori`, `stok`) VALUES
(1, 'Algoritma dan Pemerograman', 'Andi Wijaya', 'Teknologi', 5),
(2, 'Dasar - dasar Database', 'Budi Santoso', 'Teknologi', 7),
(3, 'Matematika Dikrit', 'Rina Sari', 'Matematika', 4),
(4, 'Sejarah Dunia', 'Jhon Smith', 'Sejarah', 3),
(5, 'Pemerograman Web dengan PHP', 'Eko Prasetyo', 'Teknologi', 8),
(6, 'Sistem Operasi', 'Dian Kurniawan', 'Teknologi', 6),
(7, 'Jaringan Komputer', 'Ahmad Fauzi', 'Teknologi', 5),
(8, 'Cerita Rakyat Nusantara', 'Lestari Dewi', 'Sastra', 9),
(9, 'Bahasa Inggris Untuk Pemula', 'Jane Doe', 'Bahasa', 10),
(10, 'Biologi Dasar', 'Budi Rahman', 'Sains', 7),
(11, 'Kimia Organik', 'Siti Aminah', 'Sains', 5),
(12, 'Teknik Elektro', 'Ridwan Hakim', 'Teknik', 6),
(13, 'Fisika Modern', 'Albert Einstein', 'Sains', 4),
(14, 'Manajemen Waktu', 'Steven Covey', 'Pengembangan', 8),
(15, 'Strategi Belajar Efektif', 'Tony Buzan', 'Pendidikan', 6);

-- --------------------------------------------------------

--
-- Struktur dari tabel `peminjaman`
--

CREATE TABLE `peminjaman` (
  `id_peminjaman` int(11) NOT NULL,
  `id_siswa` int(11) DEFAULT NULL,
  `id_buku` int(11) DEFAULT NULL,
  `tanggal_pinjam` date DEFAULT NULL,
  `tanggal_kembali` date DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `peminjaman`
--

INSERT INTO `peminjaman` (`id_peminjaman`, `id_siswa`, `id_buku`, `tanggal_pinjam`, `tanggal_kembali`, `status`) VALUES
(1, 11, 2, '2025-02-01', '2025-02-08', 'Dipinjam'),
(2, 2, 5, '2025-01-28', '2025-02-04', 'Dikembalikan'),
(3, 3, 8, '2025-02-02', '2025-02-09', 'Dipinjam'),
(4, 4, 10, '2025-01-30', '2025-02-06', 'Dikembalikan'),
(5, 5, 3, '2025-01-25', '2025-02-01', 'Dikembalikan'),
(6, 15, 7, '2025-02-01', '2025-02-08', 'Dipinjam'),
(7, 7, 1, '2025-01-29', '2025-02-05', 'Dikembalikan'),
(8, 8, 9, '2025-02-03', '2025-02-10', 'Dipinjam'),
(9, 13, 4, '2025-01-27', '2025-02-03', 'Dikembalikan'),
(10, 10, 11, '2025-02-01', '2025-02-08', 'Dipinjam');

--
-- Trigger `peminjaman`
--
DELIMITER $$
CREATE TRIGGER `kurangi_stok_buku` AFTER INSERT ON `peminjaman` FOR EACH ROW BEGIN 
UPDATE buku
SET stok = stok - 1
WHERE id_buku = new.id_buku;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `stok_buku_bertambah` AFTER UPDATE ON `peminjaman` FOR EACH ROW BEGIN
IF new.status = 'Dikembalikan' AND old.status = 'Dipinjam' THEN
UPDATE buku
SET stok = stok + 1
WHERE id_buku = new.id_buku;
END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `siswa`
--

CREATE TABLE `siswa` (
  `id_siswa` int(11) NOT NULL,
  `nama` varchar(255) DEFAULT NULL,
  `kelas` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `siswa`
--

INSERT INTO `siswa` (`id_siswa`, `nama`, `kelas`) VALUES
(1, 'Andi Saputra', 'X-RPL'),
(2, 'Budi Wijaya', 'X-TKJ'),
(3, 'Citra Lestari ', 'XI-RPL'),
(4, 'Dewi Kurniawan ', 'XI-TKJ'),
(5, 'Eko Prasetyo ', 'XII-RPL'),
(6, 'Farhan Maulana', 'XII-TKJ'),
(7, 'Gita Permata', 'X-RPL'),
(8, 'Hadi Sucipto', 'X-TKJ'),
(9, 'Intan Permadi', 'XI-RPL'),
(10, 'Joko Santoso', 'XI-TKJ'),
(11, 'Kartika Sari', 'XII-RPL'),
(12, 'Lintang Putri', 'XII-TKJ'),
(13, 'Muhammad Rizky', 'X-RPL'),
(14, 'Novi Andriana', 'X-TKJ'),
(15, 'Olivia Hernanda', 'XI-RPL');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `buku`
--
ALTER TABLE `buku`
  ADD PRIMARY KEY (`id_buku`);

--
-- Indeks untuk tabel `peminjaman`
--
ALTER TABLE `peminjaman`
  ADD PRIMARY KEY (`id_peminjaman`);

--
-- Indeks untuk tabel `siswa`
--
ALTER TABLE `siswa`
  ADD PRIMARY KEY (`id_siswa`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `buku`
--
ALTER TABLE `buku`
  MODIFY `id_buku` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT untuk tabel `peminjaman`
--
ALTER TABLE `peminjaman`
  MODIFY `id_peminjaman` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT untuk tabel `siswa`
--
ALTER TABLE `siswa`
  MODIFY `id_siswa` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
