@isTest class JSONFormatControllerTests {
	static final String expectedJsonString =  '{"attributes":';
    static final String ERROR_MSG = 'Json String does not parse an object';
    
    @isTest
    static void testJSONFormatShouldReturnJSONString(){
        Test.startTest();
        	String actual = new JSONFormatController().jsonString;
        Test.stopTest();
        
        Boolean expected = actual.contains(expectedJsonString);
        System.assert(expected, ERROR_MSG);
    }
}