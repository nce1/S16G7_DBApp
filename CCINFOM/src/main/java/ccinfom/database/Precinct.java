
package ccinfom.database;

import java.sql.*;
import java.util.ArrayList;

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
    
    public static void main(String[] args) {
        Precinct p = new Precinct();
        p.getPrecinct(2000000002);
        System.out.println(p.cityJurisdiction);
    }
}
