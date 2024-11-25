<!DOCTYPE html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import = "java.util.*, java.sql.*, ccinfom.database.*" %>

<html>
    <head>
        <title>Register incident</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>
    <body>
        <div>
            <form action="processIncident.jsp">
                <jsp:useBean id ="precinct" class="ccinfom.database.Precinct" scope="session" />
                <label for="description">Description of incident:</label><br>
                <textarea id="description" name="description" rows="5" cols="40" placeholder="Enter Description"></textarea><br>
                <label for="incident_type">Type of incident:</label>
                    <select name="incident_type" id="incident_type">
                        <option value="Violent">Violent</option>
                        <option value="Property">Property</option>
                        <option value="Organized">Organized</option>
                        <option value="Cybercrime">CyberCrime</option> <br>
                    </select><br>
                
                    <label for="status">Status</label>
                    <select name="status" id="status">
                        <option value="Under Investigation"> Under Investigation</option>
                        <option value="Forwarded to Prosecution"> Forwarded to Prosecution</option>
                        <option value="Charges Filed">Charges Filed</option>
                        <option value="Awaiting Trial">Awaiting Trial</option>
                    </select><br>
                <a>Date of incident occurrence: </a> <input type="date" id="dateOfOccurrence" name="dateOfOccurrence" required><br>
                <a>Date reported: </a> <input type="date" id="dateReported" name="dateReported" required><br><br>
                <% precinct.precinctID = Integer.parseInt(request.getParameter("precinctID")); %>
                <input type="hidden" name="precinctID" id="precinctID" value="<%= precinct.precinctID%>">
                
                 <!-- Create 1 participant record -->
                <label for="backgroundId">Select background ID of participant: </label>
                <% Person person = new Person();
                   person.getAlivePersons(); %>
                <select name="backgroundId" id="backgroundId" required>
                    <option value="">Select background ID</option>
                    <% for (int i = 0; i < person.idList.size(); i++) {%>
                    <option value="<%= person.idList.get(i) %>"><%= person.idList.get(i) %></option>
                    <% } %>
                </select><br><br>
                <label for="involvement">Involvement of participant:</label><br>
                
                <input type="radio" name="involvement" id="Victim" value="Victim">
                <label for="Victim">Victim</label><br>
                
                <input type="radio" name="involvement" id="Witness" value="Witness">
                <label for="Witness">Witness</label><br><br>
                
                <label for="testimony">Testimony:</label><br>
                <textarea name="testimony" id="testimony" rows="5" cols="50" placeholder="Enter testimony" required></textarea><br>
                <input type="submit" value="Submit Incident"><br>
            </form>
            <a href="select_precinct.jsp">Back</a>
        </div>
    </body>
</html>
