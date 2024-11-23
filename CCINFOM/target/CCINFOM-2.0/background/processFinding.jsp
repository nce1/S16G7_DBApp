<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="ccinfom.database.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Find Person</title>
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
            .container {
                background-color: #ffffff;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
                width: 400px;
                box-sizing: border-box;
                text-align: center;
            }
            h1 {
                color: #333;
            }
            h3 {
                color: #d9534f;
            }
            .button-group {
                display: flex;
                flex-direction: column;
                gap: 10px;
                margin-top: 20px;
            }
            .submit-btn, .back-btn {
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
                String vID = request.getParameter("id");
                String vLName = request.getParameter("lastName");
                String vFName = request.getParameter("firstName");
            
                if (vID != null){
                    session.setAttribute("personId", vID);
                    session.setAttribute("lastName", vLName);
                    session.setAttribute("firstName", vFName);
                } else{
                    vID = (String) session.getAttribute("personId");
                    vLName = (String) session.getAttribute("lastName");
                    vFName = (String) session.getAttribute("firstName");
                }
            
                P.id = Integer.parseInt(vID);
                P.lName = vLName;
                P.fName = vFName;
                Person p = P.getPerson();
                session.setAttribute("person", p);
                if(p.error.equals("false")){
            %>
                    <h1>Person found!</h1>
                    <div class="button-group">
                        <a href="displayProfile.jsp" class="submit-btn">Display Profile</a>
                        <a href="updateName.jsp" class="submit-btn">Update Name</a>
                        <a href="updateAddress.jsp" class="submit-btn">Update Address</a>
                        <a href="updateStatus.jsp" class="submit-btn">Update Status</a>
                    </div>
            <%  } else { %>
                    <h1>Error</h1>
                    <h3><%= p.error %></h3>
            <%  } %>

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
