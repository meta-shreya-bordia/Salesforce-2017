public class Accounts extends fflib_SObjectDomain {
    public Accounts(List<SObject> sObjectList) {
        super(sObjectList);
    }

    public class Constructor implements fflib_SObjectDomain.IConstructable {
        public fflib_SObjectDomain construct(List<SObject> sObjectList) {
            return new Accounts(sObjectList);
        }
    }
      
    public override void onAfterInsert(){
        updateChildCount();
    }
    
    public override void onAfterDelete(){
        updateChildCount();
    }
    
    public override void onAfterUpdate(Map<Id,SObject> existingRecords) {
    	updateChildCount();
    }
    
    void updateChildCount(){
        List<Id> listOfAccounts = new List<Id>();
        for(Account account :(List<Account>) Records){
            listofAccounts.add( account.Parent_Account__c ); 
        }
        
        List<Account> listOfParentAccounts = 
            AccountDAO.getAccountsParentAccountDetails(listOfAccounts);
        
        for(Account parentAccount :listOfParentAccounts){
           parentAccount.Child_Count__c = parentAccount.Accounts__r.size();
		}
        
        update listOfParentAccounts;
    }
}