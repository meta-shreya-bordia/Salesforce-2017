public class AccountDAO implements IAccountDAO { 
    public interface IAccountDAO {
        Account getRelatedContacts(Id accountId);
        Account getAccountFromContact(Id contactId);
        List<Account> getByBillingAddress(String whereClause);
	}
        
    public static Account getRelatedContacts(Id accountId){
        return [
            SELECT Id, ContactIDs__c,
                Number_of_Contacts__c,
                (SELECT Id FROM Contacts)
            FROM Account
            WHERE Id = :accountId
        ];
    }
    
    /*Dynamic query*/
    public static List<Account> getByBillingAddress(String whereClause){
        return Database.query(
        	'SELECT Id, Name, BillingCity, BillingState, BillingCountry ' +
            'FROM Account ' +
            whereClause + 
            ' LIMIT 100 ');
    }
    
    public static Account getAccountFromContact(Id contactId){
        return [
            SELECT Id, ContactIDs__c,
			   (SELECT Id 
                FROM Contacts)
			FROM Account
			WHERE Id IN 
            	(SELECT AccountId
                 FROM Contact
                WHERE Id = :contactId)
        ];
    }
}