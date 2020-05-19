<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="bcpms.Conn"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page errorPage="../../pages/commom/ErrorHandler.jsp" %>

<%
   String sname=(String)session.getAttribute("user_session_key");
   if(sname!=null)
   {
      PreparedStatement ps = new Conn().con.prepareStatement("select name from administrator where username=?");
      ps.setString(1,sname);
      ResultSet rs=ps.executeQuery();
      String adminName="";
      if(rs.next())
     	{
          adminName=rs.getString(1);
     	}
      response.getWriter().write(adminName);
      ps.close();
      rs.close();
      response.getWriter().close();
   }
   else
   {
	  response.getWriter().write("unauthorized");
	  response.getWriter().close();   
	}                              
%>

