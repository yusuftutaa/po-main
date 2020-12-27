<div class="x_panel">
						<div class="x_title">
							<h2>Form Fix Price</h2>
							<ul class="nav navbar-right panel_toolbox">
								<li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
								</li>
							</ul>
							<div class="clearfix"></div>
						</div>
						<div class="x_content">
            <?php
              $action = "";
              if(isset($_GET['s'])){
                $action = $_GET['s'];
              }
              $id_fix_price = "";
              if($action == "edit"){
                $id_fix_price = $_GET['idfp'];
              }

              if($id_fix_price <> ""){
                $sql = "SELECT g.id_goods, f.id_fix_price, f.active, f.fixed_price, g.price_estimate
								FROM tb_fix_price f
								JOIN tb_goods g ON g.id_goods = f.id_goods
								WHERE f.id_fix_price=:id_fix_price";
                $query = $dbcon->prepare($sql);
								$query->bindParam('id_fix_price', $id_fix_price, PDO::PARAM_INT);
                $query->execute();
                $row = $query->fetch(PDO::FETCH_ASSOC);
								$fixed_price = "Rp " . number_format($row['fixed_price'], 0, ',', '.');
								$id_fix_price = $row['id_fix_price'];
                $id_goods = $row['id_goods'];
								$aktif = $row['active'];
								$price_estimate = $row['price_estimate'];
              }else{
                $id_goods = "";
								$aktif = "";
								$fixed_price = "";
              }
            ?>
									<br />
									<form method="POST" action="?m=fix_price&s=simpan" id="demo-form2" data-parsley-validate class="form-horizontal form-label-left">
										<div class="form-row">
											<div class="form-group col-md-4 pl-4">
												<label  for="fix_price">Fix Price <span class="required">*</span>
												</label>
												<select class="form-control" id="goods" required name="id_goods">
													<option value=''>Pilih Barang</option>
													<?php
														$sql = "SELECT * FROM tb_goods WHERE active='Y'";
														$query = $dbcon->prepare($sql);
														$query->execute();
														while($row = $query->fetch(PDO::FETCH_ASSOC)){
															$selected = $row['id_goods'] == $id_goods ? "selected" : "";
															echo "<option $selected value='".$row['id_goods']."'>$row[name]</option>";
														}
													?>
												</select>
											</div>
											<div class="form-group col-md-4 pl-4">
												<label  for="goods">Riwayat Harga <span class="required">*</span>
												</label>
												<input type="text" id="fixed_price" name="fixed_price" value="<?php echo $fixed_price?>" required="required" class="form-control ">

											</div>
										</div>
										<div class="form-row">
											<div class="form-group col-md-4 pl-4">
												<label >Status <span class="required">*</label>
												<div class="pt-3">
													<p>
													Aktif <input type="radio" class="flat" name="aktif" <?php echo $aktif == "Y" ? "checked" : ""; ?> id="aktify" value="Y"  required /> &nbsp;
													Tidak Aktif <input type="radio" class="flat" <?php echo $aktif == "T" ? "checked" : ""; ?> name="aktif" id="aktifx" value="T" />
													</p>
												</div>
											</div>
										</div>
										<div class="ln_solid"></div>
										<div class="item form-group">
											<div class="col-md-6 col-sm-6 offset-md-9">
                        						<button class="btn btn-primary" type="reset">Reset</button>
												<input type="hidden" id="id_fix_price" name="id_fix_price" value="<?php echo $id_fix_price;?>"/>
												<button type="submit" name="simpan" class="btn btn-success">Submit</button>
											</div>
										</div>

									</form>
								</div>
					</div>
