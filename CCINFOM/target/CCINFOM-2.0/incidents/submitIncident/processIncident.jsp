<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import = "java.util.*, java.sql.Date, java.text.SimpleDateFormat, ccinfom.database.Precinct, ccinfom.database.Incident, ccinfom.database.Common" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Incident Processing</title>
    </head>
    <body>
        <form action="../../index.html">
            <jsp:useBean id ="incdt" class="ccinfom.database.Incident" scope="session" />
            <jsp:useBean id ="prtcpnt" class="ccinfom.database.Participant" scope="session"/>
            <%
                //prepare values for record creation
                incdt.description = request.getParameter("description");
                incdt.incident_type = request.getParameter("incident_type");
                incdt.status = request.getParameter("status");
                String temp_dateR = request.getParameter("dateReported");
                String temp_dateO = request.getParameter("dateOfOccurrence");
                incdt.precinctID = Integer.parseInt(request.getParameter("precinctID"));
                
                Date valDateOfOccurrence = Common.toDate(temp_dateO);
                Date valDateReported = Common.toDate(temp_dateR);
                
                incdt.dateOfOccurrence = valDateOfOccurrence;
                incdt.dateReported = valDateReported;
                
                boolean res = incdt.submitIncindent();
                
                prtcpnt.caseID = incdt.caseID;
                prtcpnt.backgroundId = Integer.parseInt(request.getParameter("backgroundId"));
                prtcpnt.involvement = request.getParameter("involvement");
                prtcpnt.testimony = request.getParameter("testimony");
                
                boolean res2 = prtcpnt.addParticipant();
          
                if (res && res2) { %>
            <h1>Incident submitted</h1>
            <% } else if (res && !res2) { %>
            <h1>Error submitting incident</h1>
            <% } else { %>
            <h1>Error adding participant</h1>
            <% } %>
            <input type="submit" value="Return to Menu">
        </form>
    </body>
</html>
