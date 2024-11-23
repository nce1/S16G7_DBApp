<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, ccinfom.database.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Case Assignment</title>
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
    <form action="assignCaseResults.jsp" method="get">
        <h2>Assigning Case to an Officer</h2>

        <!-- Police ID Dropdown -->
        <label for="policeID">Select Police ID:</label>
        <select name="policeID" id="policeID" required>
            <%  
                // Fetch the police IDs from the Case class
                Case caseObj = new Case();
                caseObj.getPoliceList(); // Method to retrieve all police IDs
                for (int i = 0; i < caseObj.allPoliceIdList.size(); i++) { 
            %>
                <option value="<%= caseObj.allPoliceIdList.get(i) %>"> <%= caseObj.allPoliceIdList.get(i) %> </option>
            <% 
                }
            %>
        </select>

        <!-- Case ID Dropdown -->
        <label for="caseID">Select Case ID:</label>
        <select name="caseID" id="caseID" required>
            <%  
                // Fetch the case IDs from the Case class
                Case caseObj2 = new Case();
                caseObj2.getCaseList(); // Method to retrieve all case IDs
                for (int i = 0; i < caseObj2.allCaseIdList.size(); i++) { 
            %>
                <option value="<%= caseObj2.allCaseIdList.get(i) %>"> <%= caseObj2.allCaseIdList.get(i) %> </option>
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


