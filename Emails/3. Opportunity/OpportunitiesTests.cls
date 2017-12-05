@isTest class OpportunitiesTests {
    static final Integer noOfAccounts = 3;
    static final Integer noOfContacts = 2;
    static final Integer noOfOpportunities = 3;
    static final Integer noOfPricebooks = 3;
    static final Integer noOfProducts = 2;
    static final Integer noOfOpportunityLineItems = 2;
    static final String TEST_NAME = 'Opportuntiy';
    static final String TEST_STAGENAME = 'Prospecting';
    static final Integer TEST_QUANTITY = 2;
    static final Decimal TEST_PRICE = 20.2;
    static final String EXPECTED_STAGENAME = 'Closed Won';
    static final String EXPECTED_STATUS = 'Reset';
    
    static List<Opportunity> getOpportunities(){
        return [
            SELECT Id, StageName, CloseDate, Custom_Status__c, BillToContact__c, Manager__c,
            	(SELECT Id
            	FROM OpportunityLineItems)
            FROM Opportunity
            WHERE Name LIKE :TEST_NAME + '%'
        ];
    }
    
    static List<Account> getAccounts(){
        return [
            SELECT Id
            FROM Account
        ];
    }
    
    static List<Contact> getContacts(){
         return [
            SELECT Id, AccountId
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
        
		List<Opportunity> listOfOpportunities = new List<Opportunity>();
        for(Integer index = 0; index<noOfOpportunities; index++){
            Opportunity opportunity = new Opportunity(
                Name = TEST_NAME +index,
                StageName = TEST_STAGENAME,
                CloseDate = System.Today() - 7,
                AccountId = listOfAccounts[0].Id,
                BillToContact__c = listOfContacts[0].Id);
            
            listOfOpportunities.add(opportunity);
        }
        insert listOfOpportunities;
        
        List<Pricebook2> listOfPriceBooks = new List<Pricebook2>();
        for(Integer index = 0; index < noOfPriceBooks; index++){
            listOfPriceBooks.add( new Pricebook2(Name = TEST_NAME+index));
        }
        insert listOfPriceBooks;
        
        List<Product2> listOfProducts = new List<Product2>();
        for(Integer index = 0; index < noOfProducts; index++){
            listOfProducts.add( new Product2(
                Name = TEST_NAME+index,
           	    isActive = true));
        }
        insert listOfProducts;
        
        List<PricebookEntry> listOfPricebookEntries = new List<PricebookEntry>();
        for(Integer index = 0; index < noOfProducts; index++){
            PricebookEntry pricebookEntry = new PricebookEntry(
                Unitprice = 1,
                Product2Id = listOfProducts[index].Id,
                Pricebook2Id = Test.getStandardPricebookId(),
                isActive=true,
                UseStandardPrice = false);
            
            listOfPricebookEntries.add(pricebookEntry);
        }
        insert listOfPricebookEntries;
            
        List<OpportunityLineItem> listOfOpportunityLineItem = new List<OpportunityLineItem>();
        for(Integer index = 0; index < noOfOpportunityLineItems; index++){
            listOfOpportunityLineItem.add(new OpportunityLineItem (
                Quantity = TEST_QUANTITY, 
                OpportunityId = listOfOpportunities[0].Id,
                UnitPrice = TEST_PRICE,
                PriceBookEntryId = listOfPriceBookEntries[0].Id));
        }
        insert listOfOpportunityLineItem;
        
        listOfOpportunities[0].StageName = EXPECTED_STAGENAME;
        listOfOpportunities[0].Custom_Status__c = EXPECTED_STATUS;
    }

    @isTest static void testUpdateOppCloseDateShouldUpdateCloseDateToTodayWhenStageIsClosed(){
		List<Opportunity> listOfOpportunities = getOpportunities();
        
        Test.startTest();
            update listOfOpportunities;
        Test.stopTest();
        
        Date expected = System.today();
        Date actual = listOfOpportunities[0].CloseDate;
        
        System.assertEquals(expected, actual, 'Opportunity close date should be today\'s date');
    }
    
    @isTest static void testUpdateOppCloseDateShouldNotUpdateCloseDateToTodayWhenStageIsAlreadyClosed(){
        List<Opportunity> listOfOpportunities = getOpportunities();
        
        Test.startTest();
            update listOfOpportunities;
        Test.stopTest();
        
        Date expected = System.today() - 7;
        Date actual = listOfOpportunities[0].CloseDate;
        
        System.assertEquals(expected, actual, 'Opportunity close date must not be modified');
    }
    
    @isTest static void testUpdateAccountManagerShouldSetManagerFieldWithCorrespondingContactAccount(){
		List<Opportunity> listOfOpportunities = getOpportunities();
        
        Test.startTest();
            update listOfOpportunities;
        Test.stopTest();
        
        Id expected = getAccounts()[0].Id;
        Id actual = listOfOpportunities[0].Manager__c;
        
        System.assertEquals(expected, actual, 'Should Set Manager Field With Corresponding Contact Account');        
    }
    
    @isTest static void testDeleteRelatedOpportunityLineItemsShouldDeleteLineItemsWhenStatusIsReset(){
        List<Opportunity> listOfOpportunities = getOpportunities();
        
        Test.startTest();
            update listOfOpportunities;
        Test.stopTest();
        
        Integer expected = 0;
        Integer actual = listOfOpportunities[0].OpportunityLineItems.size();
        
        System.assertEquals(expected, actual, 'Should Delete Line Items When Status Is Reset');        
    }
    
    @isTest static void testOnBeforeUpdateShouldUpdateOpportunityManagerToSetAccount(){
        List<Opportunity> listOfOpportunities = getOpportunities();
        
        Test.startTest();
            update listOfOpportunities;
        Test.stopTest();
        
	    Id expectedManager = getAccounts()[0].Id;
        Id actualManager = listOfOpportunities[0].Manager__c;
        
        System.assertEquals(expectedManager, actualManager, 'Should Set Manager Field With Corresponding Account');           
        
        Date expectedCloseDate  = System.today();
        Date actualCloseDate = listOfOpportunities[0].CloseDate;
        
        System.assertEquals(expectedCloseDate, actualCloseDate, 'Opportunity close date should be today\'s date');        
    }

    @isTest static void testOnAfterUpdateShouldDeleteAssociatedOpportunityLineItemsOnReset(){
        List<Opportunity> listOfOpportunities = getOpportunities();
        
        Test.startTest();
            update listOfOpportunities;
        Test.stopTest();
        
        Integer expected = 0;
        Integer actual = listOfOpportunities[0].OpportunityLineItems.size();
        
        System.assertEquals(expected, actual, 'Should Delete Line Items When Status Is Reset');        
    }
}