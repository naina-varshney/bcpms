<%@page import="java.sql.ResultSet"%>
<%@page import="bcpms.Conn"%> 
<%@page import="java.sql.PreparedStatement"%>
<%@page import= "java.sql.Connection"%>
<%@page import= "java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page errorPage="../../pages/commom/ErrorHandler.jsp" %>
<%
	String user_id = request.getParameter("user_id");
	String user_password = request.getParameter("user_password");
    session.setAttribute("user_session_key",user_id);
     
	if ((user_id.charAt(0) == 'A') && (user_id.charAt(1) == 'B'))
	{
		PreparedStatement ps = new Conn().con.prepareStatement("select student_identity_card,password from student where student_identity_card=? and password=?");
		ps.setString(1, user_id);
		ps.setString(2, user_password);
		ResultSet rs = ps.executeQuery();
		if (rs.next())
		{
			session.setAttribute("login_id", rs.getString(1));
			response.getWriter().write("../../pages/dashboard/studentdashboard.html");
		}
		else 
		{
			response.getWriter().write("unauthorized");
		}
		response.getWriter().close();
		ps.close();
		rs.close();
	} 
	else if (user_id.charAt(0) == 'T') 
	{
		PreparedStatement ps = new Conn().con.prepareStatement("select teacher_identity_card,password,iscoordinator from teacher where teacher_identity_card=? and password=?");
		ps.setString(1, user_id);
		ps.setString(2,user_password);
		ResultSet rs = ps.executeQuery();
		if (rs.next()) 
		{
			if (rs.getBoolean(3))
			{
				response.getWriter().write("../../pages/dashboard/coordinatordashboard.html");
			} 
			else
			{
				response.getWriter().write("../../pages/dashboard/teacherdashboard.html");
			}
		}
		else
		{
			response.getWriter().write("unauthorized");
		}
		response.getWriter().close();	
		ps.close();
		rs.close();
	} 
	else if (user_id.charAt(0) == 'A')
	{
		PreparedStatement ps = new Conn().con.prepareStatement("select username,password from administrator where username=? and password=?");
		ps.setString(1, user_id);
		ps.setString(2,user_password);
		ResultSet rs = ps.executeQuery();
		if(rs.next())
		{
			response.getWriter().write("../../pages/dashboard/admindashboard.html");
		} 
		else
		{
			response.getWriter().write("unauthorized");
		}
		response.getWriter().close();
		ps.close();
		rs.close();
	} 
	else
	{
		response.getWriter().write("unauthorized");
		response.getWriter().close();
	}
%>

