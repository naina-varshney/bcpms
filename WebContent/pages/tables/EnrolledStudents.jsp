<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="bcpms.Conn" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONObject" %>
<%@page errorPage="../../pages/commom/ErrorHandler.jsp" %>
<%
String id=(String)session.getAttribute("user_session_key");
//System.out.println("id="+id);
if(id!=null)
{
	PreparedStatement ps=new Conn().con.prepareStatement("select student_identity_card,course_id,student_course_roll,isEnabled,date from student_enrolment_details where isEnabled=1"); 
	ResultSet rs=ps.executeQuery();
	JSONArray responseArray=new JSONArray();
	while(rs.next())
	{
	    PreparedStatement ps1=new Conn().con.prepareStatement("select first_name,last_name from student where student_identity_card=?");
		ps1.setString(1,rs.getString(1));
		ResultSet rs1=ps1.executeQuery();
		String fullname="";
		if(rs1.next())
		{
			fullname=rs1.getString(1)+" "+rs1.getString(2);
		}
		PreparedStatement ps2=new Conn().con.prepareStatement("select name from course_details where course_id=?");
		ps2.setString(1,rs.getString(2));
		ResultSet rs2=ps2.executeQuery();
		String coursename="";
		if(rs2.next())
		{ 
			coursename=rs2.getString(1);
		} 
		//System.out.println("course name"+coursename);
		JSONObject responseObject=new JSONObject();
		responseObject.put("student_id",rs.getString(1));
		responseObject.put("student_name",fullname);
		responseObject.put("course_id",rs.getString(2));
		responseObject.put("course_name",coursename);
		responseObject.put("student_roll",rs.getString(3));
		responseObject.put("status",rs.getString(4));
		responseObject.put("date",rs.getString(5));
	
		responseArray.put(responseObject);
		
	}
	response.getWriter().write(responseArray.toString());
	response.getWriter().close();
}
else
{
	response.getWriter().write("invalid");
	response.getWriter().close();
}
%>