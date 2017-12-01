@isTest class StudentsTests {
    static final Integer noOfClasses = 2;
    static final Integer noOfStudents = 5;
    static final Integer TEST_MAX_SIZE = noOfStudents-1;
    static final String TEST_NAME = 'Test';
    static final String TEST_EXPECTED = 'Cannot add student to class. Max size reached.';
    
    static List<Class__c> getClasses(){
        return [
            SELECT Id, MyCount__c
            FROM Class__c
            WHERE Name LIKE :TEST_NAME+'%'
        ];
    }
    
    static List<Student__c> getStudents(){
        List<Student__c> listOfStudents = new List<Student__c>();
        for(Integer index = 0; index < noOfStudents; index++){
            Student__c student = new Student__c(
                First_Name__c = TEST_NAME+index,
                Last_Name__c = TEST_NAME+index,
                Class__c = getClasses()[0].Id
            );
            listOfStudents.add(student);
        }
        
        return listOfStudents;
    }
    
    @testSetup static void setup(){
        List<Class__c> listOfClasses = new List<Class__c>();
        for(Integer index = 0; index < noOfClasses; index++){
            Class__c cls = new Class__c(
                Name = TEST_NAME+index,
            	Max_Size__c = TEST_MAX_SIZE);
            listOfClasses.add(cls);
        }
        insert listOfClasses;
    }
    
    @isTest static void testCheckClassSizeShouldRestrictStudentEntryWhenClassMaxSizeReached(){
        List<Student__c> listOfStudents = getStudents();
        
        try{
	    	Test.startTest();
    	        insert listOfStudents;
        	Test.stopTest();
        }catch(Exception error){
            Boolean expected = error.getMessage().contains(TEST_EXPECTED);
            System.assert(expected, 'Should Restrict Student Entry When Class Max Size Reached');
        }
    }
    
    @isTest static void testUpdateClassCountShouldUpdateClassCountOfStudents(){
        List<Student__c> listOfStudents = getStudents();
        
	    Test.startTest();
    	    insert listOfStudents[0];
        Test.stopTest();
        
        Integer expected = 1;
        Integer actual = (Integer)getClasses()[0].MyCount__c;
        
        System.assertEquals(expected, actual, 'Should Update Class Count Of Students');
    }
}