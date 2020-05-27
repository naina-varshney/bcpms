<%@ page import="java.sql.*"%>
<%@ page import="bcpms.Conn"%>
<%@page errorPage="../../pages/commom/ErrorHandler.jsp" %>
<%
	String id=(String)session.getAttribute("user_session_key");
	if(id!=null)
	{

			String course_name=request.getParameter("course_name");
			String month=request.getParameter("month");
			String year=request.getParameter("year");
			String course_nature=Character.toString(request.getParameter("course_nature").charAt(0));
			
			//sends selected date month and year for the next attendance list page
			session.setAttribute("attendance_course",course_name);
			session.setAttribute("selected_month",month);
			session.setAttribute("selected_year",year);
			session.setAttribute("course_nature",course_nature);
			PreparedStatement ps;
			ResultSet rs;
			Connection connection=new Conn().con;
				
			ps=connection.prepareStatement("select isCoordinator from teacher where teacher_identity_card=? and isEnabled=1;");
			ps.setString(1,id);
			
			rs=ps.executeQuery();
			if(rs.next())
			{
				if(rs.getString(1).equals("1"))
				{
					ps=connection.prepareStatement("select subject from teacher where teacher_identity_card=? and subject=?");
					ps.setString(1,id);
					ps.setString(2,course_name);
					rs=ps.executeQuery();
					if(rs.next())
					{
						response.getWriter().write("../../pages/tables/attendancelist.html");
					}
					else
					{
						response.getWriter().write("invalid");
						response.getWriter().close();
					}
				}
				else if(rs.getString(1).equals("0"))				
				{
					ps=connection.prepareStatement("select course_assigned_details.course_id,course_assigned_details.teacher_id,course_details.name from course_assigned_details inner join course_details on course_details.course_id=course_assigned_details.Course_Id and course_assigned_details.Teacher_id=? and course_details.name=?;");
					ps.setString(1,id);
					ps.setString(2,course_name);
					rs=ps.executeQuery();
					if(rs.next())
					{
						response.getWriter().write("../../pages/tables/attendancelist.html");
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
	else
	{
		response.getWriter().write("invalid");
		response.getWriter().close();
	}

%>