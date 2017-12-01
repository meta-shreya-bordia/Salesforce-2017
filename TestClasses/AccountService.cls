public class AccountService {
    public static Account updateAccountContactId(Id contactId){
        Account account = AccountDAO.getAccountFromContact(contactId);
        List<Contact> listOfContacts = account.contacts;
 
        if(listOfContacts != null && listOfContacts.size() > 0){
            String cntId = account.ContactIDs__c;            
            for(Contact contact :listOfContacts){
                if( cntId == null){
                    cntId='';
                }if( !cntId.contains(contact.Id) ){
                    cntId += contact.Id + ',';
                }
            }
            account.ContactIDs__c = cntId;            
	        update account;
        }
        
        return account;
    }
}