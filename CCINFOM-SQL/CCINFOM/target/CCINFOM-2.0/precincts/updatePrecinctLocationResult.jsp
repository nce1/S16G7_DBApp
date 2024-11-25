<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*, ccinfom.database.Precinct"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Precinct Location Results</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            padding: 20px;
        }
        h1 {
            text-align: center;
            color: #333;
        }
        .result-container {
            background-color: #ffffff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            width: 500px;
            margin: auto;
            text-align: center;
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
        <h1>Update Results</h1>

        <%
            // Retrieve form data from the request
            String precinctIDParam = request.getParameter("precinctID");
            String newCityJurisdiction = request.getParameter("newCityJurisdiction");

            if (precinctIDParam != null && !precinctIDParam.isEmpty() && newCityJurisdiction != null && !newCityJurisdiction.isEmpty()) {
                try {
                    int precinctID = Integer.parseInt(precinctIDParam);

                    // Create an instance of the Precinct class
                    Precinct precinctObj = new Precinct();
                    int result = precinctObj.updatePrecinctLocation(precinctID, newCityJurisdiction);

                    // Display the result of the update operation
                    if (result == 1) {
                        out.println("<div class='result-message'>Successfully updated the precinct location.</div>");
                    } else {
                        out.println("<div class='result-message'>Failed to update precinct location. Please check the Precinct ID.</div>");
                    }
                } catch (NumberFormatException e) {
                    out.println("<div class='result-message'>Invalid Precinct ID format.</div>");
                }
            } else {
                out.println("<div class='result-message'>Please fill in all fields.</div>");
            }
        %>

        <!-- Button to go back to the update form -->
        <button class="back-btn" onclick="window.location.href='updatePrecinctLocation.jsp'">Go Back</button>
    </div>
</body>
</html>

