<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page language="java" %>
<%@ page import="java.util.*, java.sql.Date, java.text.SimpleDateFormat, ccinfom.database.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Offenders</title>
    <style>
        body{
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #2c3e50; /* Dark grayish background */
            display: flex;
            flex-direction: column;
            align-items: center;
            height: 100vh;
            overflow-y: auto;
        }
        .container{
            width: 100%;
            max-width: 900px;
            padding: 30px;
            background-color: #34495e; /* Darker container */
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
            margin-top: 40px;
            box-sizing: border-box;
            flex: 1;
            overflow-y: auto;
            color: #ecf0f1; /* Light text color */
        }
        .header{
            font-size: 2em;
            font-weight: bold;
            color: #ecf0f1; /* Light text color */
            margin-bottom: 20px;
            text-align: center;
            background-color: #34495e;
            padding: 15px;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }
        .profile-detail{
            font-size: 1.2em;
            color: #bdc3c7; /* Lighter gray text */
            margin-bottom: 15px;
            transition: all 0.3s ease;
        }
        .profile-detail strong{
            color: #ecf0f1; /* Light text color */
            font-weight: bold;
        }
        .profile-detail:hover {
            background-color: #7f8c8d; /* Slightly lighter gray */
            border-left: 5px solid #2980b9; /* Blue highlight */
            padding-left: 15px;
        }
        .back-btn{
            position: absolute;
            top: 20px;
            left: 20px;
            padding: 10px 15px;
            background-color: #e74c3c; /* Red button */
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 1em;
            display: flex;
            align-items: center;
            gap: 8px;
            transition: all 0.3s ease;
        }
        .back-btn i{
            font-size: 1.2em;
        }
        .back-btn:hover{
            background-color: #c0392b; /* Darker red on hover */
            transform: scale(1.05);
        }
        @media (max-width: 768px){
            .container {
                padding: 20px;
            }

            .header{
                font-size: 1.6em;
            }

            .profile-detail{
                font-size: 1em;
            }
        }
    </style>
</head>
<body>
    <button class="back-btn" onclick="window.history.back()">
        <i class="fa fa-arrow-left"></i> Go Back
    </button>

    <div class="container">
        <jsp:useBean id="O" class="ccinfom.database.Offender" scope="session" />
        <div class="header">
            All Offenders 
        </div>

        <%
            O.getAllOffenders();
            for (int i = 0; i < O.backgroundIDList.size(); i++) {
        %>
            <div class="profile-detail"><strong>Case ID:</strong> <span><%= O.caseIDList.get(i) %></span></div>
            <div class="profile-detail"><strong>Background ID:</strong> <span><%= O.backgroundIDList.get(i) %></span></div>
            <div class="profile-detail"><strong>Offense:</strong> <span><%= O.offenseList.get(i) %></span></div>
            <div class="profile-detail"><strong>Status:</strong> <span><%= O.statusList.get(i) %></span></div>
            <hr>
        <%
            }
        %>
    </div>
    <script src="https://kit.fontawesome.com/a076d05399.js"></script>
</body>
</html>
