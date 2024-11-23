<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="ccinfom.database.*"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Police Database Application</title>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: #f0f4f8;
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: 100vh;
                color: #333;
            }
            .container {
                background-color: #ffffff;
                padding: 30px;
                border-radius: 12px;
                box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
                width: 100%;
                max-width: 450px;
                text-align: center;
            }
            h1 {
                font-size: 2rem;
                color: #2d2d2d;
                margin-bottom: 20px;
            }
            h3 {
                font-size: 1.2rem;
                color: #e74c3c;
                margin-bottom: 25px;
            }
            .button-group {
                display: flex;
                flex-direction: column;
                gap: 15px;
                margin-top: 30px;
            }
            a {
                display: block;
                text-decoration: none;
                background-color: #3498db;
                color: #fff;
                padding: 12px;
                border-radius: 6px;
                font-size: 1.1rem;
                transition: background-color 0.3s ease;
            }
            a:hover {
                background-color: #2980b9;
            }
            .back-btn {
                background-color: #e74c3c;
                color: white;
                padding: 12px;
                font-size: 1.1rem;
                border-radius: 6px;
                cursor: pointer;
                border: none;
                transition: background-color 0.3s ease;
            }
            .back-btn:hover {
                background-color: #c0392b;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>Manage Offenders</h1>
            <div class="button-group">
                <a href="registerSuspect.jsp">Add Offender</a>
                <a href="updateStatus.jsp">Update Suspect Status</a>
                <a href="viewOffenders.jsp">View Offenders</a>
                <a href="deleteOffender.jsp">Delete Entry</a>
            </div>
            <div class="button-group">
                <button class="back-btn" onclick="clearSessionAndRedirect()">Back to Main Menu</button>
            </div>
        </div>

        <script>
            function clearSessionAndRedirect() {
                window.location.href = '../index.html';
            }
        </script>
    </body>
</html>
