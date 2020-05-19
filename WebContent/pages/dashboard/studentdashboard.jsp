<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="bcpms.Conn"%>
<%@page import="org.json.JSONObject" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page errorPage="../../pages/commom/ErrorHandler.jsp" %>
<%
	String sname = (String) session.getAttribute("user_session_key");
	if (sname != null)
	{
		PreparedStatement ps = new Conn().con.prepareStatement("select first_name, last_name, (select count(student_enrolment_details.Id) from student_enrolment_details where Student_Identity_card=? and isEnabled=1) as enrolled from student where Student_Identity_card=?");
		ps.setString(1, sname);
		ps.setString(2,sname);
		ResultSet rs = ps.executeQuery();
		JSONObject responseObject=new JSONObject();
		if (rs.next()) 
		{
			responseObject.put("user_name",rs.getString(1)+" "+rs.getString(2));
			responseObject.put("isEnrolled",rs.getInt(3));
			response.getWriter().write(responseObject.toString());
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
