<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page language="java" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Name Form</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
            form{
                background-color: #ffffff;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
                width: 400px;
                box-sizing: border-box;
                display: grid;
                gap: 10px;
            }
            h2{
                color: #333;
                font-size: 1.5em;
                margin-bottom: 20px;
                text-align: center;
                grid-column: 1 / -1;
            }
            label{
                font-size: 1.2em;
                color: #555;
                margin-bottom: 2px;
            }
            input[type="text"], input[type="number"]{
                width: 100%;
                padding: 8px;
                border: 1px solid #ccc;
                border-radius: 4px;
                box-sizing: border-box;
                font-size: 1em;
                margin-bottom: 10px;
            }
            .button-group{
                display: flex;
                gap: 10px;
                margin-top: 20px;
                grid-column: 1 / -1;
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
            .back-btn{
                background-color: #d9534f;
                color: white;
            }
            .back-btn:hover{
                background-color: #c9302c;
            }
        </style>
    </head>
    <body>
        <form action="processName.jsp">
            <h2>Update Name</h2>

            <label for="lName">Last name:</label>
            <input type="text" id="lName" name="lName" required>
            
            <label for="fName">First name:</label>
            <input type="text" id="fName" name="fName" required>

            <div class="button-group">
                <button type="button" class="back-btn" onclick="history.back()">Back</button>
                <button type="submit" class="submit-btn">Submit</button>
            </div>
        </form>
    </body>
</html>