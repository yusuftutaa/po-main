<?php
if(isset($_GET['idsg'])){
	try{
		$id = $_GET['idsg'];
		$today = date('Y-m-d H:i:s');
		$sql="UPDATE tb_suppliers_goods SET active='T', mod_timestamp='$today' WHERE id_supplier='$id'";
		$dbcon->exec($sql);
		echo "<script type='text/javascript'> document.location = 'index.php?m=supplier_goods'; </script>";
	}catch(PDOException $ex){
		echo "<script type='text/javascript'>alert('Update Suplier Error!');</script>";
		print_r($dbcon->errorInfo());
	}
}
?>
