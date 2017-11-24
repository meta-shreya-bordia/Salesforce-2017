@isTest class BillToContactControllerTests {
    static final Integer noOfAccounts = 2;
    static final Integer noOfContacts = 3;
    
    static final String TEST_NAME = 'Name';
    static final String TEST_STAGE = 'Prospecting';
    static final Date TEST_DATE = System.today();
    
    static final String ERROR_MSG = 'Controller does not return expected results';
    
    static BillToContactController getClassObject(){
        ApexPages.currentPage().getParameters().put('id', getOpportunity().Id);
        
        BillToContactController controller = new BillToContactController();
        controller.billToContact = getContacts()[0].Id; 
        
        return controller;
    }
    
    static Opportunity getOpportunity(){
        return [
            SELECT Id, Manager__c, BillToContact__c
            FROM Opportunity
        ];
    }
    
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
    
    @testSetup static void setup(){
        List<Account> listOfAccounts = new List<Account>();
        for(Integer index = 0; index < noOfAccounts; index++){
            Account account = new Account(Name=TEST_NAME+index);
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
        
        Opportunity opportunity = new Opportunity(
        	Name = TEST_NAME,
            StageName = TEST_STAGE,
            CloseDate = TEST_DATE,
            Manager__c = listOfAccounts[0].Id
        );
        insert opportunity;
    }
    
    @isTest static void testContactAsManagerShouldGetManagingAccountContacts(){
        BillToContactController controller = getClassObject();
        
        Test.startTest();
        	List<SelectOption> listOfSelectOptions = controller.contactAsManager;
        Test.stopTest();
        
        Integer expected = getContacts().size();
        Integer actual = listOfSelectOptions.size();
          
        System.assertEquals(expected, actual, ERROR_MSG);
    }
    
    @isTest static void testContactAsManagerShouldNotSetBillToContactWhenManagerIsNull(){
        BillToContactController controller = getClassObject();
        controller.opportunity.Manager__c  = null;
        
        Test.startTest();
        	List<SelectOption> listOfSelectOptions = controller.contactAsManager;
        Test.stopTest();
        
        Integer expected = 0;
        Integer actual = listOfSelectOptions.size();
          
        System.assertEquals(expected, actual, ERROR_MSG);
    }
    
    @isTest static void testSaveShouldUpdateBillToContactWithSelectedContact(){
        BillToContactController controller = getClassObject();
        
        Test.startTest();
        	controller.save();
        Test.stopTest();
        
        Id expected = getContacts()[0].Id;
        Id actual = getOpportunity().BillToContact__c;
        
        System.assertEquals(expected, actual, ERROR_MSG);
    }
    
    
    @isTest static void testcClearShouldResetOportunityBillToContact(){
        BillToContactController controller = getClassObject();
        
        Test.startTest();
        	controller.clear();
        Test.stopTest();
        
        Id expected = null;
        Id actual = controller.billToContact;
        
        System.assertEquals(expected, actual, ERROR_MSG);
    }
    
    @isTest static void testCancelShouldRedirectToOpportunityPageWithoutUpdateingBillToContactField(){
		BillToContactController controller = getClassObject();
        
        Test.startTest();
        	PageReference redirect = controller.cancel();
        Test.stopTest();
        
        String expected = new PageReference('/'+getOpportunity().Id).getUrl();
        String actual = redirect.getUrl();
        
        System.assertEquals(expected, actual, ERROR_MSG);        
    }
}