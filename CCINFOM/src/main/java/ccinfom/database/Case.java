/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package ccinfom.database;

import java.util.ArrayList;
import java.sql.*;
public class Case {
    public int policeId, caseId;
    
    public ArrayList<String> officerNames = new ArrayList<>();
    public ArrayList<Integer> policeIdList = new ArrayList<>();
    public ArrayList<Integer> caseIdList = new ArrayList<>();
    public ArrayList<Integer> allPoliceIdList = new ArrayList<>();
    public ArrayList<Integer> allCaseIdList = new ArrayList<>();
    public String error = null;
    
    public Case(){
        
    }
    
    // Method to check if the precinctID of a case matches the precinctID of an officer
    public boolean checkPrecinct() {
        // Declare variables to hold the precinctIDs
        int casePrecinctID = -1;
        int officerPrecinctID = -1;
    
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/police_database?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");

            // Query to get the precinctID for the given caseID from the incidents table
            String caseQuery = "SELECT precinctID FROM incidents WHERE caseID = ?";
            PreparedStatement pstmtCase = conn.prepareStatement(caseQuery);
            pstmtCase.setInt(1, this.caseId);  // Using instance variable 'caseId'
            ResultSet rsCase = pstmtCase.executeQuery();
            if (rsCase.next()) {
                casePrecinctID = rsCase.getInt("precinctID");
            }

            // Query to get the precinctID for the given policeID from the officers table
            String officerQuery = "SELECT precinctID FROM officers WHERE policeID = ?";
            PreparedStatement pstmtOfficer = conn.prepareStatement(officerQuery);
            pstmtOfficer.setInt(1, this.policeId);  // Using instance variable 'policeId'
            ResultSet rsOfficer = pstmtOfficer.executeQuery();
            if (rsOfficer.next()) {
                officerPrecinctID = rsOfficer.getInt("precinctID");
            }

            // Close the prepared statements and result sets
            pstmtCase.close();
            pstmtOfficer.close();
            rsCase.close();
            rsOfficer.close();
            conn.close();
        
            // Check if the precincts match
            return casePrecinctID == officerPrecinctID;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    private boolean isDuplicate() {
        try {
            // Establish connection to the database
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/police_database?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");

            // Query to check if the officer is already assigned to the case
            String query = "SELECT policeID, caseID FROM officerCases WHERE caseID = ? AND policeID = ?";
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setInt(1, this.caseId);  // Set the caseID
            pstmt.setInt(2, this.policeId);  // Set the policeID

            // Execute the query
            ResultSet rs = pstmt.executeQuery();

            // If the result set contains a matching record, return true
            if (rs.next()) {
                int dbPoliceId = rs.getInt("policeID");
                int dbCaseId = rs.getInt("caseID");
            
                // Compare the retrieved values with the current instance's values
                if (this.policeId == dbPoliceId && this.caseId == dbCaseId) {
                    // Duplicate found
                    rs.close();
                    pstmt.close();
                    conn.close();
                    return true;  // Officer already assigned to this case
                }
            }

            // Close resources
            rs.close();
            pstmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            return true;  // If there's an error, consider it a duplicate check failure
        }
    
        return false;  // No duplicate found
    }

    public void getPoliceList() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/police_database?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            String query = "SELECT policeID FROM officers";
            PreparedStatement pstmt = conn.prepareStatement(query);
            ResultSet rs = pstmt.executeQuery();
        
            while (rs.next()) {
                allPoliceIdList.add(rs.getInt("policeID"));
            }
        
            pstmt.close();
            rs.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void getCaseList() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/police_database?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            String query = "SELECT caseID FROM incidents ORDER BY caseID ASC";
            PreparedStatement pstmt = conn.prepareStatement(query);
            ResultSet rs = pstmt.executeQuery();
        
            while (rs.next()) {
                allCaseIdList.add(rs.getInt("caseID"));
            }
        
            pstmt.close();
            rs.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void getActiveCaseList() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/police_database?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            String query = "SELECT caseID FROM incidents WHERE dateResolved is NULL";
            PreparedStatement pstmt = conn.prepareStatement(query);
            ResultSet rs = pstmt.executeQuery();
        
            while (rs.next()) {
                allCaseIdList.add(rs.getInt("caseID"));
            }
        
            pstmt.close();
            rs.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public String assignCase() {
        if (!checkPrecinct()) {
            return "The case cannot be assigned to the officer because the precincts are different.";
        }
        else if (isDuplicate()){
            return "The officer is already assigned to this case.";
        } else {
            try {
                // Establish connection to the database
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/police_database?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");

                // Prepare the SQL query to insert caseID and policeID into officerCases table
                String insertQuery = "INSERT INTO officerCases (caseID, policeID) VALUES (?, ?)";
                PreparedStatement pstmt = conn.prepareStatement(insertQuery);
                pstmt.setInt(1, this.caseId);  // Set caseId (from instance variable)
                pstmt.setInt(2, this.policeId);  // Set policeId (from instance variable)

                // Execute the insert statement
                int rowsAffected = pstmt.executeUpdate();

                // Check if the insertion was successful
                if (rowsAffected > 0) {
                    pstmt.close();
                    conn.close();
                    return "The case has been successfully assigned to the officer.";
                } else {
                    pstmt.close();
                    conn.close();
                    return "Failed to assign the case to the officer.";
                }
            } catch (Exception e) {
              return "An error occurred while assigning the case: " + e.getMessage();
            }
        }
    } 
    
    public boolean getAssignedOfficers(int caseID) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/police_database?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");

            PreparedStatement stmt = conn.prepareStatement("SELECT o.policeID, CONCAT(b.lastName, ', ', b.firstName) AS officerName FROM officercases oc JOIN officers o ON o.policeID = oc.policeID JOIN backgrounds b ON o.backgroundId = b.backgroundId WHERE caseID = ?");
            stmt.setInt(1, caseID);
            
            ResultSet res = stmt.executeQuery();
            
            this.policeIdList.clear();
            this.officerNames.clear();
            
            while (res.next()) {
                this.policeIdList.add(res.getInt("policeID"));
                this.officerNames.add(res.getString("officerName"));
            }
            
            stmt.close();
            conn.close();
            
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}

