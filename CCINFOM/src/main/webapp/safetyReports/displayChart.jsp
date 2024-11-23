<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Crime Distribution</title>
    </head>
    <body>
        <%
            String cityName = request.getParameter("city");
        %>
        <h1> <%=cityName%>  <\h1>
    </body>
</html>
