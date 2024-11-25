<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, ccinfom.database.*" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Case Report Statistics</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
            background-color: #f4f4f9;
        }
        .container {
            background-color: #ffffff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            width: 400px;
            box-sizing: border-box;
        }
        h1 {
            color: #333;
            font-size: 1.5em;
            text-align: center;
            border-bottom: 2px solid #f4f4f9;
            padding-bottom: 10px;
        }
        p {
            text-align: center;
            color: #555;
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
    <jsp:useBean id="P" class="ccinfom.database.Precinct" scope="session" />
    <div class="container">
        <h1>Case Report Statistics</h1>
        <%
            // Retrieve selected precinctID and monthYear from the request
            String vPrecinctID = request.getParameter("precinctID");
            String vMonthYear = request.getParameter("monthYear");

            if (vPrecinctID != null && vMonthYear != null) {
                // Split monthYear into month and year
                String[] parts = vMonthYear.split("-");
                int month = Integer.parseInt(parts[0]);
                int year = Integer.parseInt(parts[1]);

                // Set the values in the Precinct bean
                int precinctID = Integer.parseInt(vPrecinctID);

                // Call the method to calculate total and average cases
                String resultMessage = P.calculateCases(precinctID, year, month);
                out.println("<p>" + resultMessage + "</p>");
            } else {
                out.println("<p>Invalid input. Please provide precinctID and monthYear.</p>");
            }
        %>

        <div class="button-group">
            <button class="back-btn" onclick="history.back()">Back</button>
        </div>
    </div>
</body>
</html>


