<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, ccinfom.database.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Precinct Activity</title>
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
        form {
            background-color: #ffffff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            width: 500px;
            box-sizing: border-box;
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }
        h2 {
            color: #333;
            font-size: 1.5em;
            margin-bottom: 20px;
            text-align: center;
            grid-column: 1 / -1;
        }
        label {
            font-size: 0.9em;
            color: #555;
            display: block;
            margin-bottom: 5px;
        }
        select {
            width: 100%;
            padding: 8px;
            margin: 5px 0 15px 0;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
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
    <form action="precinctActivity.jsp" method="get">
        <h2>Precinct Activity</h2>

        <!-- Precinct Dropdown -->
        <label for="precinctID">Select Precinct ID:</label>
        <select name="precinctID" id="precinctID" required>
            <%  
                // Instantiate the Precinct object
                Precinct precinctObj = new Precinct();
                int result = precinctObj.getPrecinctList(); // Fetch precinct IDs from the database
                
                // Check if data was successfully retrieved
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
        
        <!-- Month-Year Dropdown -->
        <label for="monthYear">Select Month and Year:</label>
        <select name="monthYear" id="monthYear" required>
            <option value="">-- Select Month-Year --</option>
            <%
                // Array of month names
                String[] months = {
                    "January", "February", "March", "April", "May", "June",
                    "July", "August", "September", "October", "November", "December"
                };

                // Fetch unique month-year combinations from the database
                List<String> monthYears = precinctObj.getMonthYears();

                // Generate dropdown options
                for (String monthYear : monthYears) {
                    String[] parts = monthYear.split("-"); // Split "month-year" into components
                    int month = Integer.parseInt(parts[0]); // Extract month
                    int year = Integer.parseInt(parts[1]); // Extract year
            %>
                <option value="<%= monthYear %>"><%= months[month - 1] %> <%= year %></option>
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
