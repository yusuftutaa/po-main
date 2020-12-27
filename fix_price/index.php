<?php
include_once "sesi.php";
$modul=(isset($_GET['s']))?$_GET['s']:"awal";
switch($modul){
	case 'awal': default: include "fix_price/tampil.php"; break;
	case 'simpan': include "fix_price/simpan.php"; break;
	case 'hapus': include "fix_price/hapus.php"; break;

}
?>
