<?php
    include('../fungsi/connection.php');
    setlocale (LC_TIME, 'id_ID');
    try{
        $requestData = $_REQUEST;
        $searchValue = $requestData['search']['value'];
        $limit = $requestData['start'];
        $offset = $requestData['length'];
        $sqlGroup = "";
        $sql = "SELECT f.*, g.name FROM tb_fix_price f
        JOIN tb_goods g ON g.id_goods = f.id_goods";
        $searchArray = array();
        $searchQuery = "";
        if($searchValue != ""){
            $searchQuery= " and g.name LIKE :goods";
            $searchArray = array(
                'goods'=>"%$searchValue%"
           );
        }


        $query=$dbcon->prepare($sql.$sqlGroup);
        $query->bindParam("idpr", $idpr, PDO::PARAM_STR);
        $query->execute();
        $count = $query->rowCount();

        $sqlFilter = $sql.$searchQuery;
        $query=$dbcon->prepare($sqlFilter);

        foreach($searchArray as $key=>$search){
            $query->bindParam(''.$key, $search, PDO::PARAM_STR);
        }
        $query->execute();
        $totalData = $query->rowCount();

        $offsetQuery = "";
        if($offset > 0){
            $offsetQuery = "LIMIT :limit, :offset";
        }
        $sqlFetch = $sql.$searchQuery.$sqlGroup." ORDER BY f.created DESC, g.name ASC ".$offsetQuery;
        $query=$dbcon->prepare($sqlFetch);

        foreach($searchArray as $key=>$search){
            $query->bindParam(''.$key, $search, PDO::PARAM_STR);
        }
        if($offset > 0){
            $query->bindParam("limit", $limit, PDO::PARAM_INT);
            $query->bindParam("offset", $offset, PDO::PARAM_INT);
        }
        $query->execute();
        $data = array();
        $no = 0;
        while($r = $query->fetch(PDO::FETCH_ASSOC)){
            $disabled = 'onclick="return false;"';
            $arr = array();
            $no++;
            $arr[] = $no;
            $arr[] = $r['name'];
            $arr[] = "Rp " . number_format($r['fixed_price'], 0, ',', '.');
            $arr[] = $r['created'];
            $arr[] = '<center><a href="index.php?m=fix_price&s=edit&idfp='.$r['id_fix_price'].'"><i class="fa fa-edit fa-2x"></i></a> | <a href="index.php?m=fix_price&s=hapus&idfp='.$r['id_fix_price'].'" onclick="return confirm(\'Yakin akan dinonaktifkan?\')"><i class="fa fa-trash fa-2x"></i></a><center>';
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
