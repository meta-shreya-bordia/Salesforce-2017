@isTest class ContactsTests {
    static final Integer noOfTeachers = 2;
    static final Integer noOfClasses = 1;
    static final Integer noOfStudents = 5;
    static final String TEST_NAME = 'Test';
    static final String UPDATED_NAME = 'Hindi Teacher';
    static final String TEST_SUBJECTS = 'Hindi;Maths';
    static final String ACCESS_DENIED = 'Hindi Teachers are not allowed to be added/modified';

    static List<Contact> getTeachers(){
        return [
            SELECT Id
            FROM Contact
        ];
    }
    
	@testSetup static void setup(){
        List<Contact> listOfTeachers = new List<Contact>();
        for(Integer index = 0; index < noOfTeachers; index++){
        	Contact classTeacher = new Contact(
                FirstName = TEST_NAME + index,
                LastName = TEST_NAME + index,
                Subjects__c = TEST_SUBJECTS);
        
            listOfTeachers.add(classTeacher);
        }
        insert listOfTeachers;
    }    
    
    @isTest static void testDenyAccessShouldBlockHindiTeachersFromBeingUpdated(){
        List<Contact> listOfTeachers = getTeachers();
        
        try{
	        listOfTeachers[0].LastName = UPDATED_NAME;
    	    update listOfTeachers[0];
        }catch(Exception error){
            Boolean expected = error.getMessage().contains(ACCESS_DENIED);       
            System.assert(expected, 'Hindi teachers must not be updatable');
        }
    }
}