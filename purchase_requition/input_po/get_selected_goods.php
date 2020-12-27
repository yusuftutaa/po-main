<?php
    try{
        include('../../fungsi/connection.php');
        $id_goods = $_POST['id'];
        $sql = "SELECT g.*, u.name as unit,
            (SELECT
            CASE 
            WHEN COUNT(id_fix_price) > 0 THEN fixed_price
            ELSE g.price_estimate END
            FROM tb_fix_price WHERE id_goods = g.id_goods ORDER BY created DESC LIMIT 1) as price
            FROM tb_goods g 
            JOIN tb_unit u ON u.id_unit = g.id_unit
            WHERE g.active='Y' and g.id_goods=:id_goods";
        $query = $dbcon->prepare($sql);
        $query->bindParam('id_goods', $id_goods, PDO::PARAM_INT);
        $query->execute();
        $data = array();
        while($row = $query->fetch(PDO::FETCH_ASSOC)){
            $data['stock'] = $row['stock'];
            $data['id_goods'] = $row['stock'];
            $data['unit'] = $row['unit'];
            $data['price'] = $row['price'];
            $data['quantity_unit'] = $row['quantity_unit'];
        }
        echo json_encode($data);
    }catch(PDOException $ex){
        exit($ex->getMessage());
    }

?>