<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="bcpms.Conn" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="org.json.JSONArray" %>
<%@page errorPage="../../pages/commom/ErrorHandler.jsp" %>
<%
	String admin_id=(String)session.getAttribute("user_session_key");
	String execute=request.getParameter("run");
	if(admin_id!=null)
	{
		if(execute.equals("load"))
		{
			PreparedStatement ps=new Conn().con.prepareStatement("select name from course_details");
			ResultSet rs=ps.executeQuery();
			JSONArray responseArray=new JSONArray();
			while(rs.next())
			{
				JSONObject responseObject=new JSONObject();
				responseObject.put("course_name",rs.getString(1));
				responseArray.put(responseObject);
			}
			response.getWriter().write(responseArray.toString());
			response.getWriter().close();
			ps.close();
			rs.close();
		}
		else if(execute.equals("keypress"))
		{
			String student_id=request.getParameter("s_id");
			PreparedStatement ps1=new Conn().con.prepareStatement("select name from course_details where course_id in (select course_id from student_enrolment_details where student_identity_card=?)");
			ps1.setString(1,student_id);
			ResultSet rs1=ps1.executeQuery();
			String c_name="";
			if(rs1.next())
			{
				c_name=rs1.getString(1);
			}
			response.getWriter().write(c_name);
			response.getWriter().close();
			ps1.close();
			rs1.close();	
		}
		else if(execute.equals("s_switch"))
		{
			String new_course=request.getParameter("selectedCourse");
			String student_id=request.getParameter("s_id");
			PreparedStatement ps3=new Conn().con.prepareStatement("update student_enrolment_details set course_id=(select course_id from course_details where name=?) where student_identity_card=?");
			ps3.setString(1,new_course);
			ps3.setString(2,student_id);
			if(ps3.executeUpdate()>0)
			{
				response.getWriter().write("updated");
				response.getWriter().close();
			}
			else
			{
				response.getWriter().write("error");
				response.getWriter().close();
			}
		}
	}
	else
	{
		response.getWriter().write("invalid");
		response.getWriter().close();
	}
%>