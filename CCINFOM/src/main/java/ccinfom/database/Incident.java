
package ccinfom.database;
import java.sql.*;
import java.util.Set;
import java.util.ArrayList;

/**
 * Assume that the precinct already exists in the database.
 * 
 */
public class Incident {
    public int caseID;
    public String description;
    public String incident_type;
    public String status;
    public Date dateReported, dateOfOccurrence, dateResolved = null;
    public int precinctID;
    
    public static final Set<String> INCIDENT_TYPES = Set.of("Violent", "Property", "White-Collar", "Organized", "Cybercrime");
    public static final Set<String> STATUSES = Set.of("Under Investigation", "Forwarded to Prosecution", "Charges Filed", "Awaiting Trial", "Convicted", "Acquitted", "Dismissed");
    
    public ArrayList<Integer> caseIDList;
    public ArrayList<String> descriptionList;
    public ArrayList<String> incident_typeList;
    public ArrayList<String> statusList;
    public ArrayList<Date> dateReportedList;
    public ArrayList<Date> dateOfOccurrenceList;
    public ArrayList<Date> dateResolvedList;
    public ArrayList<Integer> precinctIDList;
    
    
    public Incident() {
        caseIDList = new ArrayList<>();
        descriptionList = new ArrayList<>();
        incident_typeList = new ArrayList<>();
        statusList = new ArrayList<>();
        dateReportedList = new ArrayList<>();
        dateOfOccurrenceList = new ArrayList<>();
        dateResolvedList = new ArrayList<>();
        precinctIDList = new ArrayList<>();
    }
    
     public boolean getIncidentList(int precinctID) {
        try {
            //establish conneciton to database
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn;
	    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/police_database?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            System.out.println("Connection successful");
            
            PreparedStatement stmt = conn.prepareStatement("SELECT * FROM incidents WHERE precinctID = ?");
            stmt.setInt(1, precinctID);
            
            ResultSet res = stmt.executeQuery();
            
            //clear all lists
            caseIDList.clear();
            descriptionList.clear();
            incident_typeList.clear();
            statusList.clear();
            dateReportedList.clear();
            dateOfOccurrenceList.clear();
            dateResolvedList.clear();
            precinctIDList.clear();
            
            this.precinctID = precinctID;
            
            while (res.next()) {
                this.caseID = res.getInt("caseID");
                this.description = res.getString("description");
                this.incident_type = res.getString("type");
                this.status = res.getString("status");
                this.dateReported = res.getDate("dateReported");
                this.dateOfOccurrence = res.getDate("dateOfOccurrence");
                this.dateResolved = res.getDate("dateResolved");
                
                //add records to the list
                caseIDList.add(caseID);
                descriptionList.add(description);
                incident_typeList.add(incident_type);
                statusList.add(status);
                dateReportedList.add(dateReported);
                dateOfOccurrenceList.add(dateOfOccurrence);
                dateResolvedList.add(dateResolved);
                precinctIDList.add(this.precinctID);
            }
            
            stmt.close();
            conn.close();
            
            return true;
        } catch (Exception e) {
            System.out.println(e.getMessage());
            return false;
        }
    }
    
    public boolean getIncidentList() {
        try {
            //establish conneciton to database
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn;
	    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/police_database?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            System.out.println("Connection successful");
            
            PreparedStatement stmt = conn.prepareStatement("SELECT * FROM incidents");
            
            ResultSet res = stmt.executeQuery();
            
            //clear all lists
            caseIDList.clear();
            descriptionList.clear();
            incident_typeList.clear();
            statusList.clear();
            dateReportedList.clear();
            dateOfOccurrenceList.clear();
            dateResolvedList.clear();
            precinctIDList.clear();
            
            while (res.next()) {
                this.caseID = res.getInt("caseID");
                this.description = res.getString("description");
                this.incident_type = res.getString("type");
                this.status = res.getString("status");
                this.dateReported = res.getDate("dateReported");
                this.dateOfOccurrence = res.getDate("dateOfOccurrence");
                this.dateResolved = res.getDate("dateResolved");
                this.precinctID = res.getInt("precinctID");
                
                //add records to the list
                caseIDList.add(caseID);
                descriptionList.add(description);
                incident_typeList.add(incident_type);
                statusList.add(status);
                dateReportedList.add(dateReported);
                dateOfOccurrenceList.add(dateOfOccurrence);
                dateResolvedList.add(dateResolved);
                precinctIDList.add(this.precinctID);
            }
            
            stmt.close();
            conn.close();
            
            return true;
        } catch (Exception e) {
            System.out.println(e.getMessage());
            return false;
        }
    }
    
    public boolean getIncidentListUnresolved(int precinctID) {
         try {
            //establish conneciton to database
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn;
	    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/police_database?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            System.out.println("Connection successful");
            
            PreparedStatement stmt = conn.prepareStatement("SELECT * FROM incidents WHERE precinctID = ? AND ISNULL(dateResolved)");
            stmt.setInt(1, precinctID);
            
            ResultSet res = stmt.executeQuery();
            
            //clear all lists
            caseIDList.clear();
            descriptionList.clear();
            incident_typeList.clear();
            statusList.clear();
            dateReportedList.clear();
            dateOfOccurrenceList.clear();
            dateResolvedList.clear();
            precinctIDList.clear();
            
            this.precinctID = precinctID;
            
            while (res.next()) {
                this.caseID = res.getInt("caseID");
                this.description = res.getString("description");
                this.incident_type = res.getString("type");
                this.status = res.getString("status");
                this.dateReported = res.getDate("dateReported");
                this.dateOfOccurrence = res.getDate("dateOfOccurrence");
                this.dateResolved = res.getDate("dateResolved");
                
                //add records to the list
                caseIDList.add(caseID);
                descriptionList.add(description);
                incident_typeList.add(incident_type);
                statusList.add(status);
                dateReportedList.add(dateReported);
                dateOfOccurrenceList.add(dateOfOccurrence);
                dateResolvedList.add(dateResolved);
                precinctIDList.add(this.precinctID);
            }
            
            stmt.close();
            conn.close();
            
            return true;
        } catch (Exception e) {
            System.out.println(e.getMessage());
            return false;
        }
    }
    
        public boolean getIncidentListWithFilter(String precinctID, String status, String incident_type, String dateFrom, String dateTo, String description) {
         try {
            //establish conneciton to database
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn;
	    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/police_database?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            System.out.println("Connection successful");
            
            int numArgs = 0;
            
            StringBuilder statement = new StringBuilder("SELECT * FROM incidents");
            
            if (!precinctID.equals("all") || !status.equals("all") || !incident_type.equals("all") || dateFrom != null || dateTo != null || description != null) {
                statement.append(" WHERE");
                
                if (!precinctID.equals("all")) {
                    statement.append(" precinctID = ");
                    statement.append(precinctID);
                    numArgs++;
                }
                
                if (!status.equals("all")) {
                    if (numArgs > 0) {
                        statement.append(" AND");
                    }
                    statement.append(" status = '");
                    statement.append(status);
                    statement.append("'");
                    numArgs++;
                }
                
                if (!incident_type.equals("all")) {
                    if (numArgs > 0) {
                        statement.append(" AND");
                    }
                    statement.append(" type = '");
                    statement.append(incident_type);
                    statement.append("'");
                    numArgs++;
                }
                
                if (dateFrom != null) {
                    if (numArgs > 0) {
                        statement.append(" AND");
                    }
                    statement.append(" dateReported >= '");
                    statement.append(dateFrom);
                    statement.append("'");
                    numArgs++;
                }
                
                if (dateTo != null) {
                    if (numArgs > 0)
                        statement.append(" AND");
                    statement.append(" dateReported <= '");
                    statement.append(dateTo);
                    statement.append("'");
                    numArgs++;
                }   
                
                if (description != null) {
                    if (numArgs > 0)
                        statement.append(" AND");
                    statement.append("description LIKE '");
                    statement.append(description);
                    statement.append("'");
                    numArgs++;
                }
            }
            
            statement.append(" ORDER BY caseID");
            
            System.out.println(statement); 
            PreparedStatement stmt = conn.prepareStatement(statement.toString());
            
            ResultSet res = stmt.executeQuery();
            
            //clear all lists
            caseIDList.clear();
            descriptionList.clear();
            incident_typeList.clear();
            statusList.clear();
            dateReportedList.clear();
            dateOfOccurrenceList.clear();
            dateResolvedList.clear();
            precinctIDList.clear();
            
            while (res.next()) {
                this.precinctID = res.getInt("precinctID");
                this.caseID = res.getInt("caseID");
                this.description = res.getString("description");
                this.incident_type = res.getString("type");
                this.status = res.getString("status");
                this.dateReported = res.getDate("dateReported");
                this.dateOfOccurrence = res.getDate("dateOfOccurrence");
                this.dateResolved = res.getDate("dateResolved");
                
                //add records to the list
                caseIDList.add(this.caseID);
                descriptionList.add(this.description);
                incident_typeList.add(this.incident_type);
                statusList.add(this.status);
                dateReportedList.add(this.dateReported);
                dateOfOccurrenceList.add(this.dateOfOccurrence);
                dateResolvedList.add(this.dateResolved);
                precinctIDList.add(this.precinctID);
            }
   
            stmt.close();
            conn.close();
            
            return true; 
        } catch (Exception e) {
            System.out.println(e.getMessage());
            return false;
        }
    }
    
    public boolean submitIncindent() {
        try {
            //get connection to database
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn;
	    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/police_database?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            System.out.println("Connection successful");
            
            //assign data
            //get last caseID
            PreparedStatement stmt = conn.prepareStatement("SELECT MAX(caseID) + 1 AS case_id FROM incidents");
            ResultSet res = stmt.executeQuery();
            
            while (res.next()) {
                this.caseID = res.getInt("case_id");
            }
            
            if (this.caseID == 0)
                this.caseID = 3000000;
            
            //prepare statement
            stmt = conn.prepareStatement("INSERT INTO incidents VALUES (?, ?, ?, ?, ?, ?, NULL, ?);");
            stmt.setInt(1, caseID);
            stmt.setString(2, description);
            stmt.setString(3, incident_type);
            stmt.setString(4, status);
            stmt.setDate(5, dateReported);
            stmt.setDate(6, dateOfOccurrence);
            stmt.setInt(7, precinctID);
            
            //execute statement
            stmt.executeUpdate();
            stmt.close();
            conn.close();
            
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean updateIncidentStatus(String newStatus, int caseID) {
        try { 
            //get connection to database
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn;
	    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/police_database?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            System.out.println("Connection successful");
            
            //prepare update statement
            PreparedStatement stmt = conn.prepareStatement("UPDATE incidents SET status = ? WHERE caseID = ?");
            stmt.setString(1, newStatus);
            stmt.setInt(2, caseID);
            
            stmt.executeUpdate();
            
            stmt.close();
            conn.close();
            
            return true;
        } catch (Exception e){
            System.out.println(e.getMessage());
            return false;
        }
    }
    
    public boolean getCaseInformation(int caseID) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn;
	    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/police_database?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            System.out.println("Connection successful");
            
            //prepare update statement
            PreparedStatement stmt = conn.prepareStatement("SELECT * FROM incidents WHERE caseID = ?");
            stmt.setInt(1, caseID);
            
            ResultSet res = stmt.executeQuery();
            
            while (res.next()) {
                this.description = res.getString("description");
                this.incident_type = res.getString("type");
                this.precinctID = res.getInt("precinctID");
                this.dateReported = res.getDate("dateReported");
                this.dateOfOccurrence = res.getDate("dateOfOccurrence");
                this.dateResolved = res.getDate("dateResolved");
                this.caseID = caseID;
                this.status = res.getString("status");
            }
            
            stmt.close();
            conn.close();
            
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean resolveCase(int caseID, Date date, String status) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn;
	    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/police_database?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            System.out.println("Connection successful");
            
            PreparedStatement stmt = conn.prepareStatement("UPDATE incidents set dateResolved = ?, status = ? WHERE caseID = ?");
            stmt.setDate(1, date);
            stmt.setString(2, status);
            stmt.setInt(3, caseID);
            
            stmt.executeUpdate();
            
            stmt.close();
            conn.close();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
        
    }
    
    public static void main(String[] args) {
        Incident i = new Incident();
        i.getIncidentListWithFilter("all", "all", "all", null, null, null);
        for (int j = 0; j < i.caseIDList.size(); j++) {
            System.out.println(i.caseIDList.get(j));
        }
    }
    
    
}