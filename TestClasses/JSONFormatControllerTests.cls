@isTest class JSONFormatControllerTests {
    static final String expectedJsonString =  '{"attributes":';
    
    @isTest static void testJSONFormatShouldReturnJSONString(){
        Test.startTest();
            String actual = new JSONFormatController().jsonString;
        Test.stopTest();
        
        Boolean expected = actual.contains(expectedJsonString);
        System.assert(expected, 'JSON string does not contain account object attributes');
    }
}