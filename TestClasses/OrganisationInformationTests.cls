@isTest class OrganisationInformationTests {
    @isTest static void testGetObjectsInOrgShouldReturnMapOfAllObjectNamesAndObjectDetailsInAnOrg(){
        Test.startTest();	
	        Map<String, Schema.SObjectType> orgInstances = new OrganisationInformation().getObjectsInOrg();
        Test.stopTest();
        
        Integer expected = 0;
        Integer actual = orgInstances.values().size();
        
        System.assertNotEquals(expected, actual,
            'Should Return Map Of All Object\'s Name And Object Details In An Org');
    }
}