<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, java.sql.Date, java.text.SimpleDateFormat, ccinfom.database.*" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Suspect Profiling</title>
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
            .profile-container {
                background-color: #ffffff;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
                width: 400px;
                box-sizing: border-box;
            }
            h1, h3 {
                color: #333;
                margin: 10px 0;
            }
            h1 {
                font-size: 1.5em;
                text-align: center;
                border-bottom: 2px solid #f4f4f9;
                padding-bottom: 10px;
            }
            h3 {
                margin-top: 20px;
            }
            .profile-detail {
                display: flex;
                justify-content: space-between;
                font-size: 1em;
                color: #555;
                margin: 8px 0;
            }
            ul {
                list-style: none;
                padding: 0;
            }
            li {
                padding: 5px 0;
                border-bottom: 1px solid #ddd;
            }
            .button-group {
                display: flex;
                gap: 10px;
                margin-top: 20px;
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
        <jsp:useBean id="P" class="ccinfom.database.Person" scope="session" />
        <div class="container">
            <%
                // Retrieve inputs
                String vID = request.getParameter("id");
                String vLName = request.getParameter("lastName");
                String vFName = request.getParameter("firstName");

                // Ensure the input data is available
                if (vID != null && vLName != null && vFName != null) {
                    // Set properties in the Person object
                    P.id = Integer.parseInt(vID);
                    P.lName = vLName;
                    P.fName = vFName;

                    // Fetch the complete Person object from the database
                    Person p = P.getPerson(); // Assume this method fetches details from the database
                    session.setAttribute("person", p); // Save the person object in session

                    if (p.error.equals("false")) {
                        // Proceed to display the profile (content of your current suspectProfiling.jsp page)
                    } else {
                        out.println("<p>Error retrieving person details. Please try again.</p>");
                    }
                } else {
                    out.println("<p>Invalid input. Please provide all the required details.</p>");
                }
            %>
        </div>

        <div class="profile-container">
            <h1>Profile</h1>
            <%
                Person p = (Person) session.getAttribute("person");
                Profile profile = new Profile(p); // Create Profile instance with person
                profile.getOffense(); // Fetch offenses
                profile.getInvolvement(); // Fetch involvements

                if (p != null) {
            %>
                <div class="profile-detail"><strong>ID:</strong> <span><%= p.id %></span></div>
                <div class="profile-detail"><strong>Last Name:</strong> <span><%= p.lName %></span></div>
                <div class="profile-detail"><strong>First Name:</strong> <span><%= p.fName %></span></div>
                <div class="profile-detail"><strong>Birthday:</strong> <span><%= p.birthdate %></span></div>
                <div class="profile-detail"><strong>Sex</strong> <span><%= p.sex %></span></div>
                <div class="profile-detail"><strong>Profession:</strong> <span><%= p.profession %></span></div>
                <% if (!p.status.equals("Alive")) { %>
                    <div class="profile-detail"><strong>Date of Death:</strong> <span><%= p.dateOfDeath %></span></div>
                <% } %>
                <h3>Address:</h3>
                <div class="profile-detail"><strong>House Number:</strong> <span><%= p.houseNo %></span></div>
                <div class="profile-detail"><strong>Street:</strong> <span><%= p.street %></span></div>
                <div class="profile-detail"><strong>Baranggay:</strong> <span><%= p.baranggay %></span></div>
                <div class="profile-detail"><strong>City:</strong> <span><%= p.city %></span></div>
                <div class="profile-detail"><strong>Province:</strong> <span><%= p.province %></span></div>
                <div class="profile-detail"><strong>Region:</strong> <span><%= p.region %></span></div>
                <div class="profile-detail"><strong>Zip Code:</strong> <span><%= p.zipCode %></span></div>

                <h3>Offenses:</h3>
                <ul>
                    <% for (int i = 0; i < profile.caseIDOffList.size(); i++) { %>
                        <li>
                            <strong>Case ID:</strong> <%= profile.caseIDOffList.get(i) %><br>
                            <strong>Offense:</strong> <%= profile.offenseList.get(i) %><br>
                            <strong>Status:</strong> <%= profile.statusList.get(i) %>
                        </li>
                    <% } %>
                </ul>

                <h3>Involvements:</h3>
                <ul>
                    <% for (int i = 0; i < profile.caseIDInvList.size(); i++) { %>
                        <li>
                            <strong>Case ID:</strong> <%= profile.caseIDInvList.get(i) %><br>
                            <strong>Testimony:</strong> <%= profile.testimonyList.get(i) %><br>
                            <strong>Involvement:</strong> <%= profile.involvementList.get(i) %>
                        </li>
                    <% } %>
                </ul>

                <div class="button-group">
                    <button class="back-btn" onclick="history.back()">Back</button>
                </div>
            <% } else { %>
                <p>No person found in session.</p>
            <% } %>
        </div>
    </body>
</html>
