<?php include("atas.php");?>
<!-- page content -->
        <div class="right_col" role="main">
          <div class="">
            <div class="page-title">
              <div class="title_left">
                <h3>Produk</h3>
              </div>
              <div class="title_right">
                <div class="col-md-5 col-sm-5 col-xs-12 form-group pull-right top_search">
                  <div class="input-group">
                    <input type="text" class="form-control" placeholder="Search for...">
                    <span class="input-group-btn">
                      <button class="btn btn-secondary" type="button">Go!</button>
                    </span>
                  </div>
                </div>
              </div>
            </div>
            <div class="clearfix"></div>
            <div class="row">
              <div class="col-md-12 col-sm-12 ">
              <?php 
                $id_parent_goods = $_GET['idpg'];
                $sql = "SELECT name FROM tb_goods WHERE id_goods = :id_goods";
                $query = $dbcon->prepare($sql);
                $query->bindParam("id_goods", $id_parent_goods, PDO::PARAM_STR);
                $query->execute();
                $rowintro = $query->fetch(PDO::FETCH_ASSOC);
                $name = $rowintro['name'];
              ?>
              <?php include("tambah.php");?>
                <div class="x_panel">
                  <div id="title" class="x_title">
                    <h2>Daftar Resep Barang <?php echo $name?></h2>
                    <ul class="nav navbar-right panel_toolbox">
                      <li class="collapse-link"><a><i class="fa fa-chevron-up"></i></a>
                      </li>
                    </ul>
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
                      <div class="row">
                          <div class="col-sm-12">
                            <div class="card-box table-responsive">
                            <div class="item form-group">
                              <label class="col-form-label col-md-9 col-sm-9 label-align">Status</label>
                              <div class="col-md-3 col-sm-3">
                                <div class="btn-group" id="filters" data-toggle="buttons">
                                  <label class="btn btn-secondary filter-y" data-toggle-class="btn-primary" data-toggle-passive-class="btn-default">
                                    <input type="radio" name="active" id="aktif_y" value="Y" class="join-btn"> &nbsp; Aktif &nbsp;
                                  </label>
                                  <label class="btn btn-primary filter-t" data-toggle-class="btn-primary" data-toggle-passive-class="btn-default">
                                    <input type="radio" name="active" id="aktif_t" value="T" class="join-btn"> Tidak Aktif
                                  </label>
                                </div>
                              </div>
                            </div>
                    <table id="products" class="table table-striped table-bordered" style="width:100%">
                      <thead>
                        <tr>
                          <th>No</th>
                          <th>Barang</th>
                          <th>Kuantitas</th>
                          <th>Biaya</th>
                          <th class="noExport">Opsi</th>
                        </tr>
                      </thead>
                      <tbody>
                      </tbody>
                      <tfoot>
                        <tr>
                          <th colspan="3" style="text-align:right">Total Cost :</th>
                          <th></th>
                          <th></th>
                        </tr>
                      </tfoot>
                    </table>
                  </div>
                </div>
              </div>
            </div>
                </div>
              </div>
            </div>
          </div>
        </div>
<?php include("bawah.php");?>
<script>

  $('#id_goods').change(function(event){
    var val = $('#id_goods').val();
    if(val != ""){
      var unit = $('#id_goods').find(':selected').data('unit').toString();
      var price = $('#id_goods').find(':selected').data('price');
      var uquantity = $('#id_goods').find(':selected').data('uquantity');
      $('#v-unit').html('* Satuan Barang adalah <b>'+unit+'</b>');
      $('#price').val('Rp '+formatRupiah(price.toString()));
      getCost();
    }else{
      $('#v-unit').text('* Satuan Barang');
    }
  });

  $('#quantity').change(function(event){
    getCost();
  });

  function getCost(){
    var price = $('#id_goods').find(':selected').data('price');
    var uquantity = $('#id_goods').find(':selected').data('uquantity');
    var quantity = $('#quantity').val();
    var cost = (price/uquantity)*quantity;

    $('#cost').val('Rp '+formatRupiah(cost.toString()));
  }

  var table_products;
  initTable();
  function initTable(){
    var filename = $("#title").find('h2').text();
    console.log(filename);
    var id_parent_goods = $("#id_parent_goods").val();
    table_products = $("#products").DataTable({
        "paging": true,
        "processing": true,
        "serverSide": true,
        "lengthMenu": [[10, 20, 50, null], [10, 20, 50, "Semua"]],
        "ajax" : {
          url  : "goods/receipt/get_receipt.php",
          type : "post",
          data :{id_parent_goods:id_parent_goods}
        },
        dom: "<'row'<'col-4'l><'col-4'f><'col-4 text-right'B>><'row'<'col-sm-12'tr>><'row'<'col-sm-12'ip>>",
        "footerCallback": function ( row, data, start, end, display ) {
            var api = this.api(), data;
            // Remove the formatting to get integer data for summation
            var intVal = function ( i ) {
                return typeof i === 'string' ?
                    i.replace(/[\Rp.]/g, '')*1 :
                    typeof i === 'number' ?
                        i : 0;
            };
            // Total over all pages
            total = api
                .column( 3 )
                .data()
                .reduce( function (a, b) {
                console.log(intVal(b))
                    return intVal(a) + intVal(b);
                }, 0 );

            // Update footer
            $( api.column( 3 ).footer() ).html('Rp ' + formatRupiah(total.toString()));
        },
        buttons:  [{
                extend: 'pdfHtml5',
                title: filename,
                footer: true,
                exportOptions: {
                    columns: "thead th:not(.noExport)"
                }
            },{
                extend: 'excelHtml5',
                title: filename,
                footer: true,
                exportOptions: {
                    columns: "thead th:not(.noExport)"
                }
            }, {
                extend: 'csvHtml5',
                title: filename,
                footer: true,
                exportOptions: {
                    columns: "thead th:not(.noExport)"
                }
            }
        ]
    });
  }
  
</script>
        <!-- /page content -->
