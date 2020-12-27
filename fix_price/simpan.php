<?php
if(isset($_POST['simpan'])){
    try{
        $id_user = $_SESSION['id_user'];
        $id_purchase_requition = "";
        $id_goods = $_POST['id_goods'];
        $fixed_price = str_replace(".", "", $_POST['fixed_price']);
        $fixed_price = str_replace("Rp ", "", $fixed_price);
        $aktif = !empty($_POST['aktif']) ? "Y" : "T";
        $today = date('Y-m-d H:i:s');
        $id_fix_price = $_POST['id_fix_price'];
        if($id_fix_price <> ""){
            if($id_fix_price > 0){
                $sql = "UPDATE tb_fix_price SET id_purchase_requition=:id_purchase_requition, id_goods=:id_goods, fixed_price=:fixed_price, active=:aktif, created=:created, last_modified=:last_modified, created_by=:created_by, modified_by=:modified_by,
                 where id_fixed_price=:id_fixed_price";
                $query = $dbcon->prepare($sql);
                $query->bindParam("id_purchase_requition", $id_purchase_requition, PDO::PARAM_STR);
                $query->bindParam("id_goods", $id_goods, PDO::PARAM_STR);
                $query->bindParam("fixed_price", $fixed_price, PDO::PARAM_STR);
                $query->bindParam("created", $today, PDO::PARAM_STR);
                $query->bindParam("last_modified", $today, PDO::PARAM_STR);
                $query->bindParam("aktif", $aktif, PDO::PARAM_STR);
                $query->bindParam("created_by", $id_user, PDO::PARAM_STR);
                $query->bindParam("modified_by", $id_user, PDO::PARAM_STR);
                $query->execute();
            echo "<script type='text/javascript'> document.location = 'index.php?m=fix_price'; </script>";
            }
        }else{
            $sql = "INSERT INTO tb_fix_price VALUES (null,:id_purchase_requition, :id_goods, :fixed_price, :aktif, null,null, :created_by, :modified_by)";
            $query = $dbcon->prepare($sql);
            $query->bindParam("id_goods", $id_purchase_requition, PDO::PARAM_STR);
            $query->bindParam("id_goods", $id_goods, PDO::PARAM_STR);
            $query->bindParam("fixed_price", $fixed_price, PDO::PARAM_STR);
            $query->bindParam("aktif", $aktif, PDO::PARAM_STR);
            $query->bindParam("created_by", $id_user, PDO::PARAM_STR);
            $query->bindParam("modified_by", $id_user, PDO::PARAM_STR);

            if($query->execute()){
              echo "<script type='text/javascript'> document.location = 'index.php?m=fix_price'; </script>";

            }
        }
    }catch(PDOException $ex){
        echo "<script type='text/javascript'>alert('Tambah Barang Error!');</script>";
        exit($ex->getMessage());
    }
}else{
	echo '<script>window.history.back()</script>';
}
?>
