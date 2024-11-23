<%-- 
    Document   : resolve_case
    Created on : 19 Nov 2024, 1:11:01 am
    Author     : maria
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import = "java.util.*, java.sql.Date, java.text.SimpleDateFormat, ccinfom.database.Precinct, ccinfom.database.Incident, ccinfom.database.Common" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Resolve a Case</title>
    </head>
    <body>
        <jsp:useBean id="incdt" class="ccinfom.database.Incident" scope="session"/>
        <% incdt.caseID = Integer.parseInt(request.getParameter("caseID")); 
        incdt.getCaseInformation(incdt.caseID);
               
        Precinct p = new Precinct();
        p.getPrecinct(incdt.precinctID);
               
        %>
        <a>Case ID: <%= incdt.caseID %></a><br>
        <a>Case Description: <%= incdt.description %></a><br>
        <a>Type: <%= incdt.incident_type %></a><br>
        <a>Status: <%= incdt.status %></a><br>
        <a>Date Reported: <%= incdt.dateReported %></a><br>
        <a>Date Resolved: <%= incdt.dateResolved %></a><br>
        <a>Precinct: <%= p.cityJurisdiction %></a><br><br>
        <form action="process_resolution.jsp">
            <label for="dateResolved">Select date: </label>
            <!-- Carry over case ID input from previous page -->
            <input type="hidden" name="caseID" id="caseID" value="<%= incdt.caseID %>">
            <input type="date" name="dateResolved" id="dateResolved" required><br>
            <label for="status">Select resolution status:</label>
            <select name="status" id="status" required>
                <option value="">Select</option>
                <option value="Convicted">Convicted</option>
                <option value="Acquitted">Acquitted</option>
                <option value="Dismissed">Dismissed</option>
            </select><br>
            <input type="submit" value="Resolve Case">
        </form>
        <a href="select_jurisdiction.jsp">Back</a>
    </body>
</html>
