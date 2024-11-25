<%-- 
    Document   : processPrecinct
    Created on : 18 Nov 2024, 1:02:14 pm
    Author     : maria
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import = "java.util.*, java.sql.*, ccinfom.database.Precinct" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title> Process Precinct </title>
    </head>
    <body>
        <form action="../index.html"
        <jsp:useBean id="precinct" class="ccinfom.database.Precinct" scope="session" />
        <%
            String in_cityJurisdiction = request.getParameter("cityJurisdiction");
            int res;
            
            precinct.cityJurisdiction = in_cityJurisdiction;
            res = precinct.addPrecinct();
            
            if (res == 1) { %>
        <h1> Precinct successfully registered </h1>
         <% } else { %>
         <h1> Error adding precinct </h1>
         <% } %>
         <input type="submit" value="Return to Menu">
        </form>
    </body>
</html>
