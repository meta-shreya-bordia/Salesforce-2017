@isTest class DeleteStudentsExtensionTests {
	static final Integer noOfClasses = 3;
    static final Integer noOfStudents = 2;
    
    static final String TEST_NAME = 'Test';
    static final String TEST_WARNING = 'No records selected';
    static final String ERROR_MSG = 'Student does not contain required records';
    
    static List<Student__c> getStudents(){
        return [
            SELECT Id
            FROM Student__c
        ];
    }
    
    static DeleteStudentsExtension getClassObject(){
        DeleteStudentsExtension controller;
        if(controller == null){
        	controller = new DeleteStudentsExtension(
                new ApexPages.StandardSetController(getstudents()));
            controller.listOfSelectedStudents = getStudents();
        }
        return controller;
    }
    
    @testSetup static void setup(){
   		List<Class__c> listOfClasses = new List<Class__c>();
        for(Integer index=0; index< noOfClasses; index++){
            Class__c cls = new Class__c(Name = TEST_NAME+index);
            listOfClasses.add(cls);
        }
        insert listOfClasses;
        
        List<Student__c> listOfStudents = new List<Student__c>();
        for(Integer index=0; index < noOfStudents; index++){
            Student__c student = new Student__c(
                First_Name__c = TEST_NAME+index,
                Last_Name__c = TEST_NAME+index,
                Class__c = listOfClasses[0].Id
            );
            listOfStudents.add(student);
        }
        insert listOfStudents;
    }
    
    @isTest
    static void testGetSelectedStudentsReturnsSelectedStudentList(){
        DeleteStudentsExtension controller = getClassObject();
        
        Test.startTest();
        	List<Student__c> listOfStudents = controller.getSelectedStudents();
        Test.stopTest();
        
        Integer expected = noOfStudents;
        Integer actual = listOfStudents.size();
        
        System.assertEquals(expected, actual, ERROR_MSG);
    }
    
    @isTest static void testContinueDeletionShouldDeleteSelectedStudents(){
        DeleteStudentsExtension controller = getClassObject();
        
        Test.startTest();
        	PageReference redirect = controller.continueDeletion();
        Test.stopTest();
        
        Integer expected = 0;
        Integer actual = controller.getSelectedStudents().size();
        
        System.assertEquals(expected, actual, ERROR_MSG);
    }
    
    @isTest static void testGetSelectedStudentsShouldIssueWarningThatNoStudentWasSelected(){
        DeleteStudentsExtension controller = getClassObject();
        controller.listOfSelectedStudents = null;
        
	    Test.startTest();
    		List<Student__c> listOfStudents = controller.getSelectedStudents();
        Test.stopTest();
        
        List<ApexPages.Message> listOfApexMessages = ApexPages.getMessages();
        String expected = TEST_WARNING;
        String actual = listOfApexMessages[0].getSummary(); 
            
        System.assertEquals(expected, actual, ERROR_MSG);    
    }
}