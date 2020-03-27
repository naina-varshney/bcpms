<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
  <%@page import="java.sql.*" %>
  <%@page import="bcpms.Conn" %>
  <%@page import="org.json.JSONObject" %>
  <%@ page import="org.json.JSONArray"%>
<%
String course_type_key = request.getParameter("course_type");
String modify = request.getParameter("modify");


//System.out.println("keyy"+course_type_key);arey ruko admindashboard pr shi kaam kr rha hai ye see 
if(course_type_key!=null)
{
	if(modify.equals("false")){
		PreparedStatement ps=new Conn().con.prepareStatement("select * from course_details where type=?");
		ps.setString(1,course_type_key);
		ResultSet rs=ps.executeQuery();
		JSONArray responseArray=new JSONArray();
		while(rs.next())
		{
			JSONObject responseJSON=new JSONObject();
			responseJSON.put("course_id",rs.getString(1));
			responseJSON.put("course_name",rs.getString(2));
			responseJSON.put("course_fees",rs.getFloat(3));
			responseJSON.put("course_duration",rs.getString(4));
			responseJSON.put("course_type",rs.getString(5));
			responseJSON.put("course_isEnabled",rs.getBoolean(6));
			responseArray.put(responseJSON);
		}
		response.getWriter().write(responseArray.toString());
		response.getWriter().close();
	}else{
		//JSONObject j = new JSONObject(request.getParameter("payload")); 
		/* System.out.println(j);
		System.out.println(j.get("course_id"));*/
	} 
	
}else{
	response.getWriter().write("null");
	response.getWriter().close();
}


%>