<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, java.sql.Date, java.text.SimpleDateFormat, ccinfom.database.*" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manage Officers</title>
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
            .container{
                background-color: #ffffff;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
                width: 400px;
                text-align: center;
                box-sizing: border-box;
            }
            h1{
                color: #333;
                font-size: 1.5em;
                margin-bottom: 20px;
            }
            p{
                color: #555;
                font-size: 1.2em;
            }
            .button-group{
                display: flex;
                gap: 10px;
                margin-top: 20px;
                justify-content: center;
            }
            .back-btn, .submit-btn{
                padding: 10px 20px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                font-size: 1em;
                color: white;
            }
            .submit-btn{
                background-color: #4CAF50;
            }
            .submit-btn:hover{
                background-color: #45a049;
            }
            .back-btn{
                background-color: #d9534f;
            }
            .back-btn:hover{
                background-color: #c9302c;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <jsp:useBean id="O" class="ccinfom.database.Officer" scope="session" />
            <%  
                String vPID = request.getParameter("pID");
                String vPosition = request.getParameter("position");
                String vPrecinct = request.getParameter("precinct");

                if (vPosition == null && vPrecinct == null){
            %>
                <h1>Please select at least one option from Available Positions or Open Precincts.</h1>
                <p>Please try again.</p>
            <%
                } else{
                    O.flag = 4;
                    O.policeID = Integer.parseInt(vPID);
                    O.position = vPosition;
                    if (vPrecinct != null && !O.position.equals("Select")){
                        try{
                            O.precinctID = Integer.parseInt(vPrecinct);
                        } catch(Exception e){
                            O.error = e.getMessage();
                        }
                    } else if (vPrecinct != null){
                        O.precinctID = Integer.parseInt(vPrecinct);
                        O.flag = 1;
                    } else
                        O.flag = 2;
                    
                    if (O.updateHistory()){
            %>
                    <h1>Your application has been approved!</h1>
            <%
                    } else {
            %>
                    <h1>Something went wrong.</h1>
                    <p><%= O.error %></p>
            <%
                    }
                }
            %>
            <div class="button-group">
                <button type="button" class="back-btn" onclick="window.location.href='../index.html'">Return</button>
            </div>
        </div>
    </body>
</html>
