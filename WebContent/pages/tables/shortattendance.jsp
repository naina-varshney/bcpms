<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="bcpms.Conn" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="org.json.JSONArray" %>
<%
	String id=(String)session.getAttribute("user_session_key");
	if(id!=null)
	{
		if(id.charAt(0)=='T')
		{
			String course_name=request.getParameter("course_name");
			String course_nature=Character.toString(request.getParameter("course_type").charAt(0));
			String attendance_year=request.getParameter("year");
			PreparedStatement ps=new Conn().con.prepareStatement("select attendance_details.student_id,student.first_name,student.last_name,course_details.Name,sum(JSON_LENGTH(JSON_KEYS(attendance))) as Total_class,sum(JSON_LENGTH(JSON_SEARCH(attendance,'all','P'))) as Present_Count from attendance_details inner join course_details on course_details.Course_Id=attendance_details.Course_Id and course_details.name=? and attendance_year=? and course_nature=? inner join student on attendance_details.student_id=student.student_identity_card group by attendance_details.student_id ;");
			ps.setString(1,course_name);
			ps.setString(2,attendance_year);
			ps.setString(3,course_nature);
			ResultSet rs=ps.executeQuery();
			JSONArray responseArray=new JSONArray();
			while(rs.next())
			{
				JSONObject responseObject=new JSONObject();
				responseObject.put("student_id",rs.getString(1));
				responseObject.put("student_name",rs.getString(2)+" "+rs.getString(3));
				responseObject.put("course_name",rs.getString(4));
				responseObject.put("total_class",rs.getString(5));
				responseObject.put("attended_class",rs.getString(6));
				responseArray.put(responseObject);
				
			}
			response.getWriter().write(responseArray.toString());
			response.getWriter().close();
			ps.close();
			rs.close();
		}
		else if(id.charAt(0)=='A')
		{
			
			String course_nature=Character.toString(request.getParameter("course_nature").charAt(0));
			PreparedStatement ps=new Conn().con.prepareStatement("select student_enrolment_details.student_identity_card,student.first_name,student.last_name,course_details.name,sum(JSON_LENGTH(JSON_KEYS(attendance))) as Total_Class,sum(JSON_LENGTH(JSON_SEARCH(attendance,'all','P'))) as Attended_Class from student_enrolment_details inner join attendance_details on student_enrolment_details.student_identity_card=? and student_enrolment_details.student_identity_card=attendance_details.student_id and attendance_details.course_nature=? and student_enrolment_details.isEnabled=1 and extract(year from student_enrolment_details.date)=(select attendance_year from attendance_details group by attendance_year)inner join student on student.student_identity_card=student_enrolment_details.Student_Identity_card inner join course_details on student_enrolment_details.course_id=course_details.Course_Id group by attendance_details.student_id;");
			ps.setString(1,id);
			ps.setString(2,course_nature);
			ResultSet rs=ps.executeQuery();
			JSONArray responseArray=new JSONArray();
			if(rs.next())
			{
				JSONObject responseObject=new JSONObject();
				responseObject.put("student_id",rs.getString(1));
				responseObject.put("student_name",rs.getString(2)+" "+rs.getString(3));
				responseObject.put("course_name",rs.getString(4));
				responseObject.put("total_class",rs.getString(5));
				responseObject.put("attended_class",rs.getString(6));
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
		response.getWriter().write("invalid user");
		response.getWriter().close();
	}
%>