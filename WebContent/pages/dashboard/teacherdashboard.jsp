<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="bcpms.Conn"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page errorPage="../../pages/commom/ErrorHandler.jsp" %>
<%
	String tname = (String) session.getAttribute("user_session_key");
	if (tname != null) 
	{
		PreparedStatement ps = new Conn().con.prepareStatement("select first_name,last_name from teacher where teacher_identity_card=?");
		ps.setString(1, tname);
		ResultSet rs = ps.executeQuery();
		if (rs.next())
		{
			response.getWriter().write(rs.getString(1)+" "+rs.getString(2));
		}
		response.getWriter().close();
		ps.close();
		rs.close();
	}
	else 
	{
		response.getWriter().write("invalid");
		response.getWriter().close();
	}
%>
