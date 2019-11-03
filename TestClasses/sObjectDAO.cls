public class sObjectDAO implements ISObjectDAO {
    public interface ISObjectDAO{
        List<sObject> getObjects(String fieldNames, String queryObject);
        List<sObject> getObjects(String fieldNames, String queryObject, String sortOrder);
    }
    
    public static List<sObject> getObjects(String fieldNames, String queryObject){
        return Database.query(
            'SELECT '+ fieldNames
            +' FROM '+ queryObject
        );
    }
    
    public static List<sObject> getObjects(String fieldNames, String queryObject, String sortOrder){
        return Database.query(
            'SELECT '+ fieldNames
            +' FROM '+ queryObject
            +' ORDER BY '+ sortOrder
        );
    }
}