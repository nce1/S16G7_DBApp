<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="ccinfom.database.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manage Officers</title>
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
        <jsp:useBean id="O" class="ccinfom.database.Officer" scope="session" />
        <div class="container">
            <%  
                String temp = request.getParameter("pid");
                String vLName = request.getParameter("lastName");
                String vFName = request.getParameter("firstName");
                
                int vPID = -1;
                int vBID  = -1;
                try{
                    vPID = Integer.parseInt(temp);
                    temp = request.getParameter("id");
                    vBID = Integer.parseInt(temp);
                } catch(Exception e){
                    O.error = e.getMessage();
                }
                
                Person p = new Person();
                p.id = vBID;
                p.lName = vLName;
                p.fName = vFName;
                p.getPerson();
                
                if (!p.error.equals("false"))
                    O.error = "The individual does not exist. Please verify and try again.";
                
                O.policeID = vPID;
                O.id = vBID;
                if (!O.isDuplicate())
                    O.error = O.error+  "The officer does not exist. Please verify and try again.";
                if(p.error.equals("false") && O.isDuplicate()){
                    if(O.deleteOfficer()){
            %>            
                       <h1>Thank you for your service!</h1>
                       <p>Police ID: </p>
                       <p><%= O.policeID %></p>
            <%      } else{%>
                        <h1>Something went wrong.</h1>
                        <p><%= O.error %></p>
            <%      }
                } else { %>
                    <h1>Error</h1>
                    <h3><%= O.error %></h3>
            <%  } %>

            <div class="button-group">
                <button class="back-btn" onclick="window.location.href='../index.html'">Back to Main Menu</button>
            </div>
        </div>
    </body>
</html>
