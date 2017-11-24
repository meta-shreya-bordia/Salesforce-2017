@isTest class ObjectListControllerTests { 
    static final Integer noOfOpportunities = 5;
    static final Integer TEST_SIZE = 2;
    static final Integer TEST_PAGE = 2;
    static final Date TEST_DATE = System.today();
    
    static final String TEST_FIELDS = 'Id,Name,StageName,CloseDate';
    static final String TEST_NAME = 'Test';
    static final String TEST_STAGE = 'Prospecting';
    static final String TEST_SOBJECT = 'Opportunity';
    
    static final String sortOrder = 'StageName';
    static final String ERROR_MSG = 'Controller does not return required records';
    
    static ObjectListController getController(){
    	ObjectListController controller = new ObjectListController();
        controller.queryObject = TEST_SOBJECT;
        controller.size = TEST_SIZE;
   		return controller;
    }
    
    static List<SObject> getRecords(){
        return Database.query(
        	'SELECT '+TEST_FIELDS
            +' FROM '+TEST_SOBJECT
            +' ORDER BY '+sortOrder
        );
    }
    
    @testSetup static void setup(){
        List<Opportunity> listOfOpportunities = new List<Opportunity>();
        for(Integer index = 0; index < noOfOpportunities; index++){
            Opportunity opportunity = new Opportunity(
                Name = TEST_NAME + index,
                StageName = TEST_STAGE,
                CloseDate = TEST_DATE
            );
            listOfOpportunities.add(opportunity);
        }
        insert listOfOpportunities;
    }
    
    @isTest static void testGetListOfFieldNamesShouldReturnAllFieldNamesForSObject(){
        ObjectListController controller = getController();
        
        Test.startTest();
        	List<String> listOfFieldNames = controller.getFieldNames();
        Test.stopTest();
        
        Integer expected = 0;
        Integer actual = listOfFieldNames.size();
        
        System.assertNotEquals( expected, actual, ERROR_MSG);
    }
    
    @isTest static void testGetObjectListShouldGetAllRecordsForAnSObject(){
        ObjectListController controller = getController();
        
        Test.startTest();
        	List<sObject> listOfSObjects = controller.getObjectList();
        Test.stopTest();
        
        Integer expected = TEST_SIZE;
        Integer actual = listOfSObjects.size();
        
        System.assertEquals( expected, actual, ERROR_MSG);
    }
    
    @isTest static void testSortingShouldSortResultPerSortingOrderSpecified(){
        ObjectListController controller = getController();
		controller.sortOrder = sortOrder;
        
        Test.startTest();
        	controller.sorting();
        Test.stopTest();
        
        Opportunity opportunity = (Opportunity)controller.getObjectList()[0];
        
        String expected = TEST_STAGE;
        String actual = opportunity.StageName;
        
        System.assertEquals( expected, actual, ERROR_MSG);
    }
    
    @isTest static void testGoToPageShouldNavigateToPage(){
        ObjectListController controller = getController();
		controller.jumpToPage = TEST_PAGE;
        
        Test.startTest();
        	controller.goToPage();
        Test.stopTest();
        
        Integer expected = TEST_PAGE;
        Integer actual = controller.controller.getPageNumber();
        
        System.assertEquals( expected, actual, ERROR_MSG);
    }
}