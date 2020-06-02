<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="bcpms.Conn"%>
<%@ page import="org.json.JSONObject"%>
<%@ page import="org.json.JSONArray"%>
<%@ page import="javax.json.JsonArrayBuilder" %>

<% 
	try{
		    String session_id = (String)session.getAttribute("user_session_key");
		    
		    if(session_id == null){
		    	session_id = request.getParameter("user_session_key");
		    }
		    
    		if(session_id!=null)
    		{
	    		Statement stmt=new Conn().con.createStatement();
	    		ResultSet rs;
	    		JSONArray responseArray=new JSONArray();
	    		String query="select * from ";
	    		String table_name=request.getParameter("tableName");
	        	if(table_name.equals("course_type")){  	
	        	rs=stmt.executeQuery(query+table_name);
	        	String course_type,course_id;
	      		while(rs.next())
	      		{
	      			JSONObject responseObject = new JSONObject();
	      			responseObject.put("id",rs.getInt(1));
	      			responseObject.put("course_type",rs.getString(2));
	      			responseArray.put(responseObject);  
	      		}
	      		response.getWriter().write(responseArray.toString());
	      		response.getWriter().close();
	    		rs.close();
        	}
        else if(table_name.equals("course_details"))
        {  	
        	rs=stmt.executeQuery(query+table_name);
        	String course_type,course_id;
      		while(rs.next())
      		{
      			JSONObject responseObject = new JSONObject();
      			responseObject.put("id",rs.getString(1));
      			responseObject.put("course_name",rs.getString(2));
      			responseObject.put("course_fees",rs.getString(3));
      			responseObject.put("course_duration",rs.getString(4));
      			responseArray.put(responseObject);   
      		}
      		response.getWriter().write(responseArray.toString());
      		response.getWriter().close();
      		rs.close();
        }
        else if(table_name.equals("designation"))
        {	
        	rs=stmt.executeQuery(query+table_name);
			while(rs.next())
			{
				JSONObject responseObject = new JSONObject();
      			responseObject.put("id",rs.getInt(1));
      			responseObject.put("designation",rs.getString(2));
      			responseArray.put(responseObject);	
			}
			response.getWriter().write(responseArray.toString());
			response.getWriter().close();
			rs.close();
        }
        else if(table_name.equals("hostel_name"))
        {
        	rs=stmt.executeQuery(query+table_name);
			while(rs.next())
			{
				JSONObject responseObject = new JSONObject();
      			responseObject.put("id",rs.getInt(1));
      			responseObject.put("hostelName",rs.getString(2));
      			responseArray.put(responseObject);	
			}
			response.getWriter().write(responseArray.toString());
			response.getWriter().close();
			rs.close();
        }
    	else
    	{
    		response.getWriter().write("Not Authorized");
    		response.getWriter().close();
        }
	}
   }
    catch(Exception e)
    {
    	e.printStackTrace();
    }
%>