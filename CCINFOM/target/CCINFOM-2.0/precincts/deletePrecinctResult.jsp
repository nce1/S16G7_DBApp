<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*, ccinfom.database.Precinct"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Delete Precinct Result</title>
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
        .result-container {
            background-color: #ffffff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            width: 500px;
            text-align: center;
        }
        h2 {
            color: #333;
        }
        .result-message {
            margin-top: 20px;
            font-size: 1.2em;
        }
        .back-btn {
            margin-top: 20px;
            padding: 10px;
            border: none;
            border-radius: 4px;
            background-color: #d9534f;
            color: white;
            cursor: pointer;
        }
        .back-btn:hover {
            background-color: #c9302c;
        }
    </style>
</head>
<body>
    <div class="result-container">
        <h2>Precinct Deletion Result</h2>

        <%
            // Retrieve the precinctID from the request
            String precinctIDParam = request.getParameter("precinctID");

            if (precinctIDParam != null && !precinctIDParam.isEmpty()) {
                try {
                    int precinctID = Integer.parseInt(precinctIDParam);

                    // Create an instance of Precinct class
                    Precinct precinctObj = new Precinct();
                    String resultMessage = precinctObj.deletePrecinct(precinctID);

                    // Display the result message
                    out.println("<div class='result-message'>" + resultMessage + "</div>");
                } catch (NumberFormatException e) {
                    // If the precinctID is not valid
                    out.println("<div class='result-message'>Invalid Precinct ID.</div>");
                }
            } else {
                out.println("<div class='result-message'>Please select a Precinct ID to delete.</div>");
            }
        %>

        <!-- Button to go back to the form -->
        <button class="back-btn" onclick="window.location.href='deletePrecinct.jsp'">Go Back</button>
    </div>
</body>
</html>

