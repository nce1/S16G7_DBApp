package ccinfom.database;

import java.util.*;
import java.sql.*;

public class Officer{
    public int policeID, precinctID, id, flag;
    public String position, error;
    public java.sql.Date startDate;
    
    public ArrayList<Integer> activeCases = new ArrayList<>();
    public ArrayList<Integer> resolvedCases = new ArrayList<>();
    public final ArrayList<String> positions = new ArrayList<String>(
    Arrays.asList("Select", "Rookie Officer", "Experienced Officer", "Corporal", "Sergeant", "Lieutenant",
		  "Captain", "Major", "Deputy Chief", "Chief of Police", "Commissioner"));
    
    public Officer(){
    }
    
    
    
    public boolean addOfficer(){
        try{
            if (isDuplicate())
                return false;
            
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/police_database?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            PreparedStatement pstmt = conn.prepareStatement("SELECT max(policeID) +  1 as id FROM officers");
            ResultSet rst = pstmt.executeQuery();
            while (rst.next())
                this.policeID = rst.getInt("id");
            java.sql.Date current = Common.getCurrentDate();
            pstmt = conn.prepareStatement("INSERT INTO officers values(?, ?, ?, ?, ?)");
            pstmt.setInt(1, this.policeID);
            pstmt.setInt(2, this.id);
            pstmt.setString(3, "Rookie Officer");
            pstmt.setInt(4, this.precinctID);
            pstmt.setDate(5, current);
            
            pstmt.execute();
            pstmt.close();
            conn.close();
            return true;
        } catch(Exception e){
            this.error = e.getMessage();
            return false;
        }
    }
    
    public boolean deleteOfficer(){
        try{

            
            Person p = new Person();
            if (!updateHistoryDelete()){
               
                return false;
            }
            if (!p.updateUnemployed(this.id)){
                this.error = p.error;
                return false;
            }
                        Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/police_database?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            PreparedStatement pstmt = conn.prepareStatement("DELETE FROM officers WHERE policeID = ?");
            pstmt.setInt(1, this.policeID);
            
            pstmt.execute();
            pstmt.close();
            conn.close();

            return true;
        } catch(Exception e){
            this.error = e.getMessage();
            return false;
        }
    }
    
    private boolean updateHistoryDelete(){
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/police_database?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            PreparedStatement pstmt = conn.prepareStatement("SELECT precinctID, position, startDate FROM officers where policeID = ?");
            pstmt.setInt(1, this.policeID);
            
            ResultSet rst = pstmt.executeQuery();
            String oldPosition = null;
            java.sql.Date oldDate = null;
            int oldPrecinct = 0;
            
            while (rst.next()){
                oldPrecinct = rst.getInt("precinctID");
                oldPosition = rst.getString("position");
                oldDate = rst.getDate("startDate");
            }
            
            java.sql.Date endDate = Common.getCurrentDate();
            int jhID = 0;
            
            pstmt = conn.prepareStatement("SELECT MAX(jobHistoryId) + 1 AS ID FROM jobhistory");
            rst = pstmt.executeQuery();
            while(rst.next())
                jhID = rst.getInt("ID"); 
                        
            pstmt = conn.prepareStatement("INSERT INTO jobhistory values(?, ?, ?, ?, ?, ?)");
            pstmt.setInt(1, jhID);
            pstmt.setInt(2, this.policeID);
            pstmt.setString(3, oldPosition);
            pstmt.setInt(4, oldPrecinct);
            pstmt.setDate(5, oldDate);
            pstmt.setDate(6, endDate);
            
            pstmt.execute();
            pstmt.close();
            conn.close();
            return true;
        } catch(Exception e){
            this.error = e.getMessage();
            return false;
        }
    }
    
    public boolean isDuplicate(){
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/police_database?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            PreparedStatement pstmt = conn.prepareStatement("SELECT backgroundId FROM officers");
            ResultSet rst = pstmt.executeQuery();
            
            while (rst.next()){
                if (rst.getInt("backgroundId") == this.id){
                    this.error = "This person has been enrolled already.";
                    pstmt.close();
                    conn.close();
                    return true;
                }
            }
            pstmt.close();
            conn.close();
            return false;
        } catch (Exception e){
            this.error = e.getMessage();
            return true;
        }
    }
    public int getValidPosition(){
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/police_database?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            PreparedStatement pstmt = conn.prepareStatement("SELECT position FROM officers WHERE policeID = ?");
            pstmt.setInt(1, this.policeID);
            
            ResultSet rst = pstmt.executeQuery();
            String temp = null;
            while (rst.next())
                temp = rst.getString("position");
            
            return positions.indexOf(temp);            
        } catch(Exception e){
            return 0;
        }
    }
    
    private boolean transferOfficer(){
        int openCases = findActiveCases();
        
        if (openCases != 0){
            this.error = "You cannot transfer to a different precinct at this time due to active cases.";
            return false;
        } else if (openCases == -1){
            return false;
        } else{
            try{
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn;
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/police_database?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");

                // Update table
                PreparedStatement pstmt = conn.prepareStatement("UPDATE officers SET precinctID = ?, startDate = ? WHERE policeID = ?");
                this.startDate = Common.getCurrentDate();
                pstmt.setInt(1, this.precinctID);
                pstmt.setDate(2, this.startDate);
                pstmt.setInt(3, this.policeID);
                
                pstmt.executeUpdate();
               
                pstmt.close();        
                conn.close();
                return true;
            } catch(Exception e){
                this.error = e.getMessage();
                return false;
            }
        }
    }
    
    public boolean updatePosition(){
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/police_database?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");

            // Update table
            PreparedStatement pstmt = conn.prepareStatement("UPDATE officers SET position = ?, startDate = ? WHERE policeID = ?");
            this.startDate = Common.getCurrentDate();
            pstmt.setString(1, this.position);
            pstmt.setDate(2, this.startDate);
            pstmt.setInt(3, this.policeID);
                
            pstmt.executeUpdate();
               
            pstmt.close();        
            conn.close();
            return true;
        } catch(Exception e){
            this.error = e.getMessage();
            return false;
        }
    }
    
    private boolean addHistory(String oldPosition, int oldPrecinct, java.sql.Date start){
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/police_database?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            PreparedStatement pstmt = conn.prepareStatement("SELECT MAX(jobHistoryId) + 1 AS ID FROM jobhistory");
            
            ResultSet rst = pstmt.executeQuery();
            java.sql.Date endDate = Common.getCurrentDate();
            int jhID = 0;
            
            while(rst.next())
                jhID = rst.getInt("ID"); 
                        
            pstmt = conn.prepareStatement("INSERT INTO jobhistory values(?, ?, ?, ?, ?, ?)");
            pstmt.setInt(1, jhID);
            pstmt.setInt(2, this.policeID);
            pstmt.setString(3, oldPosition);
            pstmt.setInt(4, oldPrecinct);
            pstmt.setDate(5, start);
            pstmt.setDate(6, endDate);
            
            pstmt.execute();
            pstmt.close();
            conn.close();
            return true;
        } catch(Exception e){
            this.error = "here" + e.getMessage();
            return false;
        }
    }
    
    public boolean updateHistory(){
        // Get details for jobHistory
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/police_database?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            PreparedStatement pstmt = conn.prepareStatement("SELECT precinctID, position, startDate FROM officers WHERE policeID = ?");
            pstmt.setInt(1, this.policeID);
            
            ResultSet rst = pstmt.executeQuery();
            String oldPosition = null;
            java.sql.Date oldDate = null;
            int oldPrecinct = 0;
            
            while (rst.next()){
                oldPrecinct = rst.getInt("precinctID");
                oldPosition = rst.getString("position");
                oldDate = rst.getDate("startDate");
            }
            
            pstmt.close();        
            conn.close();
            
            if (oldPosition == null){
                this.error = "Something went wrong. Please try again.";
                return false;
            } else{
                boolean temp;
                if (flag == 1){
                    temp = transferOfficer();
                    this.error = error + " was called";
                }
                    
                else if (flag == 2){
                    temp = updatePosition();
                    this.error = error + " called";
                }
                else{
                    temp = transferOfficer();
                    temp = updatePosition();
                }
                if (temp)
                    temp = addHistory(oldPosition, oldPrecinct, oldDate);
                
                return temp;
            }
        } catch(Exception e){
            this.error = error + e.getMessage();
            return false;
        }
    }
    
    private int findActiveCases(){
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn;
	    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/police_database?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            
            PreparedStatement pstmt = conn.prepareStatement("SELECT c.caseID as cID FROM officerCases c INNER JOIN incidents i ON c.caseid = i.caseid WHERE i.dateResolved IS NULL AND c.policeid = ?");
            pstmt.setInt(1, this.policeID);
            
            ResultSet rst = pstmt.executeQuery();
            
            while (rst.next()) {
                this.activeCases.add(rst.getInt("cID"));
            }
            pstmt.close();
            conn.close();
            
            return activeCases.size();
        } catch(Exception e){
            this.error = e.getMessage();
            return -1;
        }
    }
    
    
    public static void main(){
        
    }
}
