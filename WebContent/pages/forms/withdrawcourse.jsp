<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="bcpms.Conn" %>
<%@page errorPage="../../pages/commom/ErrorHandler.jsp" %>
<%
	String admin_id=(String)session.getAttribute("user_session_key");
	String flag=request.getParameter("run");
	if(admin_id!=null)
	{
		String student_id=request.getParameter("s_id");
		if(flag.equals("keypress"))
		{	
			PreparedStatement ps1=new Conn().con.prepareStatement("select name from course_details where course_id in (select course_id from student_enrolment_details where student_identity_card=?)");
			ps1.setString(1,student_id);
			ResultSet rs1=ps1.executeQuery();
			String c_name="";
			if(rs1.next())
			{
				c_name=rs1.getString(1);
				System.out.println("course_name:"+c_name);
			}
			response.getWriter().write(c_name);
			response.getWriter().close();
			ps1.close();
			rs1.close();
		}
		else if(flag.equals("Button"))
		{
			PreparedStatement ps=new Conn().con.prepareStatement("update student_enrolment_details set isEnabled=0 where student_identity_card=?");
			ps.setString(1,student_id);
			if(ps.executeUpdate()>0)
			{
				response.getWriter().write("done");
				response.getWriter().close();
			}
		}
		
	}
	else
	{
		response.getWriter().write("error");
		response.getWriter().close();
	}
%>