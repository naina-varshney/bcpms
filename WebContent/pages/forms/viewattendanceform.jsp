<%@ page import="java.sql.*"%>
<%@ page import="bcpms.Conn"%>
<%@page errorPage="../../pages/commom/ErrorHandler.jsp" %>
<%
	String id=(String)session.getAttribute("user_session_key");
	if(id!=null)
	{
		String option_selected=request.getParameter("selected_radio");
		session.setAttribute("radio_selected",option_selected);
		String course_name=request.getParameter("course_name");
		session.setAttribute("attendance_course",course_name);
		String date=request.getParameter("date");
		String month=request.getParameter("month");
		String year=request.getParameter("year");
		session.setAttribute("selected_date",date);
		session.setAttribute("selected_month",month);
		session.setAttribute("selected_year",year);
		if(date!=null)
		{
			PreparedStatement ps=new Conn().con.prepareStatement("select teacher_identity_card,subject from teacher where isCoordinator=1 and teacher_identity_card=? and subject=?");
			ps.setString(1,id);
			ps.setString(2,course_name);
			ResultSet rs=ps.executeQuery();
			if(rs.next())
			{
				response.getWriter().write("../../pages/tables/attendancelist.html");
			}
			else
			{
				response.getWriter().write("invalid");
				response.getWriter().close();
			}
			ps.close();
			rs.close();
			response.getWriter().close();
		}
		else if(month!=null && year!=null)
		{
			PreparedStatement ps=new Conn().con.prepareStatement("select teacher_identity_card,subject from teacher where isCoordinator=1 and teacher_identity_card=? and subject=?");
			ps.setString(1,id);
			ps.setString(2,course_name);
			ResultSet rs=ps.executeQuery();
			if(rs.next())
			{
				response.getWriter().write("../../pages/tables/attendancelist.html");
			}
			else
			{
				response.getWriter().write("invalid");
				response.getWriter().close();
			}
			ps.close();
			rs.close();
			response.getWriter().close();
		}
	
	}
	else
	{
		response.getWriter().write("invalid");
		response.getWriter().close();
	}

%>