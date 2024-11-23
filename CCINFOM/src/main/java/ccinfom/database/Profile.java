/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package ccinfom.database;

import java.util.ArrayList;
import java.sql.*;

public class Profile {
    public Person person;

    public ArrayList<Integer> caseIDOffList = new ArrayList<>();
    public ArrayList<String> offenseList = new ArrayList<>();
    public ArrayList<String> statusList = new ArrayList<>();
    public ArrayList<Integer> caseIDInvList = new ArrayList<>();
    public ArrayList<String> testimonyList = new ArrayList<>();
    public ArrayList<String> involvementList = new ArrayList<>();
    public String error = null;

    public Profile(Person person) {
        this.person = person; // Assuming person is provided through the constructor
    }

    // Method to fetch the offense data from the offenders table
    public void getOffense() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/police_database?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");

            // Prepare the query to retrieve the offense data
            PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM offenders WHERE id = ?");
            pstmt.setInt(1, person.id);
            ResultSet rs = pstmt.executeQuery();

            // offense details
            while (rs.next()) {
                caseIDOffList.add(rs.getInt("caseID"));
                offenseList.add(rs.getString("offense"));
                statusList.add(rs.getString("status"));
            }
            pstmt.close();
            conn.close();
        } catch (Exception e) {
            this.error = "Error fetching offense data: " + e.getMessage();
        }
    }

    // Method to fetch the involvement data from the participants table
    public void getInvolvement() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/police_database?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");

            // Prepare the query to retrieve the involvement data
            PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM participants WHERE id = ?");
            pstmt.setInt(1, person.id);
            ResultSet rs = pstmt.executeQuery();

            // involvement details
            while (rs.next()) {
                caseIDInvList.add(rs.getInt("caseID"));
                testimonyList.add(rs.getString("testimony"));
                involvementList.add(rs.getString("involvement"));
            }
            pstmt.close();
            conn.close();
        } catch (Exception e) {
            this.error = "Error fetching involvement data: " + e.getMessage();
        }
    }

    public static void main(String[] args) {
      
    }
}

