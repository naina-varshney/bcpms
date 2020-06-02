<%@page import="org.json.JSONArray" %>
<%@page import="org.json.JSONObject" %>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="bcpms.Conn"%>
<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@page errorPage="../../pages/commom/ErrorHandler.jsp" %>
<%
	String id = request.getParameter("session_name");
	String run_type=request.getParameter("execute");
    int n_student=0,n_teacher=0,n_course=0,n_courseType=0;
	if (id != null) 
	{
		if(run_type.equals("header"))
		{
			PreparedStatement ps = new Conn().con.prepareStatement("select count(*) from student_enrolment_details");
			ResultSet rs = ps.executeQuery();
			if (rs.next()) 
			{
				n_student = rs.getInt(1);
			}
			ps.close();
			rs.close();
			PreparedStatement ps1 = new Conn().con.prepareStatement("select count(*) from teacher");
			ResultSet rs1 = ps1.executeQuery();
			if (rs1.next()) 
			{
				n_teacher = rs1.getInt(1);
			}
			ps1.close();
			rs1.close();
			PreparedStatement ps2 = new Conn().con.prepareStatement("select count(*) from course_type");
			ResultSet rs2 = ps2.executeQuery();
			if (rs2.next()) 
			{
				n_courseType=rs2.getInt(1);
			}
			ps2.close();
			rs2.close();
			PreparedStatement ps3 = new Conn().con.prepareStatement("select count(*) from course_details");
			ResultSet rs3 = ps3.executeQuery();
			if (rs3.next()) 
			{
				n_course = rs3.getInt(1);
			}
			ps3.close();
			rs3.close();
			JSONObject count=new JSONObject();
			count.put("n_student",n_student);
			count.put("n_teacher",n_teacher);
			count.put("n_course",n_course);
			count.put("n_courseType",n_courseType);
			response.getWriter().write(count.toString());
			response.getWriter().close();
		}
		
		else if(run_type.equals("content"))
		{
			PreparedStatement ps=new Conn().con.prepareStatement("select image_name,path,purpose,image_heading from images where purpose='admin'");
			ResultSet rs=ps.executeQuery();
			JSONArray responseArray=new JSONArray();
			while(rs.next()){
				JSONObject responseObject=new JSONObject();
				responseObject.put("img_name",rs.getString(1));
				responseObject.put("path",rs.getString(2));
				responseObject.put("purpose",rs.getString(3));
				responseObject.put("heading",rs.getString(4));
				responseArray.put(responseObject);	
			}
			response.getWriter().write(responseArray.toString());
			response.getWriter().close();
			ps.close();
			rs.close();
		}
	}
	else
	{
		response.getWriter().write("unauthorized");
		response.getWriter().close();
	}
%>
