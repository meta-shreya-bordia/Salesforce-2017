@isTest class TeacherDAOTests {
	static final Integer noOfTeachers = 3;
    
    static final String TEST_NAME = 'Teacher';
    static final String TEST_SUBJECTS = 'Hindi;English';
    static final String ERROR_MSG = 'Query does not return requested teachers';
    
    static List<Contact> getTeachers(){
        return [
            SELECT Id
            FROM Contact
        ];
    }
    
    @testSetup
    static void setup(){
        
    }
    
    @isTest static void testGetTeacherBySubjectsShouldReturnTeacherTeachingRequestedSubject(){
        Test.startTest();
        	List<Contact> listOfTeachers = TeacherDAO.getTeacherBySubjects(TEST_SUBJECTS);
        Test.stopTest();
        
        Integer expected = noOfTeachers;
        Integer actual = listOfTeachers.size();
        
        System.assertEquals(expected, actual, ERROR_MSG);
    }
    
    @isTest static void testGetTeacherDetailsShouldReturnListOfSubjectsTaughtByTeahcer(){
        List<Contact> listOfTestTeachers = getTeachers();
        
        Test.startTest();
        	List<Contact> listOfTeachers = TeacherDAO.getTeacherDetails(listOfTestTeachers);
        Test.stopTest();
        
        String expected = TEST_SUBJECTS;
        String actual = listOfTeachers[0].Subjects__c;
        
        System.assertEquals(expected, actual, ERROR_MSG);
    }
}