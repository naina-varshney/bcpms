<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
	<%
	String key=request.getParameter("key");
	String value=request.getParameter("value");
	session.setAttribute(key,value);
	response.getWriter().write("done");
	response.getWriter().close();
%>