
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import = "java.util.*, java.sql.Date, java.text.SimpleDateFormat, ccinfom.database.*" %>

<html>
    <head>
        <title>View Cases</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <script>
        // Toggle the enabled/disabled state of the date inputs
        function toggleInput(checkbox, inputId) {
            const input = document.getElementById(inputId);
            input.disabled = !checkbox.checked; // Disable input if checkbox is unchecked
        }
        </script>
    </head>
    <body>
    
        <div>
            <form action="processViewCases.jsp">
            <jsp:useBean id="precinct" class="ccinfom.database.Precinct" scope="session"/>
                <label for="precinctID">Select a jurisdiction:</label>
                <select name="precinctID" id="precinctID" required>
                    <option value="all">Any jurisdiction</option>
                <% precinct.getPrecinctList();
                
                    for (int i = 0; i < precinct.precinctIDList.size(); i++) { %> 
                    <option value="<%= precinct.precinctIDList.get(i)%>"><%= precinct.cityJurisdictionList.get(i)%></option>
                <%  } %>
                </select><br>
                
                <label for="status">Select case status:</label>
                <select name="status" id="status" required>
                    <option value="all">Any status</option>
                    <option value="Under Investigation">Under Investigation</option>
                    <option value="Forwarded to Prosecution">Forwarded to Prosecution</option>
                    <option value="Charges Filed">Charges Filed</option>
                    <option value="Awaiting Trial">Awaiting Trial</option>
                    <option value="Convicted">Convicted</option>
                    <option value="Acquitted">Acquitted</option>
                    <option value="Dismissed">Dismissed</option>
                </select><br>
                <label for="incident_type">Select a case type:</label>
                <select name="incident_type" id="incident_type" required>
                    <option value="all">Any type</option>
                    <option value="Violent">Violent</option>
                    <option value="Property">Property</option>
                    <option value="Organized">Organized</option>
                    <option value="Cybercrime">Cybercrime</option>
                </select><br><br>
                
                <input type="checkbox" name="enableStartDate" id="enableStartDate" onclick="toggleInput(this, 'reportsFrom')">
                <label for="enableStartDate">Reports made from:</label>
                <input type="date" name="reportsFrom" id="reportsFrom" disabled><br>

                <input type="checkbox" name="enableEndDate" id="enableEndDate" onclick="toggleInput(this, 'reportsTo')">
                <label for="enableEndDate">Reports made to:</label>
                <input type="date" name="reportsTo" id="reportsTo" disabled><br>
                
                <input type="checkbox" name="enableDescription" id="enableDescription" onclick="toggleInput(this, 'description')">
                <label for="description">Search by description: </label><br>
                <textarea name="description" id="description" rows="5" cols="40" placeholder="Enter Description" disabled></textarea><br>
                <input type="submit" value="View cases"><br>
                <a href="../manage_incidents.html">Back</a>
            </form>
        </div>
    </body>
</html>
