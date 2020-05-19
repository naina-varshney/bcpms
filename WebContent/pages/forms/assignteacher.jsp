<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="bcpms.Conn" %>
<%@page errorPage="../../pages/commom/ErrorHandler.jsp" %>
<%

	String id=(String)session.getAttribute("user_session_key");
	String execute=request.getParameter("run");
	if(id!=null)
	{
		String teacher_id=request.getParameter("t_id");
		if(execute.equals("keypress"))
		{
			PreparedStatement ps=new Conn().con.prepareStatement("select first_name,last_name from teacher where teacher_identity_card=?");
			ps.setString(1,teacher_id);
			ResultSet rs=ps.executeQuery();
			if(rs.next())
			{
				response.getWriter().write(rs.getString(1)+" "+rs.getString(2));	
			}
			response.getWriter().close();
			ps.close();
			rs.close();
		}
		else if(execute.equals("button"))
		{
			String selectedCourse=request.getParameter("selected_course");
			PreparedStatement ps1=new Conn().con.prepareStatement("select course_id from course_details where name=?");
			ps1.setString(1,selectedCourse);
			ResultSet rs=ps1.executeQuery();
			String c_id="";
			if(rs.next())
			{
				c_id=rs.getString(1);
		    }
			PreparedStatement ps=new Conn().con.prepareStatement("insert into course_assigned_details(course_id,teacher_id,assigned_by_id) values(?,?,?)");
			ps.setString(1,c_id);
			ps.setString(2,teacher_id);
			ps.setString(3,id);
			if(ps.executeUpdate()>0)
			{
				response.getWriter().write("inserted");		
			}
			response.getWriter().close();
			ps1.close();
			ps.close();
			rs.close();
			
		}
		else
		{
			response.getWriter().write("invalid");
			response.getWriter().close();
		}
	}
	else
	{
		response.getWriter().write("invalid");
		response.getWriter().close();
	}
%>