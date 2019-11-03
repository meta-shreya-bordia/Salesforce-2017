@isTest class OpportunityDAOTests {
    static final Integer noOfOpportunities = 3;
    static final Integer noOfPricebooks = 3;
    static final Integer noOfProducts = 2;
    static final Integer noOfOpportunityLineItems = 2;
    static final String TEST_NAME = 'Opportuntiy';
    static final String TEST_STAGENAME = 'Prospecting';
    static final Integer TEST_QUANTITY = 2;
    static final Decimal TEST_PRICE = 20.2;
    
    static List<Opportunity> getOpportunities(){
        return [
            SELECT Id
            FROM Opportunity
            WHERE Name LIKE :TEST_NAME + '%'
        ];
    }
    
    @testSetup static void setup(){
        List<Opportunity> listOfOpportunities = new List<Opportunity>();
        
        for(Integer index = 0; index<noOfOpportunities; index++){
            Opportunity opportunity = new Opportunity(
                Name = TEST_NAME +index,
                StageName = TEST_STAGENAME,
                CloseDate = System.Today() - 7);
            
            listOfOpportunities.add(opportunity);
        }
        insert listOfOpportunities;
        
        List<Pricebook2> listOfPriceBooks = new List<Pricebook2>();
        for(Integer index = 0; index < noOfPricebooks; index++){
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
    }
    
    @isTest static void testGetOpportunityShouldReturnAllOpportunityDetails(){
        Id opportunityId = getOpportunities()[0].Id;
        
        Test.startTest();
            Opportunity opportunity = OpportunityDAO.getOpportunity(opportunityId);
        Test.stopTest();
        
        Id expected = opportunityId;
        Id actual = opportunity.Id;
        
		System.assertEquals(expected, actual, 'Should Return All Opportunity Details');        
    }
    
    @isTest static void testGetRelatedOpportunityLineItemShouldReturnRelatedProductsOfEachOpportunity(){
        List<Opportunity> listOfOpportunities = getOpportunities();
        
        Test.startTest();
            List<Opportunity> listOfOpportunityLineItems = OpportunityDAO.getRelatedOpportunityLineItem(listOfOpportunities);
        Test.stopTest();
        
        Integer expected = noOfOpportunityLineItems;
        Integer actual = listOfOpportunityLineItems[0].OpportunityLineItems.size();
        
		System.assertEquals(expected, actual, 'Should Return Related Products Of Each Opportunity');        
    }
    
    @isTest static void testGetUnmodifiedOpportunitiesShouldReturnOpporunitiesUnModifiedForMoreThanThirtyDays(){
    	Test.startTest();
            List<Opportunity> listOfOpportunities = OpportunityDAO.getUnmodifiedOpportunities();
        Test.stopTest();
        
        Integer expected = 0;
        Integer actual = listOfOpportunities.size();
        
		System.assertEquals(expected, actual, 'Should Return Opporunities UnModified For More Than Thirty Days');            
    }
}