

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        
    </head>
    <body>
        <%
            String user_names=request.getParameter("user_id");
            session.setAttribute("session_name", user_names);
           %>
    </body>
</html>
