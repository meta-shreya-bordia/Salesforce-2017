public class ContactDAO implements IContactDAO {
    public interface IContactDAO{
    	List<Contact> getMatchedContacts(String lastName, String postalCode);
        List<Contact> getContactsInOrder(String sortOrder);
        List<Contact> getContacts();
        void createContacts(List<Contact> listOfContacts);
        List<Contact> getTeacherDetails(List<Contact> listOfContacts);
    }
    
    /**@Method	getMatchedContacts
     * contact with matching lastname and same postalCode
	*/
    public static List<Contact> getMatchedContacts(String lastName, String postalCode){
        return [
            SELECT Id, Name 
            FROM Contact 
            WHERE (LastName = :lastName 
            	AND MailingPostalCode = :postalCode) 
        ];
    }
    
    /**
     * Dynamic query: when parameters of query change at runtime
	**/
    public static List<Contact> getContactsInOrder(String sortOrder){
        return Database.query(
        	'SELECT Id, FirstName, LastName, Title, Email '+
            'FROM Contact '+
            'ORDER BY '+ sortOrder + ' ASC '+
            'LIMIT 10 '
        );
    }
    
    public static void createContacts(List<Contact> listOfContacts){
        insert listOfContacts;
    }
    
    public static List<Contact> getContacts(){
       return [
           SELECT Id 
           FROM Contact
       ];
   }
    
    public static List<Contact> getTeacherDetails(List<Contact> listOfContacts){
        return [
			SELECT Id, Subjects__c
            FROM Contact
        ];
    }
}