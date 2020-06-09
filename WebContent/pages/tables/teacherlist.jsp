<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="bcpms.Conn"%>
<%@page import="org.json.JSONObject" %>
<%@page import="org.json.JSONArray" %>
<%@page errorPage="../../pages/commom/ErrorHandler.jsp" %>
<%
    String id=(String)session.getAttribute("user_session_key");
    if(id!=null)
   {
    	String user=request.getParameter("user_type");
    	if(user.equals("teacher"))
    	{
	        PreparedStatement ps=new Conn().con.prepareStatement("select teacher_identity_card,first_name,last_name,subject from teacher where isCoordinator=0");
	        ResultSet rs=ps.executeQuery();
	        JSONArray responseArray=new JSONArray();
	        while(rs.next())
	        {
	        	JSONObject responseObject=new JSONObject();
	        	responseObject.put("teacher_id",rs.getString(1));
	        	responseObject.put("teacher_name",rs.getString(2)+" "+rs.getString(3));
	        	responseObject.put("subject",rs.getString(4));
	        	responseArray.put(responseObject);
	        	
	        }
	        response.getWriter().write(responseArray.toString());
	        response.getWriter().close();
	        ps.close();
	        rs.close();
  	 	}
    	else if(user.equals("Coordinator"))
    	{
    	 	PreparedStatement ps=new Conn().con.prepareStatement("select teacher_identity_card,first_name,last_name,subject from teacher where isCoordinator=1");
         	ResultSet rs=ps.executeQuery();
          	JSONArray responseArray=new JSONArray();
         	while(rs.next())
         	{
	         	JSONObject responseObject=new JSONObject();
	         	responseObject.put("teacher_id",rs.getString(1));
	         	responseObject.put("teacher_name",rs.getString(2)+" "+rs.getString(3));
	         	responseObject.put("subject",rs.getString(4));
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
    	response.getWriter().write("invalid");
    	response.getWriter().close();
    }
%>





