<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="bcpms.Conn"%>
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
  <!-- Ionicons -->
  <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
  <!-- DataTables -->
  <link rel="stylesheet" href="../../dist/css/dataTables.bootstrap4.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="../../dist/css/adminlte.min.css">
  <!-- Google Font: Source Sans Pro -->
  <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700" rel="stylesheet">
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
            <h1>Coordinator List</h1>
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
              <h3 class="card-title">View List</h3>
            </div>
            <!-- /.card-header -->
            <div class="card-body">
            <div class="table-responsive">
              <table id="example1" class="table table-bordered table-striped">
                <thead>
                <tr>
                    <th>SNo</th>
                    <th>ID</th>
                    <th>Coordinator Name</th>
                    <th>Course</th>
                </tr>
                </thead>
                <tbody>
                <%
                        String id=(String)session.getAttribute("session_name");
                        if(id!=null)
                        {
                            PreparedStatement ps=new Conn().con.prepareStatement("select teacher_identity_card,first_name,last_name,subject from teacher where isCoordinator='1'");
                            ResultSet rs=ps.executeQuery();
                            int i=0;
                            String full_name;
                            while(rs.next())
                            {
                                i++;
                                full_name=rs.getString(2)+" "+rs.getString(3);
        %>
                            
                                <tr>
                                   <td><%out.println(i);%></td>
                                  <td><%out.println(rs.getString(1));%></td>
                                  <td><%out.println(full_name);%></td>
                                  <td><%out.println(rs.getString(4));%></td>
                               </tr>                               
                        <%}
                        }%>
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
    