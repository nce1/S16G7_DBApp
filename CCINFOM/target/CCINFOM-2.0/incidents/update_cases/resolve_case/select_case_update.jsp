<%-- 
    Document   : UpdateCase
    Created on : 18 Nov 2024, 6:56:37 pm
    Author     : maria
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Resolve a case</title>
    </head>
    <body>
        <form action="resolve_case.jsp">
            <jsp:useBean id="incdt" class="ccinfom.database.Incident" scope="session"/>
            <label for="caseID">Select a case to update: </label>
            <select name="caseID" id="caseID" required>
                <% 
                    int precinctID = Integer.parseInt(request.getParameter("precinctID"));
                    
                    incdt.getIncidentListUnresolved(precinctID);
                    
                    for (int i = 0; i < incdt.caseIDList.size(); i++) {
                %>
                <option value="<%= incdt.caseIDList.get(i) %>"><%= incdt.caseIDList.get(i) %></option>
                <% } %>
            </select><br>
            <input type="submit" value="Proceed"><br>
        </form>
        <a href="select_jurisdiction.jsp">Back</a>
    </body>
</html>
