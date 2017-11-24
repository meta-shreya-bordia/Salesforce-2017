@isTest class DateUtilTests {
    static Date date1 = System.today();
    static Date date2 = System.today() - 10;
    static final String ERROR_MSG = 'Number of working days are different.';
    
    @isTest
    static void testWorkingDaysShouldReturnDifferenceInWorkingDaysOfDates(){
        Test.startTest();
        	Integer actual = DateUtil.getWeekdayDifference(date1, date2);
		Test.stopTest();
        
        Integer expected = 8;
        
        System.assertEquals(expected, actual, ERROR_MSG);
    }
    
    @isTest static void testWorkingDaysShouldReturnDifferenceWhenOneDateIsNull(){
        date2 = null;
        
        Test.startTest();
        	Integer actual = DateUtil.getWeekdayDifference(date1, date2);
		Test.stopTest();
        
        Integer expected = 0;
        
        System.assertEquals(expected, actual, ERROR_MSG);
    }
    
    @isTest static void testWorkingDaysShouldReturnDifferenceWhenSecondDateIsSmaller(){
        Test.startTest();
        	Integer actual = DateUtil.getWeekdayDifference(date2, date1);
		Test.stopTest();
        
        Integer expected = 8;
        
        System.assertEquals(expected, actual, ERROR_MSG);
    }
}