<%-- 
    Document   : viewCases
    Created on : 20 Nov 2024, 5:13:55 pm
    Author     : maria
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import = "java.util.*, java.sql.Date, java.text.SimpleDateFormat, ccinfom.database.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <jsp:useBean id="incdt" class="ccinfom.database.Incident" scope="session"/>
        <% String valJursdctn = request.getParameter("precinctID");
            String valDateFrom = request.getParameter("reportsFrom");
            String valDateTo = request.getParameter("reportsTo");
            String valDescription = request.getParameter("description");
            String valType = request.getParameter("incident_type");
            String valStatus = request.getParameter("status");
            Precinct precinct = new Precinct();
            boolean precinctSelected;
            
            try {
                precinct.getPrecinct(Integer.parseInt(valJursdctn));
                precinctSelected = true;
            } catch (Exception e) {
                precinctSelected = false;
            }
            
            //public boolean getIncidentListWithFilter(String precinctID, String status, String incident_type, String dateFrom, String dateTo, String description)
            incdt.getIncidentListWithFilter(valJursdctn, valStatus, valType, valDateFrom, valDateTo, valDescription);
        %>
        <h1>Cases: </h1>
        <h2>Selected filters </h2>
        <h2>Jurisdiction: <% if (precinctSelected) { %> 
                            <%= precinct.cityJurisdiction %> 
                          <% } else { %> 
                            all 
                          <% } %> </h2>
        <h2>Type: <%= valType %> </h2>
        <h2>Description: <%= valDescription %> </h2>
        <h2>Status: <%= valStatus %> </h2>
        <h2>Date From: <%= valDateFrom %> </h2>
        <h2>Date To: <%= valDateTo %> </h2>
        <% for (int i = 0; i < incdt.caseIDList.size(); i++) { %>
        <a>Case ID: <%= incdt.caseIDList.get(i) %></a><br>
        <a>Case Description: <%= incdt.descriptionList.get(i) %></a><br>
        <a>Type: <%= incdt.incident_typeList.get(i) %></a><br>
        <a>Status: <%= incdt.statusList.get(i) %></a><br>
        <a>Date Reported: <%= incdt.dateReportedList.get(i) %></a><br>
        <a>Date of incident occurrence: <%= incdt.dateOfOccurrenceList.get(i) %> </a><br>
        <a>Date Resolved: <%= incdt.dateResolvedList.get(i) %></a><br>
        <% precinct.getPrecinct(incdt.precinctIDList.get(i)); %>
        <a>Precinct: <%= precinct.cityJurisdiction %></a><br><br><br>
        <% } %>
        <a href="viewCasesSelectFilter.jsp">Back</a>
    </body>
</html>
