public class CityManagerDAO implements ICityManagerDAO {

    public interface ICityManagerDAO {
        List<CityManager__c> getManagerByCity();
    }
    
    public static List<CityManager__c> getManagerByCity(){
        return [
            SELECT Id, City__c
            FROM CityManager__c
        ];
    }
}