<?
$this->load->view(ADMIN_HEADER);
?>
<link rel="stylesheet" href="<?=base_url()?>assets/css/easyui.css" type="text/css" />
<link rel="stylesheet" href="<?=base_url()?>assets/css/icon.css" type="text/css" />
<link rel="stylesheet" href="<?=base_url()?>assets/css/demo.css" type="text/css" />

<!--script language="javascript" src="<?=base_url()?>assets/js/jquery-1.7.2.min.js"></script-->
<script language="javascript" src="<?=base_url()?>assets/js/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<?=base_url()?>assets/js/jquery.edatagrid.js"></script>
<script language="javascript" src="<?=base_url()?>assets/js/calendar.js"></script>
<script language="javascript" src="<?=base_url()?>assets/js/calendar2.js"></script>

<script type="text/javascript">
$(function(){
            $.fn.datebox.defaults.formatter = function(date) {
                        var y = date.getFullYear();
                        var m = date.getMonth() + 1;
                        var d = date.getDate();
                        return (d < 10 ? '0' + d : d) + '-' + (m < 10 ? '0' + m : m) + '-' + y;
            };
		$('#tgl').datebox({  
        required:true  
    });  
         
    
    
		
            //FUNGSI LOAD DATA
           $('input:checkbox').change(function(){
                        if($("input:checkbox:checked").val()== 1) {
                                    
                                 $('#vendor').hide();
                                //setTimeout('location.reload(true);',1);
								//$('#check').val(1);
                                  // $('#trxtype').empty();
                                  //$('#trxtype').append('<option></option>'); 
                                   
                                   
                             }else {
			//					 setTimeout('location.reload(true);',1);
								  $('#vendor').show();}
               
   });
   
   

    
    
      
 });
 
</script>
<h2><font color='red' size='4'>Payment Recapitulation Per Vendor<hr width="150px" align="left"></font></h2>
<form method="post" action="<?=base_url()?>ap/cetakaprecap_call/cetakaprecap" target="_blank">
<table>
	<tr id="vendor">
		<td>Vendor Nm.</td>
		<td><select name="vendor" style="width:120px">
		<option></option>
		<?php foreach($vendor as $row):?>
		<option value="<?=@$row->kd_supp_gb?>"><?=@$row->nm_supp_gb?></option>
		<?endforeach;?>
		
		</select></td>
	</tr>
	
	
	<tr>
		<td>As Off   : </td>
		<td><input type="text" name="tgl" id="tgl" class="required" style="width:120px"></td>
		
	</tr>
	
	
	
	<tr>
		<td>&nbsp;</td>
		<td><input type="submit" name="klik" id="klik" value="Print"/>
		<input type="submit" name="klik" id="klik" value="Print to Excel"/></td>
	</tr>
	
</table>
</form>

<?
$this->load->view(ADMIN_FOOTER);
?>
