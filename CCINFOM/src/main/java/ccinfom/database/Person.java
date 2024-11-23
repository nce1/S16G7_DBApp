package ccinfom.database;

import java.util.ArrayList;
import java.util.Date;
import java.sql.*;

public class Person{
    public int id, addressId;
    public String lName, fName;
    public java.sql.Date birthdate, dateOfDeath = null;
    public String sex, profession;
    public String houseNo, street, baranggay;
    public String city, province, region, zipCode;
    public String status = "Alive", error = null;
    
    public ArrayList<Integer> idList = new ArrayList<>();
    public ArrayList<String> lNameList = new ArrayList<>();
    public ArrayList<String> fNameList = new ArrayList<>();
    public ArrayList<Date> birthdateList = new ArrayList<>();
    public ArrayList<Date> dateOfDeathList = new ArrayList<>();
    public ArrayList<String> professionList = new ArrayList<>();
    public ArrayList<String> cityList = new ArrayList<>();
    public ArrayList<String> provinceList = new ArrayList<>();
    public ArrayList<String> statusList = new ArrayList<>();
    public ArrayList<Character> sexList = new ArrayList<>();
    public ArrayList<Integer> addressIdList = new ArrayList<>();

    
    public Person(){
        
    }
    
    public String registerPerson(){
        if (isDuplicate())
            return "A record with the same last name, first name, and date of birth already exists in the table.";
        else if (validBirthdate())
            return "The date of birth provided is not valid. Please verify and try again.";
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn;
	    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/police_database?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            
            // Get last id
            PreparedStatement bckg = conn.prepareStatement("SELECT MAX(backgroundId) + 1 AS ID FROM background");
            PreparedStatement adrs = conn.prepareStatement("SELECT MAX(addressId) + 1 AS aID FROM address");

            ResultSet bId = bckg.executeQuery();
            ResultSet aId = adrs.executeQuery();
            
            while(bId.next())
                this.id = bId.getInt("ID");      
            while(aId.next())
                this.addressId = aId.getInt("aId");
            
            // Write data
            adrs = conn.prepareStatement("INSERT INTO address values(?, ?, ?, ?, ?, ?, ?, ?)");
            adrs.setInt(1, this.addressId);
            adrs.setString(2, this.houseNo);
            adrs.setString(3, this.street);
            adrs.setString(4, this.baranggay);
            adrs.setString(5, this.city);
            adrs.setString(6, this.province);
            adrs.setString(7, this.region);
            adrs.setString(8, this.zipCode);
            adrs.execute();
            adrs.close();
            
            bckg = conn.prepareStatement("INSERT INTO background values(?, ?, ?, ?, ?, ?, ?, ?, ?)");
            bckg.setInt(1, this.id);
            bckg.setString(2, this.lName);
            bckg.setString(3, this.fName);
            bckg.setDate(4, this.birthdate);
            bckg.setString(5, this.sex);
            bckg.setString(6, this.profession);
            bckg.setInt(7, this.addressId);
            bckg.setString(8, this.status);
            bckg.setDate(9, this.dateOfDeath);
            bckg.execute();
            bckg.close();
            
            conn.close();
            return "true";
        } catch(Exception e){
            System.out.println(e.getMessage());
            return e.getMessage();
        }
    }
    
    private boolean isDuplicate(){
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn;
	    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/police_database?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            
            PreparedStatement pstmt = conn.prepareStatement("SELECT lastName, firstName FROM background WHERE birthdate = ?");
            pstmt.setDate(1, birthdate);
            ResultSet rs = pstmt.executeQuery();
            while(rs.next())
                if (this.lName.equals(rs.getString("lastName")) && this.fName.equals(rs.getString("firstName")))
                    return true;
            
            pstmt.close();
            conn.close();
            return false;
        } catch(Exception e){
            this.error = e.getMessage();
            return true;
        }
    }
    
    private boolean validBirthdate(){
        java.util.Date cDate = new Date();
        java.sql.Date sDate = new java.sql.Date(cDate.getTime());
        if (this.birthdate.after(sDate))
            return true;
        else
            return false;
    }
    
    public boolean updateProfession(int bID){
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/police_database?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            PreparedStatement pstmt = conn.prepareStatement("UPDATE background SET profession = ? WHERE backgroundId = ?");
            pstmt.setString(1, "Police Officer");
            pstmt.setInt(2, bID);
            
            pstmt.executeUpdate();
            pstmt.close();        
            conn.close();
            return true;
        } catch (Exception e){
            this.error = e.getLocalizedMessage();
            return false;
        }
    }
    
    public boolean updateUnemployed(int bID){
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/police_database?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            PreparedStatement pstmt = conn.prepareStatement("UPDATE background SET profession = ? WHERE backgroundId = ?");
            pstmt.setString(1, "Unemployed");
            pstmt.setInt(2, bID);
            
            pstmt.executeUpdate();
            pstmt.close();        
            conn.close();
            return true;
        } catch (Exception e){
            this.error = e.getLocalizedMessage();
            return false;
        }
    }
        
    public Person getPerson(){
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn;
	    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/police_database?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            
            PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM background WHERE backgroundId = ?");
            pstmt.setInt(1, this.id);            
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()){
                if (this.id == rs.getInt("backgroundId")){
                    this.error = "false";
                    if (this.lName.equals(rs.getString("lastName")) && this.fName.equals(rs.getString("firstName"))){
                        this.birthdate = rs.getDate("birthdate");
                        this.sex = rs.getString("sex");
                        this.profession = rs.getString("profession");
                        this.addressId = rs.getInt("addressId");
                        this.status = rs.getString("status");
                        this.dateOfDeath = rs.getDate("yearOfDeath");
                    } else
                        this.error = "The names provided do not match the records associated with this ID. Please verify and try again";
                }  
            }
            pstmt.close();        
            conn.close();
            
            if (this.error == null)
                this.error = "The ID does not exist in the database. Please verify and try again.";
            else
                getAddress();
            return this;
        } catch(Exception e){
            this.error = error + e.getMessage() + " found here";
            return this;
        }
    }
    
    private void getAddress(){
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn;
	    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/police_database?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM address WHERE addressId = ?");
            pstmt.setInt(1, this.addressId);            
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()){
                this.houseNo = rs.getString("houseNo");
                this.street = rs.getString("street");
                this.baranggay = rs.getString("baranggay");
                this.city = rs.getString("city");
                this.province = rs.getString("province");
                this.region = rs.getString("region");
                this.zipCode = rs.getString("zipCode");
                 
            }
            pstmt.close();        
            conn.close();
        } catch(Exception e){
            this.error = error + " " + e.getMessage();
        }
    }
    
    public boolean updateAddress(){
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn;
	    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/police_database?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            PreparedStatement pstmt = conn.prepareStatement("UPDATE address SET houseNo = ?, street = ?, baranggay = ?, city = ?, province = ?, region = ?, zipCode = ? WHERE addressId = ?");
            pstmt.setString(1, this.houseNo);
            pstmt.setString(2, this.street);        
            pstmt.setString(3, this.baranggay);
            pstmt.setString(4, this.city);
            pstmt.setString(5, this.province);
            pstmt.setString(6, this.region);
            pstmt.setString(7, this.zipCode);
            pstmt.setInt(8, this.addressId);
            
            pstmt.executeUpdate();
            pstmt.close();        
            conn.close();
            return true;
        } catch(Exception e){
            this.error = e.getMessage();
            return false;        
        }  
    }
    public boolean updateName(){
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn;
	    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/police_database?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            PreparedStatement pstmt = conn.prepareStatement("UPDATE background SET lastName = ?, firstName = ? WHERE backgroundId = ?");
            pstmt.setString(1, this.lName);
            pstmt.setString(2, this.fName);        
            pstmt.setInt(3, this.id);
            
            pstmt.executeUpdate();
            pstmt.close();        
            conn.close();
            return true;
        } catch (Exception e){
            this.error = e.getMessage();
            return false;
        }
    }
    
    public boolean updateStatus(){
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn;
	    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/police_database?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            PreparedStatement bDate = conn.prepareStatement("SELECT birthdate, yearOfDeath FROM background WHERE backgroundId = ?");
            bDate.setInt(1, this.id);
            ResultSet rst = bDate.executeQuery();
            while(rst.next()){
                this.birthdate = rst.getDate("birthdate");
                this.dateOfDeath = rst.getDate("yearOfDeath");
            }
            
            if (this.dateOfDeath != null){
                this.error = "The year of death for this individual has already been established.";
                bDate.close();
                conn.close();
              return false;
            } else if (this.birthdate.compareTo(this.dateOfDeath) > 0){
                this.error = "The date provided is not valid. Please verify and try again.";
                bDate.close();
                conn.close();
                return false;
            } else{
                PreparedStatement pstmt = conn.prepareStatement("UPDATE background SET status = ?, yearOfDeath = ? WHERE backgroundId = ?");
                pstmt.setString(1, "Deceased");
                pstmt.setDate(2, this.dateOfDeath);        
                pstmt.setInt(3, this.id);
            
                pstmt.executeUpdate();
                bDate.close();
                pstmt.close();
                conn.close();
                return true;
            }
        } catch (Exception e){
            this.error = e.getMessage();
            return false;
        }
    }
    public boolean getAlivePersons() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn;
	    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/police_database?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            
            PreparedStatement stmt = conn.prepareStatement("SELECT * FROM backgrounds WHERE ISNULL(yearOfDeath)");
            ResultSet res = stmt.executeQuery();
            
            idList.clear();
            lNameList.clear();
            fNameList.clear();
            birthdateList.clear();
            dateOfDeathList.clear();
            sexList.clear();
            professionList.clear();
            addressIdList.clear();
            statusList.clear();

            while (res.next()) {
                idList.add(res.getInt("backgroundId"));
                lNameList.add(res.getString("lastName"));
                fNameList.add(res.getString("firstName"));
                birthdateList.add(res.getDate("birthdate"));
                sexList.add(res.getString("sex").charAt(0));
                professionList.add(res.getString("profession"));
                addressIdList.add(res.getInt("addressId"));
                statusList.add(res.getString("status"));
                dateOfDeathList.add(res.getDate("yearOfDeath"));
            }
            
            stmt.close();
            conn.close();
            
            return true;
        }catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    public static void main(String[] args){

    } 
}
