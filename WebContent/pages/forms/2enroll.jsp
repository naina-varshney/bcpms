<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="bcpms.Conn" %>
<%@ page import="org.json.JSONObject" %>
<%@page errorPage="../../pages/commom/ErrorHandler.jsp" %>
<%
	String id=(String)session.getAttribute("user_session_key");
	String student_info=request.getParameter("student_details");
	JSONObject responseObject=new JSONObject(student_info);
	System.out.println("Object"+ responseObject);
	String[] keyArray = {"tenth","twelve","graduation","postgraduation","diploma"};
	String[] courseName = {"10","12","UG","PG","Diploma"};
	for(int i=0; i<keyArray.length; i++)
	{
		JSONObject j = (JSONObject) responseObject.get(keyArray[i]);
		if(!j.get("board").equals("")&&!j.get("year").equals("")&&!j.get("obtained").equals("")&&!j.get("total").equals(""))
		{
			String query="insert into student_qualification_details (student_id,board,course,passing_year,obtained_marks,total_marks) values(?,?,?,?,?,?)";
			PreparedStatement ps=new Conn().con.prepareStatement(query);
			ps.setString(1,id);
			ps.setString(2,(String)j.get("board"));
			ps.setString(3,courseName[i]);
			ps.setString(4,(String)j.get("year"));
			ps.setFloat(5,Float.parseFloat((String)j.get("obtained")));
			ps.setInt(6, Integer.parseInt((String)j.get("total")));
			if(ps.executeUpdate()>0)
			{
				System.out.println("Query success for "+keyArray[i]);
				response.getWriter().write("../../pages/dashboard/studentdashboard.html");
			}
			else
			{
				response.getWriter().write("invalid");
				System.out.println("Query failed for "+keyArray[i]);
			}
			response.getWriter().close();
			ps.close();
		
		}
	
	}
%>
