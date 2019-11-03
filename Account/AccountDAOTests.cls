@isTest
class AccountDAOTests {
	static final Integer noOfAccounts = 2;
    static final Integer noOfContacts = 3;
    
    static final String TEST_NAME = 'Test';
    static final String TEST_BILLING_CITY = 'City';
    static final String TEST_BILLING_STATE = 'State';
    static final String TEST_BILLING_COUNTRY = 'Country';
    static final String ERROR_MSG = 'Account does not contain required records';

    static List<Contact> getContacts(){
        return [
            SELECT Id
            FROM Contact
            WHERE Name LIKE :TEST_NAME+'%'
        ];
    }
    static List<Account> getAccounts(){
        return [
            SELECT Id
            FROM Account
            WHERE Name LIKE :TEST_NAME+'%'
        ];
    }
    
    @testSetup
    static void setup(){
        List<Account> listOfAccounts = new List<Account>();
        for(Integer index = 0; index < noOfAccounts; index++){
            Account account = new Account(
                Name=TEST_NAME+index,
            	BillingCity = TEST_BILLING_CITY,
            	BillingState = TEST_BILLING_STATE,
            	BillingCountry = TEST_BILLING_COUNTRY);
            listOfAccounts.add(account);
        }
        insert listOfAccounts;
        
        List<Contact> listOfContacts = new List<Contact>();
        for(Integer index=0; index<noOfContacts; index++){
            Contact contact = new Contact(
                LastName=TEST_NAME+index,
                AccountId = listOfAccounts[0].Id );
            listOfContacts.add(contact);
        }
        insert listOfContacts;
    }
    
    @isTest
    static void testgetRelatedContactsReturnsListOfAccountsContact(){
        List<Account> listOfTestAccounts = getAccounts();
            
        Test.startTest();
            Account account = AccountDAO.getRelatedContacts(listOfTestAccounts[0].Id);
        Test.stopTest();
        
        Integer expected = noOfContacts;
        Integer actual = account.contacts.size();
        
        System.assertEquals( expected, actual, ERROR_MSG );
    }
    
    @isTest
    static void testgetAccountFromContactReturnsAccountWithContact(){
        List<Contact> listOfContacts = getContacts();
            
        Test.startTest();
            Account account = AccountDAO.getAccountFromContact(listOfContacts[0].Id);
        Test.stopTest();
        
        Integer expected = noOfContacts;
        Integer actual = account.contacts.size();
        
        System.assertEquals( expected, actual, ERROR_MSG );
    }
    
    @isTest
    static void testgetByBillingAddressReturnsAccountsOrderedByBillingAddress(){
        String whereClause = 'where billingCity = \'' +TEST_BILLING_CITY
            +'\' AND billingState = \'' +TEST_BILLING_STATE
            +'\' AND billingCountry = \'' +TEST_BILLING_COUNTRY +'\'';
            
        Test.startTest();
            List<Account> listOfAccounts = AccountDAO.getByBillingAddress(whereClause);
        Test.stopTest();
        
        Integer expected = noOfAccounts;
        Integer actual = listOfAccounts.size();
        
        System.assertEquals( expected, actual, ERROR_MSG );
    }
}