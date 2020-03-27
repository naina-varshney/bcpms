

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="bcpms.Conn"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
	String sname = (String) session.getAttribute("user_session_key");
	if (sname != null) {
		PreparedStatement ps = new Conn().con
				.prepareStatement("select first_name,last_name from teacher where teacher_identity_card=? and isCoordinator=1");
		ps.setString(1, sname);
		ResultSet rs = ps.executeQuery();
		String fname="", lname="";
		if (rs.next()) {
			fname = rs.getString(1);
			lname = rs.getString(2);
			//out.println(fname + " " + lname);
		}
		response.getWriter().write(fname+" "+lname);
		response.getWriter().close();
		ps.close();
		rs.close();
	} else {
		//response.sendRedirect("../../pages/forms/login.jsp");
		response.getWriter().write("invalid");
		response.getWriter().close();
	}
%>
