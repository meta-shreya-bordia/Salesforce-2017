public class ProductDAO implements IProductDAO {

    public interface IProductDAO {
        Map<Id, Product__c> getAllProductDetails();
        List<Product__c> getAllProductDetails(Map<Id, Product__c> mapOfProducts, String searchTerm);
        List<String> getProductCategory();
        List<Product__c> getProductByCategory(Set<Id> setOfIds, String searchCategory);
    }
    
    public static Map<Id, Product__c> getAllProductDetails(){
        return new Map<Id, Product__c>( [
            SELECT Id, ProductCode__c, UnitPrice__c, Name, Category__c
            FROM Product__c
        ]);
    }
    
    public static List<Product__c> getAllProductDetails(
        Map<Id, Product__c> mapOfProducts, String searchTerm){
        return [
            SELECT Id, ProductCode__c, UnitPrice__c, Name, Category__c
            FROM Product__c
            WHERE Name LIKE :searchTerm+'%'
                AND Id IN :mapOfProducts.keySet()
        ];
    }
    
    public static List<String> getProductCategory(){
        Set<String> setOfCategories = new Set<String>();

        List<Product__c> listOfProducts = [
            SELECT Category__c
            FROM Product__c
        ];
        
        for(Product__c product :listOfProducts){
            setOfCategories.add(product.Category__c);
        }
        
        return new List<String>( setOfCategories );
    }

    public static List<Product__c> getProductByCategory(
        Set<Id> setOfIds, String searchCategory){
        
        return [
            SELECT Id, ProductCode__c, UnitPrice__c, Name, Category__c
            FROM Product__c 
	    WHERE Category__c = :searchCategory
            	AND Id IN :setOfIds
        ];
    }
}
