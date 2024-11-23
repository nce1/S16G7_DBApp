<%-- 
    Document   : process_update
    Created on : 18 Nov 2024, 7:47:37 pm
    Author     : maria
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import = "java.util.*, java.sql.Date, java.text.SimpleDateFormat, ccinfom.database.Precinct, ccinfom.database.Incident, ccinfom.database.Common" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Case Status</title>
    </head>
    <body>
        <jsp:useBean id="incdt" class="ccinfom.database.Incident" scope="session"/>
        <form action="../../manage_incidents.html">
            <% int caseID = Integer.parseInt(request.getParameter("caseID"));
               String newStatus = request.getParameter("status");
               
               incdt.getCaseInformation(caseID);
               boolean res;
               
               if (newStatus.equalsIgnoreCase(incdt.status)) {
                    res = false;
               } else {
                    res = incdt.updateIncidentStatus(newStatus, caseID);
               }
               
               if (res) {%>
            <h1>Case Status successfully updated</h1>
            <% } else { %>
            <h1>Unable to update case status</h1>
            <% } %>
            <input type="submit" value="Return">
        </form>
        
    </body>
</html>
