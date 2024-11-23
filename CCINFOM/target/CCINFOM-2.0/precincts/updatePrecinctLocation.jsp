<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*, ccinfom.database.Precinct"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Precinct Location</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            padding: 20px;
        }
        h1 {
            text-align: center;
            color: #333;
        }
        form {
            background-color: #ffffff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            width: 500px;
            margin: auto;
        }
        label {
            font-size: 1.2em;
            margin-bottom: 10px;
        }
        input[type="text"] {
            width: 100%;
            padding: 8px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 1em;
        }
        .submit-btn {
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            font-size: 1em;
            cursor: pointer;
        }
        .submit-btn:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <h1>Update Precinct Location</h1>

    <form action="updatePrecinctLocationResult.jsp" method="post">
        <label for="newCityJurisdiction">Enter New City Jurisdiction:</label>
        <input type="text" id="newCityJurisdiction" name="newCityJurisdiction" required>

        <button type="submit" class="submit-btn">Update Location</button>
    </form>
</body>
</html>

