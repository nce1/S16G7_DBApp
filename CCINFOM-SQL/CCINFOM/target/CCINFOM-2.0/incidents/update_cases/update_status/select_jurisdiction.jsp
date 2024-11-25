<%-- 
    Document   : select_jurisdiction
    Created on : 18 Nov 2024, 7:52:45 pm
    Author     : maria
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import = "java.util.*, java.sql.Date, java.text.SimpleDateFormat, ccinfom.database.Precinct, ccinfom.database.Incident, ccinfom.database.Common" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Case Status - Select Jurisdiction</title>
    </head>
    <body>
        <form action="select_case_update.jsp">
            <jsp:useBean id ="precinct" class="ccinfom.database.Precinct" scope="session" />
            <label for="cityJurisdiction">Select a Jurisdiction: </label>
            <select name="precinctID" id="precinctID">
                <%  precinct.getPrecinctList();
                    for (int i = 0; i < precinct.cityJurisdictionList.size(); i++) { %>
                <option value="<%= precinct.precinctIDList.get(i)%>"> <%= precinct.cityJurisdictionList.get(i) %> </option>
                <% } %>
            </select><br>
            <input type="submit" value="Proceed"><br>
        </form>
        <a href="../../../index.html">Back</a>
    </body>
</html>
