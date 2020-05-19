<%@ page import ="java.sql.*"%>
<%@ page import="bcpms.Conn"%>
<%@page import="org.json.JSONObject" %>
<%@page import="org.json.JSONArray" %>
<%@page errorPage="../../pages/commom/ErrorHandler.jsp" %>
<%
	String id=(String)session.getAttribute("user_session_key");
	String run_type=request.getParameter("run");
	if(id!=null)
	{
		if(run_type.equals("load"))
		{
			PreparedStatement ps=new Conn().con.prepareStatement("select course_details.name from course_details inner join  course_assigned_details on course_assigned_details.course_id= course_details.course_id and course_assigned_details.teacher_id=? ");
			ps.setString(1,id);
			ResultSet rs=ps.executeQuery();
			JSONArray responseArray=new JSONArray();
			while(rs.next())
			{
				JSONObject responseObject=new JSONObject();
				responseObject.put("course_name",rs.getString(1));
				responseArray.put(responseObject);
			}
			response.getWriter().write(responseArray.toString());
			response.getWriter().close();
			ps.close();
			rs.close();
		}
		else if(run_type.equals("btn_clicked"))
		{
			if(request.getParameter("run").equals("btn_clicked"))
			{
				String course=request.getParameter("course_name");
				String date=request.getParameter("date");
				String radio_btn=request.getParameter("radio_btn");
				session.setAttribute("teacher_course",course);
				session.setAttribute("attendance_date",date);
				session.setAttribute("radio",radio_btn);
				response.getWriter().write("../../pages/tables/markattendance.html");
				response.getWriter().close();
			}
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