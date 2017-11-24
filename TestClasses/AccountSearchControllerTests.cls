@isTest class AccountSearchControllerTests {
	static final Integer noOfAccounts = 2;
    
    static final String TEST_NAME = 'Test';
    static final String TEST_BILLING_CITY = 'City';
    static final String TEST_BILLING_STATE = 'State';
    static final String TEST_BILLING_COUNTRY = 'Country';
    static final String ERROR_MSG = 'Account does not contain required records';
    
    static List<Account> getAccounts(){
        return [
            SELECT Id, Name,
            	BillingCity,BillingState,BillingCountry
            FROM Account
            WHERE Name LIKE :TEST_NAME+'%'
        ];
    }
    
    static AccountSearchController getClassObject(){
        return new AccountSearchController();
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
    }
    
    @isTest static void testGetAccountsReturnsListOfAccounts(){
        Test.startTest();
            List<Account> listOfAccounts = getClassObject().getAccounts();
        Test.stopTest();
        
        Integer expected = noOfAccounts;
        Integer actual = listOfAccounts.size();
        
        System.assertEquals( expected, actual, ERROR_MSG );
    }
    
    @isTest static void testSearchShouldSearchFieldAccountsByBillingAddress(){
        AccountSearchController controller = getClassObject();
        controller.billingCity = TEST_BILLING_CITY;
        controller.billingState = TEST_BILLING_STATE;
	    controller.billingCountry = TEST_BILLING_COUNTRY;
            
        Test.startTest();
	        controller.search();
        Test.stopTest();
        
        List<Account> listOfAccounts = controller.getAccounts();
        String expected = TEST_NAME+0;
        String actual = listOfAccounts[0].Name;
        
        System.assertEquals( expected, actual, ERROR_MSG );
    }
    
     @isTest static void testSearchShouldSearchFieldAccountsByBillingState(){
        AccountSearchController controller = getClassObject();
        controller.billingState = TEST_BILLING_STATE;
            
        Test.startTest();
	        controller.search();
        Test.stopTest();
        
        List<Account> listOfAccounts = controller.getAccounts();
        String expected = TEST_NAME+0;
        String actual = listOfAccounts[0].Name;
        
        System.assertEquals( expected, actual, ERROR_MSG );
    }
    
    @isTest static void testSearchShouldSearchFieldAccountsByBillingCountry(){
        AccountSearchController controller = getClassObject();
        controller.billingCountry = TEST_BILLING_COUNTRY;
            
        Test.startTest();
	        controller.search();
        Test.stopTest();
        
        List<Account> listOfAccounts = controller.getAccounts();
        String expected = TEST_NAME+0;
        String actual = listOfAccounts[0].Name;
        
        System.assertEquals( expected, actual, ERROR_MSG );
    }
}