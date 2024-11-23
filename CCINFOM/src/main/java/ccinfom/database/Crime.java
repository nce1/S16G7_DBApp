/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
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
}

