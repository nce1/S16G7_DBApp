<%-- 
    Document   : updateCase
    Created on : 18 Nov 2024, 8:39:50 pm
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
        <a>Date of incident occurrence: <%= incdt.dateOfOccurrence %> </a><br>
        <a>Date Resolved: <%= incdt.dateResolved %></a><br>
        <a>Precinct: <%= p.cityJurisdiction %></a><br><br>
        <form action="process_update_status.jsp">
            <label for="status"> Update case status: </label>
            <select name="status" id="status" required>
                <option value="Under Investigation">Under Investigation</option>
                <option value="Forwarded to Prosecution">Forwarded to Prosecution </option>
                <option value="Charges Filed">Charges Filed</option>
                <option value="Awaiting Trial">Awaiting Trial</option>
            </select><br>
            <input type="hidden" id="caseID" name="caseID" value="<%= incdt.caseID %>">
            <input type="submit" value="Update Case">
        </form>
        <a href="select_jurisdiction.jsp">Back</a>
    </body>
</html>
