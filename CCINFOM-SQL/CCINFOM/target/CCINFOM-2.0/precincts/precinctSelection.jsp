<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, ccinfom.database.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Select Precinct</title>
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
        form {
            background-color: #ffffff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            width: 500px;
            margin: auto;
        }
        label {
            font-size: 1.2em;
            margin-bottom: 10px;
        }
        select {
            width: 100%;
            padding: 8px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 1em;
        }
        .button-group {
            display: flex;
            gap: 10px;
            margin-top: 20px;
            grid-column: 1 / -1;
        }
        .submit-btn, .back-btn {
            flex: 1;
            padding: 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 1em;
        }
        .submit-btn {
            background-color: #4CAF50;
            color: white;
        }
        .submit-btn:hover {
            background-color: #45a049;
        }
        .back-btn {
            background-color: #d9534f;
            color: white;
        }
        .back-btn:hover {
            background-color: #c9302c;
        }
    </style>
</head>
<body>
    <h1>Select Precinct</h1>

    <form action="precinctOptions.jsp" method="get">
        <label for="precinctID">Choose a Precinct ID:</label>
        <select name="precinctID" id="precinctID" required>
            <%  
                // Fetch precinct IDs from the database
                Precinct precinctObj = new Precinct();
                int result = precinctObj.getPrecinctList(); // Get precinct list

                if (result == 1 && !precinctObj.precinctIDList.isEmpty()) {
                    for (int i = 0; i < precinctObj.precinctIDList.size(); i++) { 
            %>
                <option value="<%= precinctObj.precinctIDList.get(i) %>">
                    <%= precinctObj.precinctIDList.get(i) %>
                </option>
            <% 
                    }
                } else { 
            %>
                <option value="" disabled>No Precincts Available</option>
            <% 
                }
            %>
        </select>

        <div class="button-group">
            <button type="button" class="back-btn" onclick="history.back()">Back</button>
            <button type="submit" class="submit-btn">Submit</button>
        </div>
    </form>
</body>
</html>
