
package ccinfom.database;

import java.sql.*;
import java.util.*;

public class Precinct {
    public int precinctID;
    public String cityJurisdiction; 
    
    public ArrayList<Integer> precinctIDList;
    public ArrayList<String> cityJurisdictionList; 
    
    public Precinct() {
       precinctIDList = new ArrayList<>();
       cityJurisdictionList = new ArrayList<>();
    }
    
    public int getPrecinctList() {
        try {
            //get connection to database
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn;
	    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/police_database?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            System.out.println("Connection successful");
            
            //clear the current list
            precinctIDList.clear();
            cityJurisdictionList.clear();
            
            PreparedStatement stmt = conn.prepareStatement("SELECT * FROM precincts");
            ResultSet res = stmt.executeQuery();
            
            while (res.next()) {
                precinctID = res.getInt("precinctID");
                cityJurisdiction = res.getString("cityJurisdiction");
                precinctIDList.add(precinctID);
                cityJurisdictionList.add(cityJurisdiction);
            }
            
            stmt.close();
            conn.close();
            
            return 1;
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }
    
    public boolean getPrecinct(int precinctID) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn;
	    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/police_database?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            System.out.println("Connection successful");
            
            PreparedStatement stmt = conn.prepareStatement("SELECT * FROM precincts WHERE precinctID = ?");
            stmt.setInt(1, precinctID);
            
            ResultSet res = stmt.executeQuery();
            
            while (res.next()) {
                this.cityJurisdiction = res.getString("cityJurisdiction");
                this.precinctID = precinctID;
            }
            
            stmt.close();
            conn.close();
            
            return true;
            
        } catch (Exception e) {
            System.out.println(e.getMessage());
            return false;
        }
    }

    public int addPrecinct() {
        try {
            //get connection to database
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn;
	    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/police_database?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            System.out.println("Conneciton successful");
            
            //get last precinctID
            PreparedStatement stmt = conn.prepareStatement("SELECT MAX(precinctID) + 1 AS ID FROM precincts");
            ResultSet res = stmt.executeQuery();
            
            while (res.next()) {
                this.precinctID = res.getInt("ID");
            }
            
            if (this.precinctID == 0)
                this.precinctID = 2000000001;
            
            //insert entry
            stmt = conn.prepareStatement("INSERT INTO precincts values (?,?)");
            stmt.setInt(1, this.precinctID);
            stmt.setString(2, this.cityJurisdiction);
            
            stmt.executeUpdate();
            
            stmt.close();
            conn.close();
       
           return 1;
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }
    
    public String deletePrecinct(int precinctID) {
        try {
            // Establish a database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/police_database?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");

            // Check if there are any officers assigned to this precinct
            PreparedStatement officerCheckStmt = conn.prepareStatement("SELECT COUNT(*) AS officerCount FROM officers WHERE precinctID = ?");
            officerCheckStmt.setInt(1, precinctID);
            ResultSet officerCheckRes = officerCheckStmt.executeQuery();
            officerCheckRes.next();
            int officerCount = officerCheckRes.getInt("officerCount");

            // Check if there are any incidents associated with this precinct that have certain statuses
            PreparedStatement incidentCheckStmt = conn.prepareStatement(
            "SELECT COUNT(*) AS incidentCount FROM incidents WHERE precinctID = ? AND status IN ('Charges Filed', 'Awaiting Trial', 'Convicted', 'Acquitted', 'Dismissed')");
            incidentCheckStmt.setInt(1, precinctID);
            ResultSet incidentCheckRes = incidentCheckStmt.executeQuery();
            incidentCheckRes.next();
            int incidentCount = incidentCheckRes.getInt("incidentCount");

            // If officers or incidents are associated, do not delete the precinct
            if (officerCount > 0 || incidentCount > 0) {
                officerCheckStmt.close();
                incidentCheckStmt.close();
                conn.close();
                return "Cannot delete precinct. Officers or incidents with specified statuses are still associated with it."; // failure to delete
            }

            // Else proceed to delete the precinct if no officers or incidents are associated
            PreparedStatement deleteStmt = conn.prepareStatement("DELETE FROM precincts WHERE precinctID = ?");
            deleteStmt.setInt(1, precinctID);
            int rowsAffected = deleteStmt.executeUpdate();

            deleteStmt.close();
            officerCheckStmt.close();
            incidentCheckStmt.close();
            conn.close();

            return rowsAffected > 0 ? "Successfully deleted the precinct." : "Unsuccessful deletion.";
        } catch (Exception e) {
            e.printStackTrace();
            return "Error."; 
        }
    }

    
    public int updatePrecinctLocation(int precinctID, String newCityJurisdiction) {
        try {
            //get connection to database
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/police_database?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");

            // Update precinct's location (cityJurisdiction)
            PreparedStatement stmt = conn.prepareStatement("UPDATE precincts SET cityJurisdiction = ? WHERE precinctID = ?");
            stmt.setString(1, newCityJurisdiction);
            stmt.setInt(2, precinctID);

            int rowsAffected = stmt.executeUpdate();

            stmt.close();
            conn.close();

            return rowsAffected > 0 ? 1 : 0; // Return 1 if update successful, otherwise 0
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }
    
     public String calculateCases(int precinctID, int year, int month) {
        try {
            // Load the JDBC driver and establish a connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/police_database?useTimezone=true&serverTimezone=UTC&user=root&password=12345678"
            );

            // Query to fetch cases for the given precinctID, year, and month
            String sql = "SELECT DATE(dateReported) AS reportDate "
                        + "FROM incidents "
                        + "WHERE precinctID = ? AND YEAR(dateReported) = ? AND MONTH(dateReported) = ?";

            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, precinctID);
            stmt.setInt(2, year);
            stmt.setInt(3, month);

            ResultSet res = stmt.executeQuery();

            // Variables to hold calculations
            int totalCases = 0;
            Set<String> uniqueDates = new HashSet<>();

            // Iterate through the result set
            while (res.next()) {
                totalCases++;
                uniqueDates.add(res.getString("reportDate")); // Add each unique date to the set
            }

            // Calculate the average cases per day
            double averageCases = uniqueDates.isEmpty() ? 0 : (double) totalCases / uniqueDates.size();

            // Close resources
            res.close();
            stmt.close();
            conn.close();

            // Format the result message
            return String.format("Total cases: %d, Average cases per day: %.2f", totalCases, averageCases);

        } catch (Exception e) {
            e.printStackTrace();
            return "Error calculating cases.";
        }
    }


    public List<String> getMonthYears() {
        List<String> monthYears = new ArrayList<>();
        try {
            // Establish a database connection
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/police_database?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");

            // Query to fetch unique month-year combinations
            String sql = "SELECT DISTINCT YEAR(dateReported) AS year, MONTH(dateReported) AS month " +
                     "FROM incidents " +
                     "ORDER BY year ASC, month ASC";
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();

            // Collect all unique month-year combinations
            while (rs.next()) {
                int year = rs.getInt("year");
                int month = rs.getInt("month");
                monthYears.add(month + "-" + year); // Add to the list as "month-year"
            }

            // Close resources
            rs.close();
            stmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return monthYears;
    }
     
     public Map<Integer, List<Integer>> getPrecinctListWithOfficers() {
        try {
            // Load the database driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Connect to the database
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/police_database?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");

            // Clear the current list
            precinctIDList.clear();
            cityJurisdictionList.clear();

            // Create a map to store precincts and their officers
            Map<Integer, List<Integer>> precinctOfficersMap = new LinkedHashMap<>();

            // Query to get all precincts
            PreparedStatement precinctStmt = conn.prepareStatement("SELECT * FROM precincts ORDER BY precinctID ASC");
            ResultSet precinctRes = precinctStmt.executeQuery();

            while (precinctRes.next()) {
                int precinctID = precinctRes.getInt("precinctID");
                String cityJurisdiction = precinctRes.getString("cityJurisdiction");

                precinctIDList.add(precinctID);
                cityJurisdictionList.add(cityJurisdiction);

                // Query to get officers for this precinct
                PreparedStatement officerStmt = conn.prepareStatement("SELECT policeID FROM officers WHERE precinctID = ?");
                officerStmt.setInt(1, precinctID);
                ResultSet officerRes = officerStmt.executeQuery();

                List<Integer> policeIDs = new ArrayList<>();
                while (officerRes.next()) {
                    policeIDs.add(officerRes.getInt("policeID"));
                }

                // Add to the map
                precinctOfficersMap.put(precinctID, policeIDs);

                officerStmt.close();
            }

            precinctStmt.close();
            conn.close();

            return precinctOfficersMap;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
