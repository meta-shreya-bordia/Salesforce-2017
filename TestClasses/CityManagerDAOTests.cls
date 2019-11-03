@isTest class CityManagerDAOTests {
    static final Integer noOfCityManagers = 3;
    static final String TEST_NAME = 'Test';
    static final String TEST_CITY = 'Jaipur';
    
    @testSetup static void setup(){
        List<CityManager__c> listofCityManagers = new List<CityManager__c>();
        for(Integer index = 0; index < noOfCityManagers; index++){
            CityManager__c cityManager = new CityManager__c(
                Name = TEST_NAME,
                City__c = TEST_CITY);
           
            listofCityManagers.add(cityManager);
        }
        insert listofCityManagers;
    }
    
    @isTest static void testGetManagerByCityShouldReturnManagersByTheirCity(){
        Test.startTest();
            List<CityManager__c> listofCityManagers = CityManagerDAO.getManagerByCity();
        Test.stopTest();
        
        Integer expected = noOfCityManagers;
        Integer actual = listofCityManagers.size();
        
        System.assertEquals(expected, actual, 
            'City Manager DAO must return '+noOfCityManagers+' records');
    }
}