package ccinfom.database;

import java.text.SimpleDateFormat;
import java.sql.*;
import java.util.*;

public class Common {
    public static List<Map.Entry<String, Map<String, Integer>>> cityCrime;
    public static Map<String, Integer> cityTotal = new LinkedHashMap<>();
    
    public static java.sql.Date toDate(String string_date) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); 
        java.sql.Date date = null;
        try{
            java.util.Date vTDate = sdf.parse(string_date);
            date = new java.sql.Date(vTDate.getTime());
        } catch (Exception e){
            e.printStackTrace();
        }
        return date;
    }
    
    public static java.sql.Date getCurrentDate(){
        java.util.Date cDate = new java.util.Date();
        java.sql.Date sDate = new java.sql.Date(cDate.getTime());
        return sDate;
    }    
    
    public static Map<String, Integer> typeCount(int precinctid){        
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/police_database?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            
            PreparedStatement pstmt = conn.prepareStatement("SELECT  type, count(*) as count FROM incidents WHERE precinctid = ? GROUP BY  type");
            pstmt.setInt(1, precinctid);
            ResultSet rst = pstmt.executeQuery();
            
            Map<String, Integer> distribution = new HashMap<>();
            while(rst.next())
                distribution.put(rst.getString("type"), rst.getInt("count"));
            
            conn.close();
            pstmt.close();
            return distribution;
        } catch(Exception e){
            return null;
        }
    }
    
    public static List<Map.Entry<String, Map<String, Integer>>> getData(){
        Map<String, Map<String, Integer>> cityDistribution = new HashMap<>();
        
        Precinct p = new Precinct();
        p.getPrecinctList();
        
        for (int i = 0; i < p.precinctIDList.size(); i++){
            Map<String, Integer> temp = typeCount(p.precinctIDList.get(i));
            String cityName = p.cityJurisdictionList.get(i);
            if (temp != null)
                cityDistribution.put(cityName, temp);
        }
        
        List<Map.Entry<String, Map<String, Integer>>> sortedList = new ArrayList<>(cityDistribution.entrySet());
        
        sortedList.sort((entry1, entry2) -> {
            int sum1 = entry1.getValue().values().stream().mapToInt(Integer::intValue).sum();
            int sum2 = entry2.getValue().values().stream().mapToInt(Integer::intValue).sum();
            return Integer.compare(sum1, sum2);
        });
        for (Map.Entry<String, Map<String, Integer>> entry : sortedList){
            int total = entry.getValue().values().stream().mapToInt(Integer::intValue).sum();
            Common.cityTotal.put(entry.getKey(), total);
        }

        Common.cityCrime = sortedList;
        return sortedList;
    }
    
    public static Map<String, Integer> getCityMap(String key){
        getData();
        for (Map.Entry<String, Map<String, Integer>> entry : Common.cityCrime){
            if (entry.getKey().equals(key))
                return entry.getValue();
        }
        return null;
    }
    
    
    public static ArrayList<String> formatText(){
        getData();
        ArrayList<String> sortedCities = new ArrayList<>();
        for (Map.Entry<String, Map<String, Integer>> entry : Common.cityCrime){
            sortedCities.add(entry.getKey());
        }
        return sortedCities;
    }
    
    
}
