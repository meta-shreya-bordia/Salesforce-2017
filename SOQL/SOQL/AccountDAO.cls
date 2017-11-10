public class AccountDAO implements IAccountDAO { 
    public interface IAccountDAO {
        List<Account> getAccountsByCreationDate(Integer numOfRecords);
        void updateAccounts(List<Account> listOfAccounts);
        Account createAccount(String acctName);
        List<Account> getRelatedContacts(List<Id> listOfAccounts);
        Account getRelatedContacts(Id accountId);
        List<Account> getContactsByBillingState(String state);
	}
    
    /**@Method	getAccountsByCreationDate
     * SOQL query to retrieve records by creation date
	*/
    public List<Account> getAccountsByCreationDate(Integer numOfRecords){
	  	return [
            SELECT Id, Description
            FROM Account 
            ORDER BY CreatedDate ASC 
            LIMIT :numOfRecords
      	];        
    }
    
    /**@Method	updateAccountList
     * DML query
	*/
    public void updateAccounts(List<Account> listOfAccounts){
        update listOfAccounts;
    }
    
    /**@Method	createAccount
     * create an account
	*/
    public Account createAccount(String acctName){
        Account acct = new Account(Name = acctName);
		insert acct;
        return acct;
    }
        
    public List<Account> getRelatedContacts(List<Id> listOfAccounts){
        return [
            SELECT Id, ContactIDs__c,
                Number_of_Contacts__c,
                (SELECT Id FROM Contacts)
            FROM Account
            WHERE Id IN :listOfAccounts
        ];
    }
    
    public Account getRelatedContacts(Id accountId){
        return [
            SELECT Id, Name, ContactIDs__c,
            	(SELECT Id, Name FROM Contacts) 
            FROM Account 
            WHERE Id = :accountId
        ];
    }
    
    public List<Account> getContactsByBillingState(String state){
        return [
            SELECT Id
            FROM Account
            WHERE BillingState = :state
        ];
    }
}