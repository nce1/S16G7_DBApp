<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, java.sql.Date, java.text.SimpleDateFormat, ccinfom.database.*" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Address</title>
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
            <jsp:useBean id="P" class="ccinfom.database.Person" scope="session" />
            <%
                Person p = (Person) session.getAttribute("person");
                if (p != null) {
                    String vHouseNo = request.getParameter("houseNo");
                    String vStreet = request.getParameter("street");
                    String vBaranggay = request.getParameter("baranggay");
                    String vCity = request.getParameter("city");
                    String vProvince = request.getParameter("province");
                    String vRegion = request.getParameter("region");
                    String vZipCode = request.getParameter("zipCode");

                    P.addressId = p.addressId;
                    P.houseNo = vHouseNo;
                    P.street = vStreet;
                    P.baranggay = vBaranggay;
                    P.city = vCity;
                    P.province = vProvince;
                    P.region = vRegion;
                    P.zipCode = vZipCode;

                    if (P.updateAddress()){
            %>
                        <h1>Address Updated Successfully</h1>
                        <p>Their address details have been updated.</p>
            <% 
                    } else{ 
            %>
                        <h1>Error Updating Address</h1>
                        <p><%= P.error %></p>
            <% 
                    }
                } else{ 
            %>
                    <h1>No Person Found</h1>
                    <p>Please try again.</p>
            <% 
                } 
            %>
            <div class="button-group">
                <button type="button" class="back-btn" onclick="window.location.href='processFinding.jsp'">Return</button>
            </div>
        </div>
    </body>
</html>
