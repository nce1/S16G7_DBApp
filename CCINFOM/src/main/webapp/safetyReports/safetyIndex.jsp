<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, java.sql.Date, java.text.SimpleDateFormat, ccinfom.database.*" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>City Ranking</title>
        <style>
            body {
                font-family: 'Roboto', sans-serif;
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: 100vh;
                margin: 0;
                background-color: #e8f5fe;
            }
            .container {
                background-color: #ffffff;
                padding: 30px;
                border-radius: 12px;
                box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2);
                width: 500px;
                text-align: center;
                box-sizing: border-box;
            }
            h1 {
                color: #2c3e50;
                font-size: 1.8em;
                margin-bottom: 15px;
            }
            p {
                color: #34495e;
                font-size: 1em;
                margin: 10px 0;
            }
            .highlight {
                color: #2980b9;
                font-weight: bold;
            }
            .info {
                margin: 20px 0;
                color: #7f8c8d;
                font-size: 0.9em;
            }
            .button-group {
                display: flex;
                gap: 15px;
                margin-top: 20px;
                justify-content: center;
            }
            .back-btn, .submit-btn {
                padding: 10px 25px;
                border: none;
                border-radius: 6px;
                cursor: pointer;
                font-size: 1em;
                font-weight: bold;
                color: white;
                transition: 0.3s;
            }
            .submit-btn {
                background-color: #27ae60;
            }
            .submit-btn:hover {
                background-color: #1e8449;
            }
            .back-btn {
                background-color: #e74c3c;
            }
            .back-btn:hover {
                background-color: #c0392b;
            }
            select {
                width: 100%;
                padding: 8px;
                border-radius: 4px;
                border: 1px solid #ccc;
                font-size: 1em;
                margin-top: 10px;
            }
            .cities-list {
                background: #ecf0f1;
                padding: 15px;
                margin-top: 20px;
                border-radius: 8px;
                text-align: left;
                font-size: 0.95em;
            }
            .cities-list p {
                margin: 5px 0;
            }
            .safe {
                color: #2ecc71;
            }
            .unsafe {
                color: #e74c3c;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>Update Your Address</h1>
            <p>Below is a list of cities ranked from <span class="highlight">safest</span> to <span class="highlight">unsafest</span> based on reported crime data.</p>

            <div class="cities-list">
                <h3>City Safety Rankings:</h3>
                <%
                    ArrayList<String> sortedCities = Common.formatText();
                    int rank = 1;
                    int lTotal = 0;
                    int index = 0;
                    for (Map.Entry<String, Integer> entry : Common.cityTotal.entrySet()){
                        if (index != 0 && entry.getValue() != lTotal){
                            rank = index + 1;
                        } 
                        lTotal = entry.getValue();
                        index++;
                        String safetyClass = rank == 1 ? "safe" : rank == Common.cityTotal.size() ? "unsafe" : "";
                %>
                        <p class="<%= safetyClass %>"><strong>Rank <%= rank %>: </strong> <%= entry.getKey() %></p>
                <%  } %>
            </div>

            <p class="info">Select a city from the dropdown below to view the crime distribution.</p>

            <form action="displayChart.jsp" method="GET">
                <label for="city">City:</label>
                <select name="city" id="city" required>
                    <option value="">Select</option>
                    <%  
                        for (Map.Entry<String, Integer> entry : Common.cityTotal.entrySet()){
                            if (entry.getValue() != 0){
                    %>
                            <option value="<%= entry.getKey() %>"><%= entry.getKey() %></option>
                    <% 
                            }
                        } 
                    %>
                </select>
                <div class="button-group">
                    <button type="button" class="back-btn" onclick="window.location.href='../index.html'">Return</button>
                    <button type="submit" class="submit-btn">Submit</button>
                </div>
            </form>
        </div>
    </body>
</html>
