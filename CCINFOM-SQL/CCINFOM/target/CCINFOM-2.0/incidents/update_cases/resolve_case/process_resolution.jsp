<%-- 
    Document   : process_resolution
    Created on : 19 Nov 2024, 1:11:23 am
    Author     : maria
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import = "java.util.*, java.sql.Date, java.text.SimpleDateFormat, ccinfom.database.Incident, ccinfom.database.Common" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Resolve Case</title>
    </head>
    <body>
        <jsp:useBean id="incdt" class="ccinfom.database.Incident" scope="session"/>
        <%  
            Date dateResolved = Common.toDate(request.getParameter("dateResolved"));
            int caseID = Integer.parseInt(request.getParameter("caseID"));
            String status = request.getParameter("status");
            
            incdt.getCaseInformation(caseID);
            boolean res;
            
            //check if dateResolved is later than dateReported
            if (dateResolved.after(incdt.dateReported)) {
                res = incdt.resolveCase(caseID, dateResolved, status);
            } else {
                res = false;
            }
            
            if (res) { %>
        <h1>Case Marked as Resolved</h1>
            <% } else { %>
        <h1>Unable to resolve case</h1>
            <% } %>
        <form action="../../manage_incidents.html">
            <input type="submit" value="Return">
        </form>
    </body>
</html>
