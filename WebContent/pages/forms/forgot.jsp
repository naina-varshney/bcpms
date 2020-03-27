
<%@page import="java.sql.PreparedStatement"%>
<%@page import="bcpms.Conn"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
	String n_pass = request.getParameter("new_pass");
	String c_pass = request.getParameter("confirm_pass");
	String id = request.getParameter("session_id");
	
	if (n_pass.equals(c_pass)) {
		if ((id.charAt(0) == 'A') && (id.charAt(1) == 'B')) {
			
			PreparedStatement ps = new Conn().con.prepareStatement("update student set password=? where student_identity_card=?");
			ps.setString(1, n_pass);
			ps.setString(2, id);
			if (ps.executeUpdate() > 0) {

				response.getWriter().write("../../pages/forms/login.html");
			}
		} else if (id.charAt(0) == 'T') {
			PreparedStatement ps = new Conn().con
					.prepareStatement("update teacher set password=? where teacher_identity_card=?");
			ps.setString(1, n_pass);
			ps.setString(2, id);
			if (ps.executeUpdate() > 0) {

				response.getWriter().write("../../pages/forms/login.html");
			}
		}
		response.getWriter().close();
	} 
	else {
		response.getWriter().write("unauthorized");
		response.getWriter().close();
	}
%>
