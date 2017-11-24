@isTest class StackTests {
    static final String ERROR_MSG = 'Stack does not contain same records';
    
    @isTest
    static void testEmptyStack(){
        Stack stack = new Stack();
        
        Test.startTest();
        	stack.pop();
        Test.stopTest();
        
        Integer expected = 0;
        Integer actual = stack.size();
        
        System.assertEquals(expected, actual, ERROR_MSG);
    }
    
    @isTest
    static void testStackPush(){
        Stack stack = new Stack();

        Test.startTest();
        	stack.push('TEST');
        Test.stopTest();
        
        Integer expected = 1;
		Integer actual = stack.size();
        
        System.assertEquals(expected, actual, ERROR_MSG);
    }
    
    @isTest
    private static void testStackPop(){
        Stack stack = new Stack();
        stack.push('TEST');

        Test.startTest();
        	Object actual = stack.pop();
        Test.stopTest();

        Object expected = 'Test';
        
        System.assertEquals(expected, actual, ERROR_MSG);
    }
}