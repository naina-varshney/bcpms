
<%@page import="org.json.JSONObject" %>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="bcpms.Conn"%>
<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%
	String id = request.getParameter("session_name");
	//System.out.println("id="+id);
    int n_student=0,n_teacher=0,n_course=0,n_courseType=0;
	if (id != null) {
		PreparedStatement ps = new Conn().con.prepareStatement("select count(*) from student_enrolment_details");
		ResultSet rs = ps.executeQuery();
		if (rs.next()) {
			n_student = rs.getInt(1);
			//out.println(c - 1);
		}
		ps.close();
		rs.close();
	

	
		PreparedStatement ps1 = new Conn().con.prepareStatement("select count(*) from teacher");
		ResultSet rs1 = ps1.executeQuery();
		if (rs1.next()) {
			n_teacher = rs1.getInt(1);
		//	out.println(c - 1);
		}
		ps1.close();
		rs1.close();
	
		PreparedStatement ps2 = new Conn().con.prepareStatement("select count(*) from course_type");
		ResultSet rs2 = ps2.executeQuery();
		if (rs2.next()) {

			n_courseType=rs2.getInt(1);
			//out.println(rs.getInt(1));
		}
		ps2.close();
		rs2.close();
	
		PreparedStatement ps3 = new Conn().con.prepareStatement("select count(*) from course_details");
		ResultSet rs3 = ps3.executeQuery();
		if (rs3.next()) {
			n_course = rs3.getInt(1);
			//out.println(c - 1);
		}
		ps3.close();
		rs3.close();
		//System.out.println(n_student+" "+n_teacher+" "+n_course+" "+n_courseType);
		JSONObject count=new JSONObject();
		count.put("n_student",n_student);
		count.put("n_teacher",n_teacher);
		count.put("n_course",n_course);
		count.put("n_courseType",n_courseType);
		response.getWriter().write(count.toString());
		response.getWriter().close();
	}
	else
	{
		response.getWriter().write("unauthorized");
		response.getWriter().close();
	}
%>
