<%@ page import="java.sql.*"%>
<%@ page import="bcpms.Conn"%>
<%@ page import="java.util.*" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.ParameterParser" %>
<%
try
{
ParameterParser m = new ParameterParser(request);
System.out.println(m.getStringParameter("hello"));
System.out.println(request.getContentLength());
System.out.println("data is comming");
System.out.println(request.getAttributeNames().nextElement().toString());
System.out.println(request.getHeaderNames());
System.out.println(request);
System.out.println(request.getParameterNames());

Enumeration<String> s = request.getAttributeNames();
while(s.hasMoreElements()){
	System.out.println(s.nextElement().toString());
}
/* ArrayList<?> arr=new ArrayList<String>();
arr=(ArrayList<?>)request.getAttribute("filedata");
System.out.println(arr); */
}
catch(Exception e)
{
	e.printStackTrace();
}

//String data=(String)request.getParameter("filedata");
//System.out.println(data);
//MultipartRequest m = new MultipartRequest(request, "C:\\Users\\Naina Varshney\\workspace\\BCPMS\\WebContent\\WEB-INF\\img");
//System.out.println("request="+request.toString());
       // out.print("successfully uploaded");
%>