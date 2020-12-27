-- phpMyAdmin SQL Dump
-- version 5.0.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 27 Des 2020 pada 00.12
-- Versi server: 10.4.14-MariaDB
-- Versi PHP: 7.4.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_po_coffeeandcouple`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_account`
--

CREATE TABLE `tb_account` (
  `id_account` int(11) NOT NULL,
  `behalf` varchar(20) NOT NULL,
  `account` varchar(25) NOT NULL,
  `account_bank` varchar(20) NOT NULL,
  `created` datetime NOT NULL,
  `last_modified` datetime DEFAULT NULL,
  `created_by` int(11) NOT NULL,
  `modified_by` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `tb_account`
--

INSERT INTO `tb_account` (`id_account`, `behalf`, `account`, `account_bank`, `created`, `last_modified`, `created_by`, `modified_by`) VALUES
(1, 'Wildan', '12345678', 'BCA', '2020-11-27 09:51:12', NULL, 1, 0);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_button`
--

CREATE TABLE `tb_button` (
  `id_button` int(11) NOT NULL,
  `button_id` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `class` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `tb_button`
--

INSERT INTO `tb_button` (`id_button`, `button_id`, `name`, `class`) VALUES
(1, 'approve', 'DISETUJUI', 'btn btn-success btn-block'),
(2, 'reject', 'DITOLAK', 'btn btn-info btn-block'),
(3, 'print_po', 'CETAK PO', 'btn btn-success btn-block'),
(4, 'print_modal', 'CETAK NOTA TRANSFER', 'btn btn-success btn-block'),
(5, 'buy-proccess', 'PROSES BELI', 'btn btn-info btn-block'),
(6, 'transfer', 'DITRANSFER', 'btn btn-info btn-block'),
(7, 'print_po_supplier', 'CETAK PO SUPLIER', 'btn btn-warning btn-block'),
(8, 'entry_goods', 'VALIDASI BARANG', 'btn btn-info btn-block'),
(9, 'payment_supplier', 'PEMBAYARAN SUPLIER', 'btn btn-warning btn-block');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_category`
--

CREATE TABLE `tb_category` (
  `id_category` int(11) NOT NULL,
  `category_name` varchar(100) NOT NULL,
  `group_category` int(1) NOT NULL,
  `active` varchar(1) NOT NULL,
  `created` datetime NOT NULL,
  `last_modified` datetime DEFAULT NULL,
  `created_by` int(11) NOT NULL,
  `modified_by` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `tb_category`
--

INSERT INTO `tb_category` (`id_category`, `category_name`, `group_category`, `active`, `created`, `last_modified`, `created_by`, `modified_by`) VALUES
(1, 'COFFEE BASED WITH SUGAR', 2, 'Y', '2020-10-10 14:22:06', '2020-10-13 16:26:00', 0, 0),
(2, 'RICEBOX', 1, 'Y', '2020-10-11 15:20:54', '2020-10-13 16:25:10', 0, 0),
(3, 'DESSERT BOX', 1, 'Y', '2020-10-13 16:24:49', NULL, 0, 0),
(4, 'FROZEN FOOD', 1, 'Y', '2020-10-13 16:26:28', NULL, 0, 0),
(5, 'COFFEE BASED NON SUGAR', 2, 'Y', '2020-10-13 16:26:57', NULL, 0, 0),
(6, 'NON COFFEE', 2, 'Y', '2020-10-13 16:27:16', NULL, 0, 0),
(7, 'MINI DESSERT BOX', 1, 'Y', '2020-10-14 12:04:37', NULL, 0, 0),
(10, 'SOFT DRINK', 2, 'Y', '2020-11-13 08:23:57', NULL, 1, 0);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_category_barang`
--

CREATE TABLE `tb_category_barang` (
  `id_category_barang` int(11) NOT NULL,
  `name_category_barang` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `tb_category_barang`
--

INSERT INTO `tb_category_barang` (`id_category_barang`, `name_category_barang`) VALUES
(1, 'BAHAN BAKU'),
(2, 'ASSET');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_detail_pr_item`
--

CREATE TABLE `tb_detail_pr_item` (
  `id_detail_pr_item` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `id_purchase_requition` varchar(25) NOT NULL,
  `id_supplier` int(11) NOT NULL,
  `id_goods` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `tb_detail_pr_item`
--

INSERT INTO `tb_detail_pr_item` (`id_detail_pr_item`, `quantity`, `id_purchase_requition`, `id_supplier`, `id_goods`) VALUES
(1, 100, 'CC-2-20201226-0001', 2, 3),
(2, 400, 'CC-2-20201226-0001', 1, 1),
(3, 5000, 'CC-2-20201226-0001', 1, 2);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_detail_status`
--

CREATE TABLE `tb_detail_status` (
  `id_detail_stat` int(11) NOT NULL,
  `id_parents` int(11) NOT NULL,
  `id_childs` int(11) NOT NULL,
  `id_button` int(11) NOT NULL,
  `category` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `tb_detail_status`
--

INSERT INTO `tb_detail_status` (`id_detail_stat`, `id_parents`, `id_childs`, `id_button`, `category`) VALUES
(1, 2, 2, 1, 2),
(2, 2, 3, 2, 2),
(3, 2, 2, 3, 2),
(4, 3, 1, 4, 2),
(5, 5, 1, 7, 2),
(6, 5, 1, 5, 2),
(7, 7, 1, 8, 2),
(8, 8, 1, 9, 2),
(9, 2, 2, 1, 1),
(10, 2, 3, 2, 1),
(11, 2, 2, 3, 1),
(12, 3, 1, 4, 1),
(13, 5, 1, 6, 1),
(14, 6, 1, 5, 1),
(15, 7, 1, 8, 1),
(16, 8, 1, 9, 1);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_entry_goods`
--

CREATE TABLE `tb_entry_goods` (
  `id_entry_goods` int(11) NOT NULL,
  `quantity_receive` int(11) NOT NULL,
  `info` text NOT NULL,
  `id_detail_pr_item` int(11) NOT NULL,
  `created` datetime NOT NULL,
  `last_modified` datetime DEFAULT NULL,
  `created_by` int(11) NOT NULL,
  `modified_by` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `tb_entry_goods`
--

INSERT INTO `tb_entry_goods` (`id_entry_goods`, `quantity_receive`, `info`, `id_detail_pr_item`, `created`, `last_modified`, `created_by`, `modified_by`) VALUES
(1, 5000, '', 3, '2020-12-26 16:31:43', NULL, 1, 0),
(2, 5000, '', 3, '2020-12-26 16:37:42', NULL, 1, 0),
(3, 5000, '', 3, '2020-12-26 16:39:37', NULL, 1, 0),
(4, 5000, '', 3, '2020-12-26 16:40:37', NULL, 1, 0),
(5, 400, '', 2, '2020-12-26 16:40:37', NULL, 1, 0),
(6, 100, '', 1, '2020-12-26 16:40:37', NULL, 1, 0);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_fix_price`
--

CREATE TABLE `tb_fix_price` (
  `id_fix_price` int(11) NOT NULL,
  `id_purchase_requition` varchar(30) NOT NULL,
  `id_goods` int(11) NOT NULL,
  `fixed_price` int(15) NOT NULL,
  `active` varchar(1) NOT NULL,
  `created` timestamp NOT NULL DEFAULT current_timestamp(),
  `last_modified` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  `created_by` int(11) NOT NULL,
  `modified_by` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `tb_fix_price`
--

INSERT INTO `tb_fix_price` (`id_fix_price`, `id_purchase_requition`, `id_goods`, `fixed_price`, `active`, `created`, `last_modified`, `created_by`, `modified_by`) VALUES
(1, 'CC-2-20201226-0001', 2, 12000, 'Y', '2020-12-26 09:40:37', NULL, 1, 0),
(2, 'CC-2-20201226-0001', 1, 10000, 'Y', '2020-12-26 09:40:37', NULL, 1, 0),
(3, 'CC-2-20201226-0001', 3, 5000, 'Y', '2020-12-26 09:40:37', NULL, 1, 0);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_goods`
--

CREATE TABLE `tb_goods` (
  `id_goods` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `category_goods` int(11) NOT NULL,
  `stock` int(11) NOT NULL,
  `quantity_unit` int(11) NOT NULL,
  `price_estimate` int(15) NOT NULL,
  `active` varchar(1) NOT NULL,
  `created` datetime NOT NULL,
  `last_modified` datetime DEFAULT NULL,
  `created_by` int(11) NOT NULL,
  `modified_by` int(11) NOT NULL,
  `id_role` int(11) NOT NULL,
  `id_unit` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `tb_goods`
--

INSERT INTO `tb_goods` (`id_goods`, `name`, `category_goods`, `stock`, `quantity_unit`, `price_estimate`, `active`, `created`, `last_modified`, `created_by`, `modified_by`, `id_role`, `id_unit`) VALUES
(1, 'Susu', 1, 1368, 1000, 10000, 'Y', '2020-11-09 06:57:44', '2020-12-26 16:40:37', 1, 1, 3, 4),
(2, 'Kopi', 1, 20640, 1000, 12000, 'Y', '2020-11-10 07:56:40', '2020-12-26 16:40:37', 1, 1, 1, 1),
(3, 'Aren Sirup', 2, 300, 100, 5000, 'Y', '2020-11-17 06:56:00', '2020-12-26 16:40:37', 1, 1, 3, 4);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_goods_receipt`
--

CREATE TABLE `tb_goods_receipt` (
  `id_goods_receipt` int(11) NOT NULL,
  `parent_id_goods` int(11) NOT NULL,
  `child_id_goods` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `cost` int(15) NOT NULL,
  `created` datetime NOT NULL,
  `last_modified` datetime DEFAULT NULL,
  `created_by` int(11) NOT NULL,
  `modified_by` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `tb_goods_receipt`
--

INSERT INTO `tb_goods_receipt` (`id_goods_receipt`, `parent_id_goods`, `child_id_goods`, `quantity`, `cost`, `created`, `last_modified`, `created_by`, `modified_by`) VALUES
(1, 3, 2, 120, 1440, '2020-11-17 15:16:18', '2020-11-17 15:34:12', 1, 1);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_history_login`
--

CREATE TABLE `tb_history_login` (
  `id_history` int(11) NOT NULL,
  `login_time` datetime NOT NULL,
  `ip` varchar(20) NOT NULL,
  `id_user` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_menu`
--

CREATE TABLE `tb_menu` (
  `id_menu` varchar(20) NOT NULL,
  `sequence` int(11) NOT NULL,
  `menu_name` varchar(50) NOT NULL,
  `parent_id` varchar(15) NOT NULL,
  `module` varchar(30) NOT NULL,
  `path` varchar(100) NOT NULL,
  `url` varchar(50) NOT NULL,
  `icon` varchar(30) NOT NULL,
  `aktif` varchar(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data untuk tabel `tb_menu`
--

INSERT INTO `tb_menu` (`id_menu`, `sequence`, `menu_name`, `parent_id`, `module`, `path`, `url`, `icon`, `aktif`) VALUES
('ENTRY_GOODS', 1, 'Barang Masuk', 'PUR_REQ', 'hist_entry_goods', 'hist_entry_goods/index.php', '?m=hist_entry_goods', 'fa fa-donation', 'Y'),
('FIX_PRICE', 5, 'Fix Price', '*', 'fix_price', 'fix_price/index.php', '?m=fix_price', 'fa fa-money', 'Y'),
('GOODS', 3, 'Barang', 'PRODUCT', 'goods', 'goods/index.php', '?m=goods\r\n', 'fa fa-product-hunt', 'Y'),
('HOME', 1, 'Beranda', '*', 'awal', 'home/index.php', 'index.php\r\n', 'fas fa-home', 'Y'),
('PR', 1, 'Purchase Request', '*', 'prequest', 'prequest/index.php', '?m=prequest', 'fas fa-file-invoice-dollar', 'Y'),
('PRODUCT', 2, 'Produk', '*', '#\r\n', '*', '#', 'fas fa-utensils', 'Y'),
('PRODUCT_LIST', 4, 'Daftar Produk', 'PRODUCT', 'product', 'product/index.php', '?m=product', 'fas fa-shopping-basket', 'Y'),
('PROD_CATEGORY', 2, 'Kategori', 'PRODUCT', 'category', 'category/index.php', '?m=category', 'fa fa-tag', 'Y'),
('PUR_REQ', 4, 'Purchase Requition', '*', '*', '*', '#', 'fa fa-paper-plane', 'Y'),
('PUR_REQUEST', 1, 'Purchase Request', 'PUR_REQ', 'purchase_requition', 'purchase_requition/index.php', '?m=purchase_requition', 'fa fa-donation', 'Y'),
('SUPPLIER', 3, 'Suplier', '*', 'suppliers', 'suppliers/index.php', '?m=suppliers\r\n', 'fas fa-user-friends', 'Y'),
('SUPPLIER_GOODS', 1, 'Bahan Suplier', 'SUPPLIER', 'supplier_goods', 'supplier_goods/index.php', '?m=supplier_goods\r\n', 'fa fa-dropbox', 'T'),
('UNIT', 1, 'Satuan', 'PRODUCT', 'unit', 'unit/index.php', '?m=unit\r\n', 'fas fa-tag', 'Y'),
('USERS', 4, 'Users', '*', 'users', 'users/index.php', '?m=users\r\n', 'fas fa-users', 'Y');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_payment`
--

CREATE TABLE `tb_payment` (
  `id_payment` int(11) NOT NULL,
  `method` int(11) NOT NULL,
  `id_purchase_requition` varchar(25) NOT NULL,
  `id_account` int(11) NOT NULL,
  `created` datetime NOT NULL,
  `last_modified` datetime DEFAULT NULL,
  `created_by` int(11) NOT NULL,
  `modified_by` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `tb_payment`
--

INSERT INTO `tb_payment` (`id_payment`, `method`, `id_purchase_requition`, `id_account`, `created`, `last_modified`, `created_by`, `modified_by`) VALUES
(1, 2, 'CC-2-20201226-0001', 1, '2020-12-26 16:20:56', NULL, 1, 0);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_permission`
--

CREATE TABLE `tb_permission` (
  `id_permission` int(11) NOT NULL,
  `id_menu` varchar(20) NOT NULL,
  `id_role` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data untuk tabel `tb_permission`
--

INSERT INTO `tb_permission` (`id_permission`, `id_menu`, `id_role`) VALUES
(1, 'HOME', 1),
(2, 'HOME', 2),
(3, 'HOME', 3),
(4, 'HOME', 4),
(5, 'THINGS', 1),
(6, 'THINGS', 2),
(7, 'THINGS', 3),
(8, 'THINGS', 4),
(9, 'USERS', 1),
(10, 'SUPPLIER', 1),
(11, 'SUPPLIER', 2),
(12, 'SUPPLIER', 3),
(13, 'SUPPLIER', 4),
(14, 'UNIT', 1),
(15, 'GOODS', 1),
(16, 'GOODS', 2),
(17, 'GOODS', 3),
(18, 'GOODS', 4),
(19, 'SUPPLIER_GOODS', 1),
(20, 'SUPPLIER_GOODS', 2),
(21, 'SUPPLIER_GOODS', 3),
(22, 'SUPPLIER_GOODS', 4),
(23, 'PRODUCT', 1),
(24, 'PRODUCT_LIST', 1),
(25, 'PROD_CATEGORY', 1),
(26, 'PUR_REQ', 1),
(27, 'PUR_REQ', 2),
(28, 'PUR_REQ', 3),
(29, 'PUR_REQ', 4),
(30, 'PUR_REQUEST', 1),
(31, 'PUR_REQUEST', 2),
(32, 'PUR_REQUEST', 3),
(33, 'PUR_REQUEST', 4),
(34, 'ENTRY_GOODS', 1),
(35, 'FIX_PRICE', 1);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_product`
--

CREATE TABLE `tb_product` (
  `id_product` int(11) NOT NULL,
  `product_name` varchar(100) NOT NULL,
  `price` int(20) NOT NULL,
  `hpp` int(15) NOT NULL,
  `total_cost` int(11) NOT NULL,
  `active` varchar(1) NOT NULL,
  `created` datetime NOT NULL,
  `last_modified` datetime DEFAULT NULL,
  `created_by` int(11) NOT NULL,
  `modified_by` int(11) NOT NULL,
  `id_category` int(11) NOT NULL,
  `group_product` int(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `tb_product`
--

INSERT INTO `tb_product` (`id_product`, `product_name`, `price`, `hpp`, `total_cost`, `active`, `created`, `last_modified`, `created_by`, `modified_by`, `id_category`, `group_product`) VALUES
(1, 'BEEF TERIYAKI', 45000, 0, 0, 'Y', '2020-10-11 15:21:52', '2020-10-13 16:30:23', 0, 0, 2, 1),
(2, 'KOPI JOMBLO', 18000, 0, 1488, 'Y', '2020-10-11 15:24:57', '2020-10-19 13:01:40', 0, 0, 5, 1),
(3, 'CHICKEN TERIYAKI', 35000, 0, 0, 'Y', '2020-10-13 16:33:05', '2020-10-14 03:13:39', 0, 0, 2, 1),
(4, 'SPICY CHICKEN WINGS', 30000, 0, 0, 'Y', '2020-10-13 16:35:06', NULL, 0, 0, 4, 1),
(5, 'AYAM BAKAR (1 EKOR)', 80000, 0, 0, 'Y', '2020-10-14 03:14:43', '2020-10-14 03:51:05', 0, 0, 4, 1),
(6, 'RAWON IGA', 80000, 0, 0, 'Y', '2020-10-14 03:33:24', NULL, 0, 0, 4, 1),
(7, 'CHCKEN KUNG PAU', 45000, 0, 0, 'Y', '2020-10-14 03:37:59', NULL, 0, 0, 4, 1),
(8, 'CHICKEN SALTED EGG', 35000, 0, 0, 'Y', '2020-10-14 03:53:58', '2020-10-19 13:13:09', 0, 0, 2, 1),
(9, 'DORI MATAH', 35000, 0, 0, 'Y', '2020-10-14 03:55:23', '2020-10-19 13:08:59', 0, 0, 2, 1),
(11, 'TIRAMISU', 65000, 0, 0, 'Y', '2020-10-14 04:05:47', NULL, 0, 0, 3, 1),
(12, 'CHOCO SOIL', 60000, 0, 0, 'Y', '2020-10-14 04:08:36', NULL, 0, 0, 3, 1),
(13, 'OREO CHEESE CAKE', 60000, 0, 0, 'Y', '2020-10-14 05:48:23', NULL, 0, 0, 3, 1),
(14, 'CARAMEL REGAL', 60000, 0, 0, 'Y', '2020-10-14 05:49:53', '2020-10-19 13:00:25', 0, 0, 3, 1),
(15, 'GREEN TEA', 70000, 0, 0, 'Y', '2020-10-14 12:01:12', '2020-10-19 12:58:19', 0, 0, 3, 1),
(16, 'RED VELVET', 65000, 0, 0, 'Y', '2020-10-14 12:01:58', NULL, 0, 0, 3, 1),
(17, 'MINI TIRAMISU', 25000, 0, 0, 'Y', '2020-10-14 12:05:19', NULL, 0, 0, 7, 1),
(18, 'MINI CHOCO SOIL', 25000, 0, 0, 'Y', '2020-10-14 12:06:49', NULL, 0, 0, 7, 1),
(19, 'MINI OREO CHEESE CAKE', 25000, 0, 0, 'Y', '2020-10-14 12:30:12', NULL, 0, 0, 7, 1),
(20, 'MINI CARAMEL REGAL', 25000, 0, 0, 'Y', '2020-10-15 02:17:57', NULL, 0, 0, 7, 1),
(21, 'MINI GREEN TEA', 25000, 0, 0, 'Y', '2020-10-15 02:18:48', NULL, 0, 0, 7, 1),
(22, 'KOPI RINDU', 22000, 0, 2900, 'Y', '2020-10-15 02:39:52', '2020-10-19 13:02:56', 0, 0, 5, 1),
(23, 'KOPI PEDEKATE', 20000, 0, 0, 'Y', '2020-10-15 02:49:56', '2020-10-19 13:03:48', 0, 0, 1, 1),
(24, 'KOPI KENCAN PERTAMA', 25000, 0, 0, 'Y', '2020-10-15 02:53:11', '2020-10-19 13:05:04', 0, 0, 1, 1),
(25, 'HUZELNUT CHOCO', 25000, 0, 0, 'Y', '2020-10-15 03:09:46', NULL, 0, 0, 6, 1),
(26, 'MATCHA LATTE', 25000, 0, 0, 'Y', '2020-10-15 03:11:31', NULL, 0, 0, 6, 1),
(27, 'THAI TEA', 25000, 0, 0, 'Y', '2020-10-15 03:13:12', NULL, 0, 0, 6, 1),
(28, 'LYCHEE YAKULT', 25000, 0, 0, 'Y', '2020-10-15 03:15:41', NULL, 0, 0, 6, 1),
(29, 'RED VELVET', 25000, 0, 0, 'Y', '2020-10-15 03:18:12', NULL, 0, 0, 6, 1),
(30, 'TEH PUCUK HARUM', 5000, 0, 0, 'Y', '2020-11-13 08:52:41', NULL, 1, 0, 10, 2);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_purchase_requition`
--

CREATE TABLE `tb_purchase_requition` (
  `id_purchase_requition` varchar(25) NOT NULL,
  `trx_date` date NOT NULL,
  `due_date` date DEFAULT NULL,
  `category` int(11) NOT NULL,
  `total` int(20) NOT NULL,
  `status` int(1) NOT NULL,
  `created` datetime NOT NULL,
  `last_modified` datetime DEFAULT NULL,
  `created_by` int(11) NOT NULL,
  `modified_by` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `tb_purchase_requition`
--

INSERT INTO `tb_purchase_requition` (`id_purchase_requition`, `trx_date`, `due_date`, `category`, `total`, `status`, `created`, `last_modified`, `created_by`, `modified_by`) VALUES
('CC-2-20201226-0001', '2020-12-26', '2020-12-27', 2, 69000, 9, '2020-12-26 16:06:11', '2020-12-26 16:40:43', 1, 0);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_receipt`
--

CREATE TABLE `tb_receipt` (
  `id_receipt` int(11) NOT NULL,
  `id_product` int(11) NOT NULL,
  `id_goods` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `cost` int(15) NOT NULL,
  `created` datetime NOT NULL,
  `last_modified` datetime DEFAULT NULL,
  `created_by` int(11) NOT NULL,
  `modified_by` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `tb_receipt`
--

INSERT INTO `tb_receipt` (`id_receipt`, `id_product`, `id_goods`, `quantity`, `cost`, `created`, `last_modified`, `created_by`, `modified_by`) VALUES
(1, 22, 2, 200, 2400, '2020-11-14 13:52:34', '2020-11-17 15:19:01', 1, 1),
(2, 2, 2, 100, 1200, '2020-11-15 03:00:08', NULL, 1, 0),
(3, 22, 1, 50, 500, '2020-11-17 07:27:38', NULL, 1, 0),
(4, 0, 1, 200, 2000, '2020-11-17 15:08:02', NULL, 1, 0),
(5, 2, 3, 20, 288, '2020-11-19 00:38:23', NULL, 1, 0);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_roles`
--

CREATE TABLE `tb_roles` (
  `id_role` int(11) NOT NULL,
  `rolename` varchar(15) NOT NULL,
  `active` varchar(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data untuk tabel `tb_roles`
--

INSERT INTO `tb_roles` (`id_role`, `rolename`, `active`) VALUES
(1, 'Administrator', 'Y'),
(2, 'Bar', 'Y'),
(3, 'Kitchen', 'Y'),
(4, 'Pastry', 'Y'),
(13, 'Owner', 'Y');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_security_password`
--

CREATE TABLE `tb_security_password` (
  `id_security_password` int(11) NOT NULL,
  `security_password` text NOT NULL,
  `aktif` varchar(1) NOT NULL,
  `id_user` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_status`
--

CREATE TABLE `tb_status` (
  `id_status` int(11) NOT NULL,
  `status` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `tb_status`
--

INSERT INTO `tb_status` (`id_status`, `status`) VALUES
(1, 'BATAL'),
(2, 'PROSES VERIFIKASI'),
(3, 'DISETUJUI'),
(4, 'DITOLAK'),
(5, 'CETAK NOTA PENGAJUAN'),
(6, 'DITRANSFER'),
(7, 'PROSES BELI'),
(8, 'PEMBAYARAN SUPLIER'),
(9, 'SELESAI');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_suppliers`
--

CREATE TABLE `tb_suppliers` (
  `id_supplier` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `address` text NOT NULL,
  `phone_number` varchar(20) NOT NULL,
  `active` varchar(1) NOT NULL,
  `created` datetime NOT NULL,
  `last_modified` datetime DEFAULT NULL,
  `created_by` int(11) NOT NULL,
  `modified_by` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `tb_suppliers`
--

INSERT INTO `tb_suppliers` (`id_supplier`, `name`, `address`, `phone_number`, `active`, `created`, `last_modified`, `created_by`, `modified_by`) VALUES
(1, 'WILDAN', '-', '999999995', 'Y', '2020-11-08 20:48:20', '2020-11-08 21:09:45', 1, 1),
(2, 'MUFID', '-', '08888888', 'Y', '2020-11-09 20:01:10', NULL, 1, 0);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_unit`
--

CREATE TABLE `tb_unit` (
  `id_unit` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `active` varchar(1) NOT NULL,
  `created` datetime NOT NULL,
  `last_modified` datetime DEFAULT NULL,
  `created_by` int(11) NOT NULL,
  `modified_by` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `tb_unit`
--

INSERT INTO `tb_unit` (`id_unit`, `name`, `active`, `created`, `last_modified`, `created_by`, `modified_by`) VALUES
(1, 'gr', 'Y', '2020-11-08 23:12:05', '2020-11-14 07:52:05', 1, 1),
(2, 'kg', 'Y', '2020-11-08 23:12:27', '2020-11-14 07:52:00', 1, 1),
(3, 'ons', 'Y', '2020-11-08 23:12:35', '2020-11-14 07:54:43', 1, 1),
(4, 'ml', 'Y', '2020-11-14 07:51:48', '2020-11-14 07:51:54', 1, 1);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_users`
--

CREATE TABLE `tb_users` (
  `id_user` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `username` varchar(20) NOT NULL,
  `password` varchar(500) NOT NULL,
  `status` varchar(10) NOT NULL,
  `created` datetime NOT NULL,
  `last_modified` datetime DEFAULT NULL,
  `id_role` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data untuk tabel `tb_users`
--

INSERT INTO `tb_users` (`id_user`, `name`, `username`, `password`, `status`, `created`, `last_modified`, `id_role`) VALUES
(1, 'Eva Oktaviani', 'admin', '240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9', 'Y', '0000-00-00 00:00:00', '2020-11-08 13:48:42', 1),
(2, 'Ompong', 'kitchenn', '240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9', 'Y', '2020-11-08 13:52:16', '2020-12-02 15:17:01', 3),
(4, 'andaa', 'anda1', '2fd81fbf360b9bfccc0c0aff3035e8c85ad81d997443011ab117656957bd1f04', 'Y', '2020-12-02 15:32:32', NULL, 2);

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `tb_account`
--
ALTER TABLE `tb_account`
  ADD PRIMARY KEY (`id_account`);

--
-- Indeks untuk tabel `tb_button`
--
ALTER TABLE `tb_button`
  ADD PRIMARY KEY (`id_button`);

--
-- Indeks untuk tabel `tb_category`
--
ALTER TABLE `tb_category`
  ADD PRIMARY KEY (`id_category`);

--
-- Indeks untuk tabel `tb_category_barang`
--
ALTER TABLE `tb_category_barang`
  ADD PRIMARY KEY (`id_category_barang`);

--
-- Indeks untuk tabel `tb_detail_pr_item`
--
ALTER TABLE `tb_detail_pr_item`
  ADD PRIMARY KEY (`id_detail_pr_item`);

--
-- Indeks untuk tabel `tb_detail_status`
--
ALTER TABLE `tb_detail_status`
  ADD PRIMARY KEY (`id_detail_stat`);

--
-- Indeks untuk tabel `tb_entry_goods`
--
ALTER TABLE `tb_entry_goods`
  ADD PRIMARY KEY (`id_entry_goods`);

--
-- Indeks untuk tabel `tb_fix_price`
--
ALTER TABLE `tb_fix_price`
  ADD PRIMARY KEY (`id_fix_price`);

--
-- Indeks untuk tabel `tb_goods`
--
ALTER TABLE `tb_goods`
  ADD PRIMARY KEY (`id_goods`);

--
-- Indeks untuk tabel `tb_goods_receipt`
--
ALTER TABLE `tb_goods_receipt`
  ADD PRIMARY KEY (`id_goods_receipt`);

--
-- Indeks untuk tabel `tb_history_login`
--
ALTER TABLE `tb_history_login`
  ADD PRIMARY KEY (`id_history`);

--
-- Indeks untuk tabel `tb_menu`
--
ALTER TABLE `tb_menu`
  ADD PRIMARY KEY (`id_menu`);

--
-- Indeks untuk tabel `tb_payment`
--
ALTER TABLE `tb_payment`
  ADD PRIMARY KEY (`id_payment`);

--
-- Indeks untuk tabel `tb_permission`
--
ALTER TABLE `tb_permission`
  ADD PRIMARY KEY (`id_permission`);

--
-- Indeks untuk tabel `tb_product`
--
ALTER TABLE `tb_product`
  ADD PRIMARY KEY (`id_product`);

--
-- Indeks untuk tabel `tb_purchase_requition`
--
ALTER TABLE `tb_purchase_requition`
  ADD PRIMARY KEY (`id_purchase_requition`);

--
-- Indeks untuk tabel `tb_receipt`
--
ALTER TABLE `tb_receipt`
  ADD PRIMARY KEY (`id_receipt`);

--
-- Indeks untuk tabel `tb_roles`
--
ALTER TABLE `tb_roles`
  ADD PRIMARY KEY (`id_role`);

--
-- Indeks untuk tabel `tb_security_password`
--
ALTER TABLE `tb_security_password`
  ADD PRIMARY KEY (`id_security_password`);

--
-- Indeks untuk tabel `tb_status`
--
ALTER TABLE `tb_status`
  ADD PRIMARY KEY (`id_status`);

--
-- Indeks untuk tabel `tb_suppliers`
--
ALTER TABLE `tb_suppliers`
  ADD PRIMARY KEY (`id_supplier`);

--
-- Indeks untuk tabel `tb_unit`
--
ALTER TABLE `tb_unit`
  ADD PRIMARY KEY (`id_unit`);

--
-- Indeks untuk tabel `tb_users`
--
ALTER TABLE `tb_users`
  ADD PRIMARY KEY (`id_user`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `tb_account`
--
ALTER TABLE `tb_account`
  MODIFY `id_account` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT untuk tabel `tb_button`
--
ALTER TABLE `tb_button`
  MODIFY `id_button` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT untuk tabel `tb_category`
--
ALTER TABLE `tb_category`
  MODIFY `id_category` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT untuk tabel `tb_category_barang`
--
ALTER TABLE `tb_category_barang`
  MODIFY `id_category_barang` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `tb_detail_pr_item`
--
ALTER TABLE `tb_detail_pr_item`
  MODIFY `id_detail_pr_item` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT untuk tabel `tb_detail_status`
--
ALTER TABLE `tb_detail_status`
  MODIFY `id_detail_stat` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT untuk tabel `tb_entry_goods`
--
ALTER TABLE `tb_entry_goods`
  MODIFY `id_entry_goods` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT untuk tabel `tb_fix_price`
--
ALTER TABLE `tb_fix_price`
  MODIFY `id_fix_price` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT untuk tabel `tb_goods`
--
ALTER TABLE `tb_goods`
  MODIFY `id_goods` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT untuk tabel `tb_goods_receipt`
--
ALTER TABLE `tb_goods_receipt`
  MODIFY `id_goods_receipt` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT untuk tabel `tb_history_login`
--
ALTER TABLE `tb_history_login`
  MODIFY `id_history` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `tb_payment`
--
ALTER TABLE `tb_payment`
  MODIFY `id_payment` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT untuk tabel `tb_permission`
--
ALTER TABLE `tb_permission`
  MODIFY `id_permission` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT untuk tabel `tb_product`
--
ALTER TABLE `tb_product`
  MODIFY `id_product` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT untuk tabel `tb_receipt`
--
ALTER TABLE `tb_receipt`
  MODIFY `id_receipt` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT untuk tabel `tb_roles`
--
ALTER TABLE `tb_roles`
  MODIFY `id_role` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT untuk tabel `tb_security_password`
--
ALTER TABLE `tb_security_password`
  MODIFY `id_security_password` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `tb_status`
--
ALTER TABLE `tb_status`
  MODIFY `id_status` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT untuk tabel `tb_suppliers`
--
ALTER TABLE `tb_suppliers`
  MODIFY `id_supplier` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `tb_unit`
--
ALTER TABLE `tb_unit`
  MODIFY `id_unit` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT untuk tabel `tb_users`
--
ALTER TABLE `tb_users`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
