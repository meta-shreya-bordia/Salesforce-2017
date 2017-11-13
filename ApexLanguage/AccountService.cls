public class AccountService {
    public static Account updateAccountContactId(Id contactId){
        Account act = AccountDAO.getAccountContacts(contactId);
        List<Contact> listOfContacts = act.contacts;
        
        if(listOfContacts != null && listOfContacts.size() > 0){
            System.debug('HERE:'+ listOfContacts.size() + ' : ' + listOfContacts[0].Id + ' :  '+  listOfContacts[1].Id + ' : '+ act.ContactIDs__c );
			String cntId = act.ContactIDs__c;            
        	for(Contact contact :listOfContacts){
            	if( cntId == null || !cntId.contains(contact.Id) ){
                	cntId += contact.Id + ',';
                }
            }
            act.ContactIDs__c = cntId;            
	    	update act;
       	}
        
        return act;
    }
}