
package ccinfom.database;
import java.sql.*;
import java.util.ArrayList;

public class Offender {
    public int caseID;
    public int backgroundId;
    public String offense;
    public String status;
    
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
}
