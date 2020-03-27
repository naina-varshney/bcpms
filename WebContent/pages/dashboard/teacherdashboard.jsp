

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="bcpms.Conn"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
	String tname = (String) session.getAttribute("user_session_key");
	//System.out.println("tname:"+tname);
	if (tname != null) {
		PreparedStatement ps = new Conn().con
				.prepareStatement("select first_name,last_name from teacher where teacher_identity_card=?");
		ps.setString(1, tname);
		ResultSet rs = ps.executeQuery();
		String fname="", lname="";
		if (rs.next()) {

			fname = rs.getString(1);
			lname = rs.getString(2);
			
		}
		response.getWriter().write(fname+" "+lname);
		response.getWriter().close();
		ps.close();
		rs.close();
	} else {
		response.getWriter().write("invalid");
		response.getWriter().close();
	}
%>
