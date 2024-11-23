<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, java.sql.Date, java.text.SimpleDateFormat, ccinfom.database.*" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Profile</title>
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
            .profile-container{
                background-color: #ffffff;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
                width: 400px;
                box-sizing: border-box;
            }
            h1, h3{
                color: #333;
                margin: 10px 0;
            }
            h1{
                font-size: 1.5em;
                text-align: center;
                border-bottom: 2px solid #f4f4f9;
                padding-bottom: 10px;
            }
            h3{
                margin-top: 20px;
            }
            .profile-detail{
                display: flex;
                justify-content: space-between;
                font-size: 1em;
                color: #555;
                margin: 8px 0;
            }
            .button-group{
                display: flex;
                gap: 10px;
                margin-top: 20px;
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
            .back-btn {
                background-color: #d9534f;
                color: white;
            }
            .back-btn:hover{
                background-color: #c9302c;
            }
        </style>
    </head>
    <body>
        <div class="profile-container">
            <h1>Profile</h1>
            <%
                Person p = (Person) session.getAttribute("person");
                if (p != null){
            %>
                <div class="profile-detail"><strong>ID:</strong> <span><%= p.id %></span></div>
                <div class="profile-detail"><strong>Last Name:</strong> <span><%= p.lName %></span></div>
                <div class="profile-detail"><strong>First Name:</strong> <span><%= p.fName %></span></div>
                <div class="profile-detail"><strong>Birthdate:</strong> <span><%= p.birthdate %></span></div>
                <div class="profile-detail"><strong>Profession:</strong> <span><%= p.profession %></span></div>
                <% if (!p.status.equals("Alive")){%>
                    <div class="profile-detail"><strong>Date of Death:</strong> <span><%= p.dateOfDeath %></span></div>
                <%}%>
                <h3>Address:</h3>
                <div class="profile-detail"><strong>House Number:</strong> <span><%= p.houseNo %></span></div>
                <div class="profile-detail"><strong>Street:</strong> <span><%= p.street %></span></div>
                <div class="profile-detail"><strong>Baranggay:</strong> <span><%= p.baranggay %></span></div>
                <div class="profile-detail"><strong>City:</strong> <span><%= p.city %></span></div>
                <div class="profile-detail"><strong>Province:</strong> <span><%= p.province %></span></div>
                <div class="profile-detail"><strong>Region:</strong> <span><%= p.region %></span></div>
                <div class="profile-detail"><strong>Zip Code:</strong> <span><%= p.zipCode %></span></div>
                <div class="button-group">
                <button class="back-btn" onclick="history.back()">Back</button>
            </div>
            <%  } else { %>
            <p>No person found in session.</p>
            <%  } %>
        </div>
    </body>
</html>
