<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, ccinfom.database.Precinct" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Precincts</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            margin: 20px;
            padding: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            padding: 10px;
            text-align: left;
            border: 1px solid #ddd;
        }
        th {
            background-color: #f2f2f2;
        }
        tr:hover {
            background-color: #f1f1f1;
        }
        .button-group {
            display: flex;
            gap: 10px;
            margin-top: 20px;
        }
        .back-btn {
            flex: 1;
            padding: 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            background-color: #d9534f;
            color: white;
            font-size: 1em;
        }
        .back-btn:hover {
            background-color: #c9302c;
        }
    </style>
</head>
<body>
    <h1>List of Precincts and their City Jurisdictions</h1>

    <%
        // Create an instance of the Precinct class
        Precinct precinctObj = new Precinct();

        // Get the list of precincts and city jurisdictions
        int result = precinctObj.getPrecinctList(); // Get precinct list

        // Check if the list was retrieved successfully
        if (result == 1 && !precinctObj.precinctIDList.isEmpty()) {
    %>
    <table>
        <thead>
            <tr>
                <th>Precinct ID</th>
                <th>City Jurisdiction</th>
            </tr>
        </thead>
        <tbody>
            <% 
                // Loop through the lists and display each precinct's details
                for (int i = 0; i < precinctObj.precinctIDList.size(); i++) {
                    int precinctID = precinctObj.precinctIDList.get(i);
                    String cityJurisdiction = precinctObj.cityJurisdictionList.get(i);
            %>
            <tr>
                <td><%= precinctID %></td>
                <td><%= cityJurisdiction %></td>
            </tr>
            <% 
                }
            %>
        </tbody>
    </table>
    <% 
        } else { 
    %>
        <p>No precincts available.</p>
    <% 
        }
    %>
    
    <div class="button-group">
        <button class="back-btn" onclick="history.back()">Back</button>
    </div>
</body>
</html>

