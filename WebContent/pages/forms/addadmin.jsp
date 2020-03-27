<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="java.sql.*" %>
    <%@page import="bcpms.Conn" %>
<%
String key=request.getParameter("id");
String admin_id=request.getParameter("new_admin_id");
String admin_name=request.getParameter("admin_name");
String password=request.getParameter("password");
String security_ques=request.getParameter("security_ques");
String security_ans=request.getParameter("security_ans");
if(key!=null)
{
	PreparedStatement ps=new Conn().con.prepareStatement("insert into administrator (name,username,password,security_question,security_answer) values(?,?,?,?,?)");
	ps.setString(1,admin_name);
	ps.setString(2,admin_id);
	ps.setString(3,password);
	ps.setString(4,security_ques);
	ps.setString(5,security_ans);
	if(ps.executeUpdate()>0)
	{
		response.getWriter().write("inserted");
		response.getWriter().close();
	}
	else{
		response.getWriter().write("error");
		response.getWriter().close();
	}
}
else
{
	response.getWriter().write("error");
	response.getWriter().close();
	
}




%>