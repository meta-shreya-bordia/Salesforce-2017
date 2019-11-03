@isTest class SObjectDAOTests {
    static Integer noOfAccounts = 2;
    static Integer noOfContacts = 3;
    static String TEST_NAME = 'Test Name';
    static final String fieldNames = 'Id,FirstName,LastName,Account.Name';
    static final String queryObject = 'Contact';
    static final String sortOrder = 'FirstName';
    
    static List<Contact> getContacts(){
        return [
            SELECT Id, FirstName, LastName
            FROM Contact
        ];
    }
    
    @testSetup static void setup(){
        List<Account> listOfAccounts = new List<Account>();
        for(Integer index = 0; index < noOfAccounts; index++){
            Account account = new Account(Name= TEST_NAME+index);
            listOfAccounts.add(account);
        }
        insert listOfAccounts;
        
        List<Contact> listOfContacts = new List<Contact>();
        for(Integer index = 0; index < noOfContacts; index++){
            Contact contact = new Contact(
                LastName= TEST_NAME+index,
                AccountId = listOfAccounts[0].Id );
            listOfContacts.add(contact);
        }
        insert listOfContacts;    
    }
    
    @isTest static void testGetObjectsShouldReturnFieldsForAnySObject(){
        Test.startTest();
            List<SObject> listOfSObjects = SObjectDAO.getObjects(fieldNames, queryObject);
        Test.stopTest();
		
		Contact expected = getContacts()[0];
        Contact actual = (Contact)listOfSObjects[0];
        
        System.assertEquals( expected.FirstName, actual.FirstName, 'Should Return All Fields For Any SObject' );
    }

    @isTest static void testGetObjectsShouldReturnSObjectSortedInSpecifiedOrder(){
        Test.startTest();
            List<SObject> listOfSObjects = SObjectDAO.getObjects(fieldNames, queryObject, sortOrder);
        Test.stopTest();
		
		Contact expected = getContacts()[0];
        Contact actual = (Contact)listOfSObjects[0];
        
        System.assertEquals( expected.FirstName, actual.FirstName,
            'Should Return SObject Sorted In Specified Order' );
    }
}