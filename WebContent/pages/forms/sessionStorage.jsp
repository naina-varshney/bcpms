<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
String askedSessionKeyName = request.getParameter("getSessionKey");

if(session.getAttribute(askedSessionKeyName)!=null){
	
	response.getWriter().write((String)session.getAttribute(askedSessionKeyName));
	response.getWriter().close();
}else{
	response.getWriter().write("invalid session key");
	response.getWriter().close();
}


%>