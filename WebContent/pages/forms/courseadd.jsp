<%@page import="java.sql.PreparedStatement"%>
<%@page import="bcpms.Conn"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
	String id=request.getParameter("id");
	String type =request.getParameter("type");
	String course_name=request.getParameter("name");
	String course_fees=request.getParameter("fees");
	String course_duration=request.getParameter("duration");	
		
			System.out.println("type ADD=" + type+" "+id+" "+course_name+" "+course_fees+" "+course_duration);
			PreparedStatement ps = new Conn().con.prepareStatement("insert into course_details(course_id,name,fee,duration,type) values(?,?,?,?,?)");
			ps.setString(1, id);
			ps.setString(2, course_name);
			ps.setString(3, course_fees);
			ps.setString(4, course_duration);
			ps.setString(5, type);
			if (ps.executeUpdate() > 0) {
				System.out.println("inserted");
				response.getWriter().write("inserted");
				response.getWriter().close();
			}
			else
			{
				System.out.println("error");
				response.getWriter().write("error");
				response.getWriter().close();
			}
	
		/* else
		{
			System.out.println("error2");
			response.getWriter().write("error");
			response.getWriter().close();
		} */
%>
