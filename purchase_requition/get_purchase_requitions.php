<?php
    include('../fungsi/connection.php');
    session_start();
    setlocale (LC_TIME, 'id_ID');
    try{
        $id_user = $_SESSION['id_user'];
        $sql = "SELECT id_role FROM tb_users where id_user=:id_user";
        $query = $dbcon->prepare($sql);
        $query->bindParam("id_user", $id_user, PDO::PARAM_STR);
        $query->execute();
        $result = $query->fetch(PDO::FETCH_ASSOC);
        $id_role = $result['id_role'];

        $requestData = $_REQUEST;
        $searchValue = $requestData['search']['value'];
        $group = $_POST['group']  == 0 ? "" : $_POST['group'];
        $limit = $requestData['start'];
        $offset = $requestData['length'];
        $status = $_POST['status'];
        $category = $_POST['category'];
        $sqlGroup = "";
        $sql = "SELECT pr.*,  r.rolename, u.id_role, s.id_status, s.status as status_name 
         FROM tb_purchase_requition pr
         JOIN tb_users u ON u.id_user = pr.created_by
         JOIN tb_roles r ON r.id_role = u.id_role
         JOIN tb_detail_pr_item dprs ON dprs.id_purchase_requition = pr.id_purchase_requition
         RIGHT JOIN tb_goods gs ON gs.id_goods = dprs.id_goods
         JOIN tb_status s ON s.id_status = pr.status
        WHERE 1=1";
        $searchArray = array();
        $searchQuery = "";
        if($searchValue != ""){
            $searchQuery= " and (pr.id_purchase_requition LIKE :purchase_requition OR gs.name LIKE :goods)";
            $searchArray = array(
                'purchase_requition'=>"%$searchValue%",
                'goods' => "%$searchValue%"
           );
        }

        $groupQuery = "";
        if($group != ""){
            $groupQuery = " and r.id_role=:group";
        }

        $statusQuery = "";
        if($status != "" ){
            $statusQuery = " and pr.status=:status";
        }

        $categoryQuery = "";
        if($category != "" ){
            $categoryQuery = " and pr.category=:category";
        }

        $query=$dbcon->prepare($sql.$sqlGroup);
        $query->execute();
        $count = $query->rowCount();

        $sqlFilter = $sql.$searchQuery.$groupQuery.$statusQuery.$categoryQuery.$sqlGroup;
        $query=$dbcon->prepare($sqlFilter);
        if($group != ""){
            $query->bindParam("group", $group, PDO::PARAM_STR);
        }

        if($status != "" ){
            $query->bindParam("status", $status, PDO::PARAM_STR);
        }

        if($category != "" ){
            $query->bindParam("category", $category, PDO::PARAM_STR);
        }

        foreach($searchArray as $key=>$search){
            $query->bindParam(''.$key, $search, PDO::PARAM_STR);
        }
        $query->execute();
        $totalData = $query->rowCount();

        $offsetQuery = "";
        if($offset > 0){
            $offsetQuery = "LIMIT :limit, :offset";
        }
        $sqlFetch = $sql.$searchQuery.$groupQuery.$statusQuery.$categoryQuery.$sqlGroup." GROUP BY pr.id_purchase_requition ORDER BY  pr.category, date(pr.created) DESC ".$offsetQuery;
        $query=$dbcon->prepare($sqlFetch);
        foreach($searchArray as $key=>$search){
            $query->bindParam(''.$key, $search, PDO::PARAM_STR);
        }
        if($group != ""){
            $query->bindParam("group", $group, PDO::PARAM_STR);
        }
        if($status != "" ){
            $query->bindParam("status", $status, PDO::PARAM_STR);
        }
        if($category != "" ){
            $query->bindParam("category", $category, PDO::PARAM_STR);
        }
        if($offset > 0){
            $query->bindParam("limit", $limit, PDO::PARAM_INT);
            $query->bindParam("offset", $offset, PDO::PARAM_INT);
        }
        $query->execute();
        $data = array();

        while($r = $query->fetch(PDO::FETCH_ASSOC)){
            $disabled = 'onclick="return false;"';
            
            $idpr = $r['id_purchase_requition'];
            $sql = "SELECT SUM(dpr.quantity/g.quantity_unit)*
                    ((SELECT
            CASE 
            WHEN COUNT(id_fix_price) > 0 THEN fixed_price
            ELSE g.price_estimate END
            FROM tb_fix_price WHERE id_goods = g.id_goods ORDER BY created DESC LIMIT 1)) as total
                    FROM tb_goods g
                    JOIN tb_detail_pr_item dpr ON dpr.id_goods = g.id_goods
                    WHERE dpr.id_purchase_requition = :id_pr";
            $query1 = $dbcon->prepare($sql);
            $query1->bindParam('id_pr', $idpr, PDO::PARAM_STR);
            $query1->execute();
            $row = $query1->fetch(PDO::FETCH_ASSOC);
            $arr = array();
            $arr[] = $r['id_purchase_requition'];
            $arr[] = $r['category'] == 1 ? "PO 1 : Beli" : "PO 2 : PO";
            $arr[] = $r['trx_date'];
            $arr[] = $r['category'] == 2 ? $r['due_date'] : "<i>NULL</i>";
            $arr[] = $r['rolename'];
            $arr[] = "Rp " . number_format($row['total'], 0, ',', '.');
            $arr[] = $r['status_name'];

            $edit_link = '<a href="index.php?m=purchase_requition&s=input_po&idpr='.$r['id_purchase_requition'].'"><i class="fa fa-edit fa-2x"></i></a> ';
            $cancel_link = '<a href="index.php?m=purchase_requition&s=hapus&idpr='.$r['id_purchase_requition'].'" onclick="return confirm(\'Yakin akan dibatalkan?\')"><i class="fa fa-times-circle-o fa-2x"></i></a>';
            $detail_link = '<a href="index.php?m=purchase_requition&s=detail_po&idpr='.$r['id_purchase_requition'].'"><i class="fas fa-receipt fa-2x"></i></a>';

            $links_arr = array();
            $links_arr[] = $detail_link;
            if($id_role == $r['id_role']){
                if($r['id_status'] == 2){
                    $links_arr[] = $edit_link;
                    $links_arr[] = $cancel_link;
                }

            }
            $links = '<center>';
            foreach($links_arr as $i => $link){
                if($i % 1 == 0){
                    $links .= ' | ';
                }
                $links .= $links_arr[$i];
                if($i == (count($links_arr) - 1)){
                    $links .= ' | ';
                }
            }
            $link .= '</center>';
            $arr[] = $links;
            $data[] = $arr;
        }
        $json_data = array(
            "draw"            => intval( $requestData['draw'] ),
            "recordsTotal"    => intval( $count ),
            "recordsFiltered" => intval( $totalData ),
            "data"            => $data );
        echo json_encode($json_data);
        $json_data=array();

    }catch(PDOException $ex){
        // echo $ex->getMessage();
        print_r($ex);
    }
?>
