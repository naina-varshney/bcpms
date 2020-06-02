<%@page import="bcpms.Conn"%>
<%@ page import="java.sql.*"%>
<%@ page import="org.json.JSONObject"%>
<%@ page import="org.json.JSONArray"%>
<%@page errorPage="../../pages/commom/ErrorHandler.jsp" %>
<%
	String id=(String)session.getAttribute("user_session_key");
	if(id!=null)
	{	
		String month="0"+(String)session.getAttribute("selected_month");
		String year=(String)session.getAttribute("selected_year");
		String course_name=(String)session.getAttribute("attendance_course");
		String course_nature=(String)session.getAttribute("course_nature");
		
		PreparedStatement ps=new Conn().con.prepareStatement("select student_enrolment_details.student_course_roll,student.Student_Identity_card,student.first_name,student.last_name,attendance_details.attendance as attendance from student_enrolment_details inner join student on student.student_identity_card=student_enrolment_details.student_identity_card inner join course_details on course_details.name=? and course_details.Course_Id=student_enrolment_details.Course_Id inner join attendance_details on student_enrolment_details.Student_identity_card=attendance_details.Student_id and attendance_details.attendance_month=? and attendance_details.attendance_year=? and attendance_details.course_nature=?;");
		ps.setString(1,course_name);
		ps.setString(2,month);
		ps.setString(3,year);
		ps.setString(4,course_nature);
		ResultSet rs=ps.executeQuery();
		JSONArray responseArray=new JSONArray();
		while(rs.next())
		{
			JSONObject responseObject=new JSONObject();
			responseObject.put("Student_roll",rs.getString(1));
			responseObject.put("Student_id",rs.getString(2));
			responseObject.put("Student_name",rs.getString(3)+" "+rs.getString(4));
			responseObject.put("attendance_status",rs.getString(5));
			responseArray.put(responseObject);
		}
		response.getWriter().write(responseArray.toString());
		response.getWriter().close();
		ps.close();
		rs.close();
	}
%>