

<%@page contentType="text/html" pageEncoding="UTF-8"%>


<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="bcpms.Conn"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>BCPMS | Security Question</title>
        <!-- Tell the browser to be responsive to screen width -->
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!-- Font Awesome -->
        <link rel="stylesheet" href="../../plugins/fontawesome-free/css/all.min.css">

        <!-- icheck bootstrap -->
        <link rel="stylesheet" href="../../plugins/icheck-bootstrap/icheck-bootstrap.min.css">
        <!-- Theme style -->
        <link rel="stylesheet" href="../../dist/css/adminlte.min.css">
        <style>

            .login-page
            {

                background-image: url("../../dist/img/123.jpg");

                background-repeat: no-repeat;
                background-size: cover;

            }
            .card
            {
                box-shadow: 0 0 1px rgba(0,0,0,.125), 1px 0px 100px 100px rgba(0,0,0,.2);

                background-color: transparent;

            }
            .form-control
            {
                background-color: transparent;
                color:black;
            }

            .login-card-body
            {
                background: transparent;
                color: #212529;
            }
            .input-group
            {
                background-color: #fff;
            }
        </style>
    </head>

    <body class="hold-transition login-page">
        <div class="login-box">

            <!-- /.login-logo -->
            <div class="card">
                <div class="card-body login-card-body">
                    <p class="login-box-msg"><b>Security Question</b></p>
                    <form  action="registration.jsp" method="post">
                        <div class="input-group mb-3">
                            <input type="text" class="form-control" id="id1" name="register_id" placeholder="Enter ID*" requires>

                        </div>

                        <div class="input-group mb-3">
                            <label>Select your security question</label>
                            <select class="form-control select2bs4" name="security_ques" id="security" style="width: 100%;" required>
                                <option selected="selected">Selected*</option>
                                <option>What is your favourite pet?</option>
                                <option>What is your hobby?</option>
                                <option>What is your grandfather's occupation?</option>

                            </select>
                        </div>
                        <div class="input-group mb-3">
                            <input type="text" class="form-control" id="securityanswer" name="security_ans" placeholder="Your security answer*" required>

                        </div>

                        <div class="row">
                            <div class="col-12">
                                <button type="submit" id="btn1" class="btn btn-primary btn-block">Change password</button>
                                <%
                                    String id = request.getParameter("register_id");
                                    String ques = request.getParameter("security_ques");
                                    String ans = request.getParameter("security_ans");
                                    if (id != null && ques != null && ans != null) {

                                        session.setAttribute("session_id", id);

                                        if ((id.charAt(0) == 'A') && (id.charAt(1) == 'B')) {

                                            PreparedStatement ps = new Conn().con.prepareStatement("insert into student values() ");
                                            ps.setString(1, id);
                                            ps.setString(2, ques);
                                            ps.setString(3, ans);
                                            ResultSet rs = ps.executeQuery();
                                            if (rs.next()) {
                                                response.sendRedirect("../../pages/forms/registration_form.jsp");
                                            }

                                            ps.close();
                                            rs.close();
                                        } else if ((id.charAt(0) == 'T')) {
                                            PreparedStatement ps = new Conn().con.prepareStatement("select teacher_identity_card,security_question,security_answer from teacher where teacher_identity_card=? and security_question=? and security_answer=?");
                                            ps.setString(1, id);
                                            ps.setString(2, ques);
                                            ps.setString(3, ans);
                                            ResultSet rs = ps.executeQuery();
                                            if (rs.next()) {
                                                response.sendRedirect("../../pages/forms/teacherreg.jsp");
                                            }

                                            ps.close();
                                            rs.close();
                                        } 
                                    }
                                        else {
                                            response.sendRedirect("../../pages/forms/security.jsp");
                                        }
                                %>
                            </div>
                            <!-- /.col -->
                        </div>
                    </form>

                    <p class="mt-3 mb-1">
                        <a href="login.html">Login</a>
                    </p>
                </div>
                <!-- /.login-card-body -->
            </div>
        </div>
        <!-- /.login-box -->

        <!-- jQuery -->
        <script src="../../plugins/jquery/jquery.min.js"></script>
        <!-- Bootstrap 4 -->
        <script src="../../plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
        <!-- AdminLTE App -->
        <script src="../../dist/js/adminlte.min.js"></script>

    </body>

</html>