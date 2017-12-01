@isTest class StackTests {
    @isTest static void testEmptyStack(){
        Stack stack = new Stack();
        
        Test.startTest();
            stack.pop();
        Test.stopTest();
        
        Integer expected = 0;
        Integer actual = stack.size();
        
        System.assertEquals(expected, actual, 'Empty stack must have 0 size');
    }
    
    @isTest static void testStackPush(){
        Stack stack = new Stack();

        Test.startTest();
            stack.push('TEST');
        Test.stopTest();
        
        Integer expected = 1;
		Integer actual = stack.size();
        
        System.assertEquals(expected, actual, 'Stack contains an element');
    }
    
    @isTest
    private static void testStackPop(){
        Stack stack = new Stack();
        stack.push('TEST');

        Test.startTest();
            Object actual = stack.pop();
        Test.stopTest();

        Object expected = 'Test';
        
        System.assertEquals(expected, actual, 'Stack must pop out the top element');
    }
}