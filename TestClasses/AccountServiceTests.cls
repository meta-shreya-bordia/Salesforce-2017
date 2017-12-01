@isTest class AccountServiceTests {
    static final Integer noOfAccounts = 2;
    static final Integer noOfContacts = 3;
	static final String TEST_NAME = 'Test';
        
    static List<Contact> getContacts(){
        return [
            SELECT Id
            FROM Contact
            WHERE Name LIKE :TEST_NAME+'%'
        ];
    }
    
    @testSetup static void setup(){
        List<Account> listOfAccounts = new List<Account>();
        for(Integer index = 0; index < noOfAccounts; index++){
            Account account = new Account(Name = TEST_NAME + index);
            listOfAccounts.add(account);
        }
        insert listOfAccounts;
        
        List<Contact> listOfContacts = new List<Contact>();
        for(Integer index = 0; index < noOfContacts; index++){
            Contact contact = new Contact(
                LastName= TEST_NAME + index,
                AccountId = listOfAccounts[0].Id );
            listOfContacts.add(contact);
        }
        insert listOfContacts;
    }
    
    @isTest static void testUpdateContactIdListShouldUpdateAccountContactIdWithListOfRelatedContacts(){
        List<Contact> listOfContacts = getContacts();
        
        Test.startTest();
            Account account = AccountService.updateAccountContactId( listOfContacts[0].Id);
    	Test.stopTest();
        
        String expected = '';
        for(Contact contact :listOfContacts){
            expected += contact.Id + ',';
        }
        expected = expected.removeEnd(',');
        String actual = account.ContactIDs__c;
        
        System.assertEquals(expected, actual, 'Account\'s field ContactIDs must be updated with list of related contacts');
    }
}