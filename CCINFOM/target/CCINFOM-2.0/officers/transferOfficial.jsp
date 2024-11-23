<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page language="java" %>
<%@page import="java.util.*, java.sql.Date, java.text.SimpleDateFormat, ccinfom.database.*" %>

<!DOCTYPE html>
<html>
    <head>
        <title>Manage Officers</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>
            body{
                font-family: Arial, sans-serif;
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: 100vh;
                margin: 0;
                background-color: #f4f4f9;
            }
            form{
                background-color: #ffffff;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
                width: 400px;
                box-sizing: border-box;
                display: grid;
                gap: 10px;
            }
            h2{
                color: #333;
                font-size: 1.5em;
                margin-bottom: 20px;
                text-align: center;
                grid-column: 1 / -1;
            }
            label{
                font-size: 1.2em;
                color: #555;
                margin-bottom: 2px;
            }
            input[type="text"], input[type="number"]{
                width: 100%;
                padding: 8px;
                border: 1px solid #ccc;
                border-radius: 4px;
                box-sizing: border-box;
                font-size: 1em;
                margin-bottom: 10px;
            }
            .button-group{
                display: flex;
                gap: 10px;
                margin-top: 20px;
                grid-column: 1 / -1;
            }
            .submit-btn, .back-btn{
                flex: 1;
                padding: 10px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                font-size: 1em;
            }
            .submit-btn{
                background-color: #4CAF50;
                color: white;
            }
            .submit-btn:hover{
                background-color: #45a049;
            }
            .back-btn{
                background-color: #d9534f;
                color: white;
            }
            .back-btn:hover{
                background-color: #c9302c;
            }
            /* Enhancements for select styling */
            select {
                width: 100%;
                padding: 8px;
                border: 1px solid #ccc;
                border-radius: 4px;
                box-sizing: border-box;
                font-size: 1em;
                background-color: #fff;
                color: #555;
                -webkit-appearance: none; /* Hides the default arrow in Chrome */
                -moz-appearance: none; /* Hides the default arrow in Firefox */
                appearance: none; /* Modern browsers */
                background-image: url('data:image/svg+xml;charset=US-ASCII,%3Csvg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 4 5"%3E%3Cpath fill="%23333" d="M2 0L0 2h4zm0 5L0 3h4z"/%3E%3C/svg%3E');
                background-repeat: no-repeat;
                background-position: right 10px center;
                background-size: 8px 10px;
            }
            select:hover {
                border-color: #888;
            }
            select:focus {
                outline: none;
                border-color: #4CAF50;
                box-shadow: 0 0 5px rgba(76, 175, 80, 0.5);
            }
        </style>
    </head>
    <body>
        <form action="processTransfer.jsp" method="get" onsubmit="return validateInteger()">
            <jsp:useBean id="O" class="ccinfom.database.Officer" scope="session" />
            <h2>Transfer Precinct/Apply for a Position</h2>

            <label for="pID">Police ID:</label>
            <input type="number" id="pID" name="pID" required>
            
            <label for="position">Available Positions:</label>
            <select name="position" id="position">
            <%  
                for (int i = 0; i < O.positions.size(); i++) { 
            %>
                <option value="<%= O.positions.get(i) %>"> <%= O.positions.get(i) %> </option>
            <% 
                }
            %>
            </select>
            
            <label for="precinct">Open Precincts:</label>
            <select name="precinct" id="precinct">
            <option value="null"> <%= "Select" %> </option>
            <%  
                Precinct p = new Precinct();
                p.getPrecinctList();
                
                for (int i = 0; i < p.precinctIDList.size(); i++) { 
            %>
                <option value="<%= p.precinctIDList.get(i) %>"> <%= p.cityJurisdictionList.get(i) %> </option>
            <% 
                }
            %>
            </select>
            
            <h5>Note: Subject for Approval</h5>
            <div class="button-group">
                <button type="button" class="back-btn" onclick="history.back()">Back</button>
                <button type="submit" class="submit-btn">Submit</button>
            </div>
        </form>
        <script>
        function validateInteger(){
            const input = document.getElementById("pID").value;
            if (input.length === 5) {
                return true;
            } else{
                document.getElementById("output").textContent = "Please enter a valid ID number.";
                return false;
            }
        }
        </script>
    </body>
</html>
