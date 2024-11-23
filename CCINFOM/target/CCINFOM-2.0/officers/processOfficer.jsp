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
                String vID = request.getParameter("id");
                String vLName = request.getParameter("lastName");
                String vFName = request.getParameter("firstName");
                String temp = request.getParameter("precinct");
                int vPrecinct = -1;
                
                try{
                    vPrecinct = Integer.parseInt(temp);
                } catch(Exception e){
                    O.error = "Please select a precinct";
                }
                
                Person p = new Person();
                p.id = Integer.parseInt(vID);
                p.lName = vLName;
                p.fName = vFName;
                p.getPerson();
                if (!p.error.equals("false"))
                    O.error = "The individual does not exist. Please verify and try again.";
                else if (p.dateOfDeath != null)
                    O.error = "This individual cannot be registered.";    
                
                if(p.error.equals("false") && vPrecinct != -1 && p.dateOfDeath == null){
                    O.id = p.id;
                    O.precinctID = vPrecinct;
                    if(O.addOfficer()){
                        p.updateProfession(O.id);
            %>            
                       <h1>Congratulations, Officer!</h1>
                       <p>Police ID: </p>
                       <p><%= O.policeID %></p>
                       <p><%= p.error %></p>

            <%      } else{%>
                        <h1>Something went wrong.</h1>
                        <p><%= p.error %></p>
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
