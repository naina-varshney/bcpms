<%@page import="bcpms.Conn"%>
<%@ page import="java.sql.*"%>
<%@ page import="org.json.JSONObject"%>
<%@ page import="org.json.JSONArray"%>
<%@page errorPage="../../pages/commom/ErrorHandler.jsp" %>
<%
	String id=(String)session.getAttribute("user_session_key");
	if(id!=null)
	{
		String radio_selected=request.getParameter("radio");
		if(radio_selected.equals("Month"))
		{
			String month=request.getParameter("month");
			String year=request.getParameter("year");
			PreparedStatement ps=new Conn().con.prepareStatement("select attendance_details.Date,  attendance_details.Student_id, student_enrolment_details.Student_course_roll, student.first_name, student.Last_name, attendance_details.isPresent from attendance_details inner join student on attendance_details.student_id = student.student_identity_card inner join student_enrolment_details on attendance_details.student_id = student_enrolment_details.student_identity_card and ( month (attendance_details.Date)= ? and year(attendance_details.Date)=? ) order by attendance_details.student_id, attendance_details.Date asc;");
			ps.setString(1,month);
			ps.setString(2,year);
			ResultSet rs=ps.executeQuery();
			JSONArray responseArray=new JSONArray();
			while(rs.next())
			{
				JSONObject responseObject=new JSONObject();
				responseObject.put("Date",rs.getString(1));
				responseObject.put("Student_id",rs.getString(2));
				responseObject.put("Student_roll",rs.getString(3));
				responseObject.put("First_name",rs.getString(4));
				responseObject.put("Last_name",rs.getString(5));
				responseObject.put("Status",rs.getString(6));
				responseArray.put(responseObject);
			}
			response.getWriter().write(responseArray.toString());
			response.getWriter().close();
			ps.close();
			rs.close();
		}
	}

%>