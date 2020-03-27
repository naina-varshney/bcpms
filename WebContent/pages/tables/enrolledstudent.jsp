

<%@page import="java.sql.PreparedStatement"%>
<%@page import="bcpms.Conn"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>BCPMS | CoordinatorList</title>
  <!-- Tell the browser to be responsive to screen width -->
  <meta name="viewport" content="width=device-width, initial-scale=1">

  <!-- Font Awesome -->
  <link rel="stylesheet" href="../../plugins/fontawesome-free/css/all.min.css">
  
  <!-- DataTables -->
  <link rel="stylesheet" href="../../dist/css/dataTables.bootstrap4.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="../../dist/css/adminlte.min.css">
  
  <style>
	.dataTables_filter {
    text-align: right;
	}
  </style>
</head>
<body class="hold-transition sidebar-mini">
<div class="wrapper">
  <!-- Navbar -->
  
        <!-- /.navbar -->
        <!-- Main Sidebar Container -->
         

    <!-- Content Header (Page header) -->
    <section class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1>Enrolled Students</h1>
          </div>
          
        </div>
      </div><!-- /.container-fluid -->
    </section>
    <!-- Main content -->
    <section class="content">
      <div class="row">
        <div class="col-12">
          <!-- /.card -->
          <div class="card">
            <div class="card-header">
              <h3 class="card-title">Enrolled Student List</h3>
            </div>
            <!-- /.card-header -->
            <div class="card-body">
            <div class="table-responsive">
              <table id="example1" class="table table-bordered table-striped">
                <thead>
                <tr>
                  <th>SNo.</th>
                  <th>Student ID</th>
                  
                  <th>Roll Number</th>
                  <th>Student Name</th>
                  <th>Course Name</th>
                  <th>Date</th>
                </tr>
                </thead>
                <tbody>
                    
                    <%
                        String id=(String)session.getAttribute("session_name");
                        if(id!=null)
                        {
                            PreparedStatement ps=new Conn().con.prepareStatement("");
                        }
                        
                        
                        
                        
                        
                        
                        %>
                 <tr>
                        <td>1</td>
                        <td>ABMCA12345</td>
                        <td>11</td>
                        <td>minu</td>
                       <td>.Net</td>
                      <td>13/12/2020</td>
                </tr>
                 <!--<tr>
		  <td>2</td>
                  <td>ABMCA14567</td>
                  
                  <td>12</td>
                  <td>khush</td>
		 <td>Android</td>
                <td>14/12/2020</td>
                </tr>
                 <tr>
		  <td>3</td>
                  <td>ABMCA13445</td>
                  
                  <td>13</td>
                  <td>garima</td>
		 <td>CCNA</td>
                <td>17/12/2020</td>
                </tr>
                -->	 
                </tbody>
              </table>
            </div>
            </div>
            <!-- /.card-body -->
          </div>
          <!-- /.card -->
        </div>
        <!-- /.col -->
      </div>
      <!-- /.row -->
    </section>
    <!-- /.content -->
  
  <!-- /.content-wrapper -->
  
  <!-- Control Sidebar -->
 
  <!-- /.control-sidebar -->
</div>
<!-- ./wrapper -->

<!-- jQuery -->
<script src="../../plugins/jquery/jquery.min.js"></script>
<!-- Bootstrap 4 -->
<script src="../../plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- DataTables -->
<script src="../../plugins/jquery/jquery.dataTables.js"></script>
<script src="../../plugins/bootstrap/js/dataTables.bootstrap4.js"></script>
<!-- AdminLTE App -->
<script src="../../dist/js/adminlte.min.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="../../dist/js/demo.js"></script>
<!-- page script -->
<script>
  $(function () {
    $("#example1").DataTable();
    $('#example2').DataTable({
      "paging": true,
      "lengthChange": false,
      "searching": false,
      "ordering": true,
      "info": true,
      "autoWidth": false,
    });
  });
</script>
</body>
</html>




