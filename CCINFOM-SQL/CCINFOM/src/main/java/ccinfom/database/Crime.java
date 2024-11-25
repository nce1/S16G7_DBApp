package ccinfom.database;

import java.sql.*;
import java.util.*;

public class Crime {
    
    public List<Map<String, Object>> getAllCrimeTypes() {
        List<Map<String, Object>> allCrimeTypes = new ArrayList<>();
        
        try {
            // Establish connection to the database
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/police_database?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");

            // SQL query to get all crime types
            String query = "SELECT type, COUNT(*) as count FROM incidents GROUP BY type";
            PreparedStatement pstmt = conn.prepareStatement(query);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                Map<String, Object> crimeData = new HashMap<>();
                crimeData.put("crime_type", rs.getString("type"));
                crimeData.put("count", rs.getInt("count"));
                allCrimeTypes.add(crimeData);
            }
            
            pstmt.close();
            rs.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return allCrimeTypes;
    }
    
    
    public List<Map<String, Object>> getCrimeFrequency() {
        List<Map<String, Object>> crimeFreq = new ArrayList<>();

        try {
            // Establish connection to the database
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/police_database?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");

            // SQL query to group by year, month name, and crime type
            String query = "SELECT " +
                       "    YEAR(dateReported) AS report_year, " + // Extract year
                       "    MONTHNAME(dateReported) AS report_month, " + // Extract month name
                       "    type, " +
                       "    COUNT(*) AS frequency " +
                       "FROM incidents " +
                       "GROUP BY report_year, report_month, type " + // Group by year, month, and type
                       "ORDER BY report_year, FIELD(report_month, 'January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'), type;"; // Order by year, month, and crime type

            PreparedStatement pstmt = conn.prepareStatement(query);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Map<String, Object> crimeData = new HashMap<>();
                crimeData.put("report_year", rs.getInt("report_year"));
                crimeData.put("report_month", rs.getString("report_month"));
                crimeData.put("crime_type", rs.getString("type"));
                crimeData.put("frequency", rs.getInt("frequency"));
                crimeFreq.add(crimeData);
            }   

            pstmt.close();
            rs.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return crimeFreq;
    }
}

