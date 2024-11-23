
package ccinfom.database;
import java.sql.*;
import java.util.ArrayList;
import java.util.Arrays;

public class Offender {
    public int caseID;
    public int backgroundId;
    public String offense;
    public String status, error;
    public final ArrayList<String> statusEntries = new ArrayList<String>(
    Arrays.asList("Under Investigation", "Arrested", "Awaiting Trial", "In Prison", "On Parole",
                  "On Probation", "Released", "Fugitive", "Dismissed"));
    
    public ArrayList<Integer> caseIDList;
    public ArrayList<Integer> backgroundIDList;
    public ArrayList<String> offenseList;
    public ArrayList<String> statusList;
    
    public Offender() {
        caseIDList = new ArrayList<>();
        backgroundIDList = new ArrayList<>();
        offenseList = new ArrayList<>();
        statusList = new ArrayList<>();
    }
    
    public boolean updateStatus(){
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/police_database?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            PreparedStatement pstmt = conn.prepareStatement("UPDATE offenders SET status = ? WHERE backgroundId = ? AND caseID = ?");
            pstmt.setString(1, this.status);
            pstmt.setInt(2, this.backgroundId);
            pstmt.setInt(3, this.caseID);
            if (pstmt.executeUpdate() == 0){
                pstmt.close();
                conn.close();
                this.error = "Please make sure the ID and case ID are correct.";
                return false;
            }
            
            pstmt.close();
            conn.close();
            return true;
        } catch(Exception e){
            this.error = e.getMessage();
            return false;
        }
    }
    
    public boolean addOffender(){
        Person p = new Person();
        if (!p.verifySuspect(this.backgroundId)){
            this.error = "Please verify the suspect's ID";
            return false;
        }
        
        
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/police_database?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            
            PreparedStatement pstmt = conn.prepareStatement("INSERT INTO offenders values(?, ?, ?, ?)");
            pstmt.setInt(1, this.caseID);
            pstmt.setInt(2, this.backgroundId);
            pstmt.setString(3, this.offense);
            pstmt.setString(4, "Under Investigation");
            
            pstmt.execute();
            pstmt.close();
            conn.close();
            return true;
        } catch (Exception e){
            this.error = e.getMessage();
            return false;
        }
    }
    
    public boolean getOffenders(int caseID) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn;
	    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/police_database?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            
            PreparedStatement stmt = conn.prepareStatement("SELECT * FROM offenders WHERE caseID = ?");
            stmt.setInt(1, caseID);
            
            ResultSet res = stmt.executeQuery();
            
            while (res.next()) {
                this.caseIDList.add(res.getInt("caseID"));
                this.backgroundIDList.add(res.getInt("backgroundId"));
                this.offenseList.add(res.getString("offense"));
                this.statusList.add(res.getString("status"));
            }
            
            stmt.close();
            conn.close();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean getAllOffenders(){
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn;
	    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/police_database?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            
            PreparedStatement stmt = conn.prepareStatement("SELECT * FROM offenders");
            
            ResultSet res = stmt.executeQuery();
            
            while (res.next()) {
                this.caseIDList.add(res.getInt("caseID"));
                this.backgroundIDList.add(res.getInt("backgroundId"));
                this.offenseList.add(res.getString("offense"));
                this.statusList.add(res.getString("status"));
            }
            
            stmt.close();
            conn.close();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean deleteOffender(){
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/police_database?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            PreparedStatement pstmt = conn.prepareStatement("SELECT status FROM offenders WHERE backgroundId = ? AND caseID = ?");
            pstmt.setInt(1, this.backgroundId);
            pstmt.setInt(2, this.caseID);
            
            ResultSet rst = pstmt.executeQuery();
            String status;
            Boolean flag = false;
            while(rst.next()){
                status = rst.getString("status");
                if (status == null){
                    pstmt.close();
                    conn.close();
                    this.error = "Please verify the offender's ID and the case ID.";
                    return false;
                } else if(!status.equals("Dismissed")){
                    pstmt.close();
                    conn.close();
                    this.error = "This offender is not qualified for deletion.";
                    return false;
                }
                flag = true;
            }
            if (!flag)
                this.error = "Please verify the offender's ID and the case ID.";
            
            pstmt = conn.prepareStatement("DELETE FROM offenders WHERE backgroundId = ? AND caseID = ?");
            pstmt.setInt(1, this.backgroundId);
            pstmt.setInt(2, this.caseID);
            pstmt.execute();
            
            pstmt.close();
            conn.close();
            return flag;
        } catch(Exception e){
            this.error = e.getMessage();
            return false;
        }
    }
}
