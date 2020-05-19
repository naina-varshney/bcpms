<%@page import="java.sql.*"%>
<%@page import="bcpms.Conn"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>

<%
	String id=(String)session.getAttribute("user_session_key");
	if(id!=null)
	{
		String module_name=request.getParameter("user_type");
		Statement st=new Conn().con.createStatement();
		String query="select image_name,path,purpose from images where purpose='";
		ResultSet rs;
		JSONArray responseArray=new JSONArray();
		if(module_name.equals("coordinator"))
		{
			rs=st.executeQuery(query+module_name+"'");
			while(rs.next())
			{
				JSONObject responseObject=new JSONObject();
				responseObject.put("img_name",rs.getString(1));
				responseObject.put("path",rs.getString(2));
				responseObject.put("purpose",rs.getString(3));
				responseArray.put(responseObject);
			}
			response.getWriter().write(responseArray.toString());
			response.getWriter().close();
			rs.close();
		}
		else if(module_name.equals("student"))
		{
			rs=st.executeQuery(query+module_name+"'");
			while(rs.next())
			{
				JSONObject responseObject=new JSONObject();
				responseObject.put("img_name",rs.getString(1));
				responseObject.put("path",rs.getString(2));
				responseObject.put("purpose",rs.getString(3));
				responseArray.put(responseObject);
			}
			response.getWriter().write(responseArray.toString());
			response.getWriter().close();
			rs.close();
		}
		else if(module_name.equals("teacher"))
		{
			rs=st.executeQuery(query+module_name+"'");
			while(rs.next())
			{
				JSONObject responseObject=new JSONObject();
				responseObject.put("img_name",rs.getString(1));
				responseObject.put("path",rs.getString(2));
				responseObject.put("purpose",rs.getString(3));
				responseArray.put(responseObject);
			}
			response.getWriter().write(responseArray.toString());
			response.getWriter().close();
			rs.close();
		}
		else
		{
			response.getWriter().write("invalid");
			response.getWriter().close();
		}
	}
	else
	{
		response.getWriter().write("invalid");
		response.getWriter().close();
	}
%>