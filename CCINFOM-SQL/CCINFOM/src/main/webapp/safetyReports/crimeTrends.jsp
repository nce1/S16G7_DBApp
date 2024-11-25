<%@ page import="java.util.*, ccinfom.database.*" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Crime Types Distribution</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script> <!-- Chart.js for pie chart -->
    <style>
        body {
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: flex-start;
            flex-direction: column;
            margin: 0;
            background-color: #f4f4f9;
        }

        .container {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            width: 80%;
            margin-bottom: 40px;
        }

        .list-container {
            width: 30%;
        }

        .pie-chart-container {
            width: 60%;
        }

        h1 {
            text-align: center;
        }

        h2 {
            color: #333;
            font-size: 1.5em;
            margin-bottom: 20px;
        }

        ul {
            list-style-type: none;
            padding: 0;
        }

        li {
            margin: 5px 0;
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

        /* Style for the table displaying monthly crime data */
        .table-container {
            width: 80%;
            margin: 20px auto;
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            padding: 10px;
            text-align: center;
            border: 1px solid #ddd;
        }

        th {
            background-color: #f4f4f9;
            color: #333;
        }

        tbody tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        /* Ensure the table scrolls if too wide */
        .scrollable-table {
            max-height: 400px;
            overflow-y: auto;
        }

    </style>
</head>
<body>
    <h1>Crime Types Distribution</h1>

    <div class="container">
        <!-- Pie Chart Container -->
        <div class="pie-chart-container">
            <canvas id="crimePieChart" width="400" height="400"></canvas>
        </div>

        <!-- Top 5 Crime Types List -->
        <div class="list-container">
            <h2>Crime Types</h2>
            <ul>
                <% 
                    Crime crimeObj = new Crime();
                    List<Map<String, Object>> allCrimeTypes = crimeObj.getAllCrimeTypes();
                    for (Map<String, Object> crimeData : allCrimeTypes) { 
                %>
                    <li><%= crimeData.get("crime_type") %>: <%= crimeData.get("count") %> cases</li>
                <% } %>
            </ul>
        </div>
    </div>

    <!-- Monthly and Yearly Crime Frequency Table -->
    <div class="table-container">
        <h2>Crime Frequency by Month and Year</h2>
        <div class="scrollable-table">
            <table>
                <thead>
                    <tr>
                        <th>Year</th>
                        <th>Month</th>
                        <th>Crime Type</th>
                        <th>Frequency</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                        // Get monthly crime data
                        List<Map<String, Object>> crimeFreqData = crimeObj.getCrimeFrequency(); 
                        for (Map<String, Object> data : crimeFreqData) {
                    %>
                        <tr>
                            <td><%= data.get("report_year") %></td>
                            <td><%= data.get("report_month") %></td>
                            <td><%= data.get("crime_type") %></td>
                            <td><%= data.get("frequency") %></td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>

    <div class="button-group">
        <button class="back-btn" onclick="history.back()">Back</button>
    </div>

    <script>
        var ctx = document.getElementById('crimePieChart').getContext('2d');
        
        <% 
            // Get all crime types for the pie chart
            List<Map<String, Object>> crimeTypes = crimeObj.getAllCrimeTypes();
        %>

        var crimeData = {
            labels: [<% 
                for (Map<String, Object> crimeData : crimeTypes) { 
                    out.print("\"" + crimeData.get("crime_type") + "\",");
                }
            %>],
            datasets: [{
                data: [<% 
                    for (Map<String, Object> crimeData : crimeTypes) { 
                        out.print(crimeData.get("count") + ",");
                    }
                %>],
                backgroundColor: ['#FF6384', '#36A2EB', '#FFCE56', '#FF9F40', '#4BC0C0'],
                hoverOffset: 4
            }]
        };

        var myPieChart = new Chart(ctx, {
            type: 'pie',
            data: crimeData,
            options: {
                responsive: true,
                plugins: {
                    legend: {
                        position: 'top'
                    },
                    tooltip: {
                        callbacks: {
                            label: function(tooltipItem) {
                                var label = crimeData.labels[tooltipItem.dataIndex];
                                return ${label};
                            }
                        }
                    }
                }
            }
        });
    </script>
</body>
</html>


