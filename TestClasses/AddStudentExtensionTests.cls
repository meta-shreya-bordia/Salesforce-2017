@isTest class AddStudentExtensionTests {
    static final Integer noOfClasses = 2;
    static final Integer noOfStudents = 5;
	
    static final String TEST_NAME = 'Test';
    static final String TEST_EXPECTED = 'Cannot add student to class. Max size reached.';
    static final String ERROR_MSG = 'Trigger operation does execute as expected';
    
    static AddStudentExtension getClassObject(){
        ApexPages.currentPage().getParameters().put('id', getClasses()[0].Id);
        AddStudentExtension controller = 
            new AddStudentExtension( new ApexPages.StandardController(getClasses()[0]));
        controller.student = getStudents()[0];
        
        return controller;
    }
    
    static List<Class__c> getClasses(){
        return [
            SELECT Id, MyCount__c
            FROM Class__c
            WHERE Name LIKE :TEST_NAME+'%'
        ];
    }
    
    static List<Student__c> getStudents(){
        List<Student__c> listOfStudents = new List<Student__c>();
        for(Integer index=0; index < noOfStudents; index++){
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
        for(Integer index=0; index< noOfClasses; index++){
            Class__c cls = new Class__c(Name = TEST_NAME+index);
            listOfClasses.add(cls);
        }
        insert listOfClasses;
        
        
    }
    
    @isTest static void testAddStudentShouldAddNewStudentToClass(){
        AddStudentExtension controller = getClassObject();
        
        Test.startTest();
        	PageReference redirect = controller.addStudent();
        Test.stopTest();
        
        String expected = TEST_NAME+'0';
        String actual = controller.student.First_Name__c;
        
        System.assertEquals(expected, actual, ERROR_MSG);
    }
}