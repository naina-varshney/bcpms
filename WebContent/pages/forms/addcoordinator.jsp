<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="bcpms.Conn"%>
<%@ page import="org.json.JSONObject" %>
<%
	String id = (String)session.getAttribute("user_session_key");
	//System.out.println("id:"+id);
	String execute=request.getParameter("run");
	if(id!=null)
	{ 
		String coordinator_id=request.getParameter("coordinator_id");
		if(execute.equals("keypress")){
			//System.out.println("execucte:"+execute);
		
		PreparedStatement ps=new Conn().con.prepareStatement("select first_name,last_name,subject from teacher where teacher_identity_card=?");
		ps.setString(1,coordinator_id);
		ResultSet rs=ps.executeQuery();
		JSONObject responseObject=new JSONObject();
		if(rs.next())
		{
			responseObject.put("coordinator_name",rs.getString(1)+" "+rs.getString(2));
			responseObject.put("subject",rs.getString(3));
		}
		response.getWriter().write(responseObject.toString());
		response.getWriter().close();
		ps.close();
		rs.close();
		}
		else if(execute.equals("Button"))
		{
			PreparedStatement ps=new Conn().con.prepareStatement("update teacher set isCoordinator=1 where teacher_identity_card=?");
			ps.setString(1,coordinator_id);
			if(ps.executeUpdate()>0)
			{
				response.getWriter().write("done");
				response.getWriter().close();
			}
			ps.close();
		}
		
	}
	
	else
	{
		response.getWriter().write("invalid");
		response.getWriter().close();
	}
%>
