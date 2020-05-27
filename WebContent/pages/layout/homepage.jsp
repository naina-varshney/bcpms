<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@page import="org.json.JSONArray" %>
<%@page import="org.json.JSONObject" %>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="bcpms.Conn"%>

<%
	PreparedStatement ps=new Conn().con.prepareStatement("select image_name,path,purpose,image_heading from images");
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
%>