<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, ccinfom.database.Precinct" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Precincts and Officers</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f9;
                margin: 20px;
                padding: 20px;
            }
            h1 {
                text-align: center;
                color: #333;
            }
            table {
                width: 100%;
                border-collapse: collapse;
                margin-bottom: 20px;
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
                justify-content: center;
                margin-top: 20px;
            }
            .back-btn {
                padding: 10px 20px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                background-color: #d9534f;
                color: white;
                font-size: 1em;
                text-decoration: none;
                text-align: center;
            }
            .back-btn:hover {
                background-color: #c9302c;
            }
        </style>
    </head>
    <body>
        <h1>Precincts and Officers</h1>

        <%
            // Create an instance of the Precinct class
            Precinct precinctObj = new Precinct();

            // Get precincts and their officers
            Map<Integer, List<Integer>> precinctOfficersMap = precinctObj.getPrecinctListWithOfficers();

            if (precinctOfficersMap != null && !precinctOfficersMap.isEmpty()) {
        %>
        <table>
            <thead>
                <tr>
                    <th>Precinct ID</th>
                    <th>City Jurisdiction</th>
                    <th>Officer IDs</th>
                </tr>
            </thead>
            <tbody>
                <%
                    // Iterate through the map
                    for (int i = 0; i < precinctObj.precinctIDList.size(); i++) {
                        int precinctID = precinctObj.precinctIDList.get(i);
                        String cityJurisdiction = precinctObj.cityJurisdictionList.get(i);
                        List<Integer> officerIDs = precinctOfficersMap.get(precinctID);
                %>
                <tr>
                    <td><%= precinctID %></td>
                    <td><%= cityJurisdiction %></td>
                    <td>
                        <% 
                            if (officerIDs != null && !officerIDs.isEmpty()) {
                                for (int officerID : officerIDs) {
                        %>
                            <div><%= officerID %></div>
                        <% 
                                }
                            } else { 
                        %>
                            <div>No officers assigned</div>
                        <% 
                            }
                        %>
                    </td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
        <% 
            } else { 
        %>
            <p>No precincts or officers available.</p>
        <% 
            }
        %>

        <div class="button-group">
        <button class="back-btn" onclick="history.back()">Back</button>
        </div>
    </body>
</html>

