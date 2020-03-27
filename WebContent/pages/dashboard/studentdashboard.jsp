<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="bcpms.Conn"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
	String sname = (String) session.getAttribute("user_session_key");
 //System.out.println("sname:"+sname);
	if (sname != null) {
		PreparedStatement ps = new Conn().con
				.prepareStatement("select first_name,last_name from student where student_identity_card=?");
		ps.setString(1, sname);
		ResultSet rs = ps.executeQuery();
		String fname, lname;
		if (rs.next()) {
			response.getWriter().write(rs.getString(1)+" "+rs.getString(2));
		}
		response.getWriter().close();
		ps.close();
		rs.close();
	} else {
		response.getWriter().write("invalid");
		response.getWriter().close();
	}
%>
