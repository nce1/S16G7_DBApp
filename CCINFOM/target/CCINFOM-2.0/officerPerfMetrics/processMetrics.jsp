<%-- 
    Document   : processMetrics
    Created on : 23 Nov 2024, 11:17:50 am
    Author     : maria
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import = "java.util.*, java.sql.Date, java.text.SimpleDateFormat, ccinfom.database.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Officer Performance Metrics</title>
    </head>
    <body>
        <jsp:useBean id="officer" class="ccinfom.database.Officer" scope="session"/>
        <% 
            String valMonth = request.getParameter("input_month");
        %>
        <h1>Officer Metrics for  <%= valMonth %> </h1>
        <%
            valMonth = valMonth + "-01";
            Date valDate = Common.toDate(valMonth);
            
            officer.getPerformanceMetrics(valDate);
            for (int i = 0; i < officer.policeIDList.size(); i++) {
        %>
        <a>Police ID: <%= officer.policeIDList.get(i) %></a><br>
        <a>Name: <%= officer.officerNameList.get(i) %></a><br>
        <a>Precinct: <%= officer.PrecinctNames.get(i) %></a><br>
        <a>Number of cases resolved: <%= officer.numCasesResolved.get(i) %> </a><br>
        <a>Number of offenses given: <%= officer.numOffensesGiven.get(i) %></a><br><br>
        <% } %>
        <br><a href="../index.html">Back</a>
    </body>
</html>
