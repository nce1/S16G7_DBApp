<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, ccinfom.database.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Precinct Options</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
            margin: 20px;
            padding: 20px;
        }
        h1 {
            text-align: center;
            color: #333;
        }
        nav {
            margin: 20px 0;
        }
        section {
            margin-bottom: 20px;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            background-color: #fff;
        }
        h2 {
            font-size: 1.2em;
            color: #444;
            border-bottom: 1px solid #ddd;
            margin-bottom: 10px;
            padding-bottom: 5px;
        }
        ul {
            list-style: none;
            padding: 0;
        }
        li {
            margin: 5px 0;
        }
        a {
            text-decoration: none;
            color: #007BFF;
        }
        a:hover {
            text-decoration: underline;
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
    <h1>Precinct Options</h1>

    <%
        // Retrieve the precinctID from the request
        String precinctID = request.getParameter("precinctID");

        if (precinctID != null && !precinctID.isEmpty()) {
    %>
    <ul>
        <li><a href="updatePrecinctLocation.jsp?precinctID=<%= precinctID %>">Update Precinct Location</a></li>
        <li><a href="deletePrecinctResult.jsp?precinctID=<%= precinctID %>">Delete Precinct</a></li>
    </ul>
    <%
        } else {
    %>
        <p>No precinct selected. Please select a precinct first.</p>
    <%
        }
    %>
    
    <div class="button-group">
        <button class="back-btn" onclick="history.back()">Back</button>
    </div>

</body>
</html>

