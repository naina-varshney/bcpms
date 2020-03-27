

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="bcpms.Conn"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>BCPMS | Certificate Course</title>
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
	.far {
		font-weight: 400;
		margin-right: 20px;
}
  </style>
</head>
<body class="hold-transition sidebar-mini">
<div class="wrapper">
  <!-- Navbar -->
   
        <!-- /.navbar -->
        <!-- Main Sidebar Container -->

  <!-- Content Wrapper. Contains page content -->
  
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1>Certificate Courses</h1>
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
              <h3 class="card-title"> Course List</h3>
            </div>
            <!-- /.card-header -->
            <div class="card-body">
			
            <div class="table-responsive">
              <table id="example2" class="table table-bordered table-striped">
                <thead>
                <tr>
                  <th>SNo</th>
				  
				  <th>Certificate Courses</th>
				  <th>Duration</th>
                                  <th>Course Fees</th>
				  <th>Action</th>
                </tr>
                </thead>
                <tbody>
                    <%
                        String id=(String)session.getAttribute("session_name");
                        int i=0;
                        if(id!=null)
                        {
                            PreparedStatement ps=new Conn().con.prepareStatement("select name,duration,fee from course_details where type='certificate'or type='Certificate' ");
                            ResultSet rs=ps.executeQuery();
                            while(rs.next())
                            {    i++;
                    %>
                                <tr>
                                    <td><%out.println(i);%></td>
                                    <td><%out.println(rs.getString(1));%></td>
                                    <td><%out.println(rs.getString(2));%></td>
                                    <td><%out.println(rs.getString(3));%></td>
                                    <td><i class="far fa-edit"></i>
                                    <i class="fas fa-trash-alt"></i></td>
                              </tr>
                 <%         }
                        }
                           
                    %>	 
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
      "autoWidth": true,
    });
  });
</script>
</body>
</html>

