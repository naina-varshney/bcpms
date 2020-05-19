<%@ page import="java.sql.*"%>
<%@ page import="bcpms.Conn"%>
<%@ page import = "java.io.*,java.util.*" %>
<%@ page import="javax.servlet.*" %> 
<%@ page import = "javax.servlet.http.*" %>
<%@ page import = "org.apache.commons.fileupload.*" %>
<%@ page import = "org.apache.commons.fileupload.disk.*" %>
<%@ page import = "org.apache.commons.fileupload.servlet.*" %>
<%@ page import = "org.apache.commons.io.output.*" %>
<%
try{
	System.out.println("comming");
	Part filePart = request.getPart("image");
	System.out.println(filePart);
	if (filePart != null) {
	    // prints out some information for debugging
	    System.out.println(filePart.getName());
	    System.out.println(filePart.getSize());
	    System.out.println(filePart.getContentType());
	     
	    // obtains input stream of the upload file
		//inputStream = filePart.getInputStream();
	}
}
catch(Exception e)
{
	e.printStackTrace();
}
finally{
	
}

%>