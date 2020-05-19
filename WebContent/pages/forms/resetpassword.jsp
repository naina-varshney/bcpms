<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.PreparedStatement" %>
<%@page import="java.sql.ResultSet" %>
<%@page import="bcpms.Conn" %>
<%@page errorPage="../../pages/commom/ErrorHandler.jsp" %>
<%
try{
	String key=request.getParameter("reset_session_key");
	System.out.println("Reset session="+key);
	if(key!=null)
	{
		String oldPassword=request.getParameter("old_password");
		String newPassword=request.getParameter("new_password");
		String confirmPassword=request.getParameter("confirm_password");
		if(newPassword.equals(confirmPassword))
		{
			if((key.charAt(0)=='A')&&(key.charAt(1)=='D'))
			{
				PreparedStatement ps=new Conn().con.prepareStatement("select password from administrator where username=?");
				ps.setString(1,key);
				ResultSet rs=ps.executeQuery();
				if(rs.next())
				{
					if(oldPassword.equals(rs.getString(1)))
					{
						PreparedStatement ps2=new Conn().con.prepareStatement("update administrator set password=? where username=?");
						ps2.setString(1,newPassword);
						ps2.setString(2,key);
						if(ps2.executeUpdate()>0)
						{
							response.getWriter().write("authorized");
							response.getWriter().close();
						}
						ps2.close();
					}
				}
				ps.close();
				rs.close();
			}	
			else if(key.charAt(0)=='T')
			{	
				PreparedStatement ps=new Conn().con.prepareStatement("select password from teacher where teacher_identity_card=?");
				ps.setString(1,key);
				ResultSet rs=ps.executeQuery();
				if(rs.next())
				{
					if(oldPassword.equals(rs.getString(1)))
					{
						PreparedStatement ps2=new Conn().con.prepareStatement("update teacher set password=? where teacher_identity_card=?");
						ps2.setString(1,newPassword);
						ps2.setString(2,key);
						if(ps2.executeUpdate()>0)
						{
							response.getWriter().write("authorized");
							response.getWriter().close();
						}
						ps2.close();
					}
				}
				ps.close();
				rs.close();
			}
			else if((key.charAt(0)=='A')&&(key.charAt(1)=='B'))
			{
				PreparedStatement ps=new Conn().con.prepareStatement("select password from student where student_identity_card=?");
				ps.setString(1,key);
				ResultSet rs=ps.executeQuery();
				if(rs.next())
				{
					if(oldPassword.equals(rs.getString(1)))
					{
						PreparedStatement ps2=new Conn().con.prepareStatement("update student set password=? where student_identity_card=?");
						ps2.setString(1,newPassword);
						ps2.setString(2,key);
						if(ps2.executeUpdate()>0)
						{
							response.getWriter().write("authorized");
							response.getWriter().close();
						}
						ps2.close();
					}
				}
				ps.close();
				rs.close();
			}
		}
		else
		{
			response.getWriter().write("not authorized");
			response.getWriter().close();
		}
	}
	else
	{
		response.getWriter().write("not authorized");
		response.getWriter().close();
	}
}
catch(Exception e)
{
	e.printStackTrace();
}
%>