@isTest class DateUtilTests {
    static Date date1 = System.today();
    static Date date2 = System.today() - 10;
    
    @isTest static void testWorkingDaysShouldReturnDifferenceInWorkingDaysOfDates(){
        Test.startTest();
            Integer actual = DateUtil.getWeekdayDifference(date1, date2);
		Test.stopTest();
        
        Integer expected = 8;
        System.assertEquals(expected, actual, 'Number of working days must be '+expected);
    }
    
    @isTest static void testWorkingDaysShouldReturnDifferenceWhenOneDateIsNull(){
        date2 = null;
        
        Test.startTest();
            Integer actual = DateUtil.getWeekdayDifference(date1, date2);
		Test.stopTest();
        
        Integer expected = 0;
        System.assertEquals(expected, actual, 'Number of working days must be '+expected);
    }
    
    @isTest static void testWorkingDaysShouldReturnDifferenceWhenSecondDateIsSmaller(){
        Test.startTest();
            Integer actual = DateUtil.getWeekdayDifference(date2, date1);
		Test.stopTest();
        
        Integer expected = 8;
        System.assertEquals(expected, actual, 'Number of working days must be '+expected);
    }
}