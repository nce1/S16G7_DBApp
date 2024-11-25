<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="ccinfom.database.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Crime Distribution</title>
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <style>
            body {
                font-family: Arial, sans-serif;
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
                min-height: 100vh;
                margin: 0;
                background-color: #f4f4f9;
            }
            .chart-container {
                width: 80%;
                max-width: 600px;
                background-color: #ffffff;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            }
            h1 {
                color: #2c3e50;
                margin-bottom: 20px;
            }
            .button-container {
                margin-top: 20px;
            }
            .back-btn {
                padding: 10px 20px;
                font-size: 1em;
                border: none;
                border-radius: 4px;
                background-color: #3498db;
                color: white;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }
            .back-btn:hover {
                background-color: #2980b9;
            }
        </style>
    </head>
    <body>
        <%
            // Get the selected city name from the dropdown
            String cityName = request.getParameter("city");
            Map<String, Integer> data = Common.getCityMap(cityName);
        %>

        <h1>Crime Distribution in <%= cityName %></h1>

        <div class="chart-container">
            <canvas id="crimeChart"></canvas>
        </div>

        <div class="button-container">
            <button class="back-btn" onclick="window.location.href='../index.html'">Back</button>
        </div>

        <script>
            const crimeLabels = [];
            const crimeValues = [];
            const barColors = [];

            function getRandomColor() {
                const letters = '0123456789ABCDEF';
                let color = '#';
                for (let i = 0; i < 6; i++) {
                    color += letters[Math.floor(Math.random() * 16)];
                }
                return color;
            }

            <% if (data != null) {
                for (Map.Entry<String, Integer> entry : data.entrySet()) { 
            %>
                crimeLabels.push("<%= entry.getKey() %>");
                crimeValues.push(<%= entry.getValue() %>);
                barColors.push(getRandomColor());
            <% } } %>

            const ctx = document.getElementById('crimeChart').getContext('2d');
            new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: crimeLabels,
                    datasets: [{
                        label: 'Number of Crimes',
                        data: crimeValues,
                        backgroundColor: barColors,
                        borderColor: barColors.map(color => color.replace(/[^#0-9a-f]/gi, '')),
                        borderWidth: 1
                    }]
                },
                options: {
                    responsive: true,
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    }
                }
            });
        </script>
    </body>
</html>
