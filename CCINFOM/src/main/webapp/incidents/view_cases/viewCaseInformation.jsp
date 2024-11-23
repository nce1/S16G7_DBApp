<%-- 
    Document   : viewCaseInformation
    Created on : 22 Nov 2024, 11:22:14 pm
    Author     : maria
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import = "java.util.*, java.sql.Date, java.text.SimpleDateFormat, ccinfom.database.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Case Information</title>
    </head>
    <body>
        <jsp:useBean id="incdt" class="ccinfom.database.Incident" scope="session"/>
        <h1>Case Information</h1>
        <% incdt.caseID = Integer.parseInt(request.getParameter("caseID")); 
            incdt.getCaseInformation(incdt.caseID);
               
           Precinct p = new Precinct();
           p.getPrecinct(incdt.precinctID);
           
           Participant participants = new Participant();
           participants.getParticipants(incdt.caseID);
           
           Offender offenders = new Offender();
           offenders.getOffenders(incdt.caseID);
               
        %>
        <a>Case ID: <%= incdt.caseID %></a><br>
        <a>Case Description: <%= incdt.description %></a><br>
        <a>Type: <%= incdt.incident_type %></a><br>
        <a>Status: <%= incdt.status %></a><br>
        <a>Date Reported: <%= incdt.dateReported %></a><br>
        <a>Date Resolved: <%= incdt.dateResolved %></a><br>
        <a>Precinct: <%= p.cityJurisdiction %></a><br><br>
        
        <h2>Participants</h2>
        <% for (int i = 0; i < participants.backgroundIdList.size(); i++) { %>
        <a>Background ID: <%=participants.backgroundIdList.get(i) %></a><br>
        <a>Testimony: <%= participants.testimonyList.get(i) %></a><br>
        <a>Involvement: <%= participants.involvementList.get(i) %></a><br><br>
        <% } %>
        <br>
        <h2>Offenders</h2>
        <% for (int i = 0; i < offenders.backgroundIDList.size(); i++) { %>
        <a>Background ID: <%= offenders.backgroundIDList.get(i) %></a><br>
        <a>Offense: <%= offenders.offenseList.get(i) %></a><br>
        <a>Status: <%= offenders.statusList.get(i) %></a><br><br>
        <% } %>
        <br>
        <form action="../manage_incidents.html"><input type="submit" value="Return"></form>
    </body>
</html>
