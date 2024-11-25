
package ccinfom.database;
import java.sql.*;
import java.util.ArrayList;


public class Participant {
    
    public int caseID;
    public int backgroundId;
    public String testimony;
    public String involvement;
    
    public ArrayList<Integer> caseIDList;
    public ArrayList<Integer> backgroundIdList;
    public ArrayList<String> testimonyList;
    public ArrayList<String> involvementList;
    
    public Participant() {
        caseIDList = new ArrayList<>();
        backgroundIdList = new ArrayList<>();
        testimonyList = new ArrayList<>();
        involvementList = new ArrayList<>();
    }
    
    public boolean addParticipant() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn;
	    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/police_database?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            
            PreparedStatement stmt = conn.prepareStatement("INSERT INTO participants VALUE (?, ?, ?, ?)");
            
            //set attributes in jsp file before calling function
            stmt.setInt(1, this.caseID);
            stmt.setInt(2,this.backgroundId);
            stmt.setString(3, this.testimony);
            stmt.setString(4, this.involvement);
            
            stmt.executeUpdate();
            
            stmt.close();
            conn.close();
            
            return true;
        } catch(Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean getParticipants(int caseID) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn;
	    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/police_database?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            
            PreparedStatement stmt = conn.prepareStatement("SELECT * FROM participants WHERE caseID = ?");
            stmt.setInt(1, caseID);
            
            ResultSet res = stmt.executeQuery();
            
            while (res.next()) {
                this.caseIDList.add(res.getInt("caseID"));
                this.backgroundIdList.add(res.getInt("backgroundId"));
                this.testimonyList.add(res.getString("testimony"));
                this.involvementList.add(res.getString("involvement"));
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
