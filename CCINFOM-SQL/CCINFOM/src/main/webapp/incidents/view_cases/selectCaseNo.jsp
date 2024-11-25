<%-- 
    Document   : selectCaseNo
    Created on : 22 Nov 2024, 11:22:57 pm
    Author     : maria
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Select a Case</title>
    </head>
    <body>
        <jsp:useBean id="incdt" class="ccinfom.database.Incident" scope="session"/>
        
        <% incdt.getIncidentList(); %>
        <form action="viewCaseInformation.jsp">
            <label for="caseID">Select a case ID:</label>
            <select name="caseID" id="caseID" required>
                <option value="">Select case</option>
                <% for (int i = 0; i < incdt.caseIDList.size(); i++) { %>
                <option value="<%= incdt.caseIDList.get(i) %>"><%= incdt.caseIDList.get(i) %></option>
                <% } %>
            </select><br>
            <input type="submit" value="Proceed">
        </form>
    </body>
</html>
