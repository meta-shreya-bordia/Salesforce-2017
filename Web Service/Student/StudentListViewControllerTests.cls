@isTest class StudentListViewControllerTests {
    static final Integer noOfClasses = 2;
    static final Integer noOfStudents = 5;
    static final String TEST_NAME = 'Test';
    static final String TEST_SEX = 'Female';
    static final Date TEST_DATE = System.today();
    
    static StudentListViewController getClassObject(){
        StudentListViewController controller = new StudentListViewController();
        controller.selectedStudentId = getStudents()[0].Id;
        
        return controller;
    }
    
    static List<Student__c> getStudents(){
        return [
            SELECT Id
            FROM Student__c
            WHERE First_Name__c LIKE :TEST_NAME+'%'
        ];
    }
   
    @testSetup static void setup(){
        List<Class__c> listOfClasses = new List<Class__c>();
        for(Integer index = 0; index < noOfClasses; index++){
            Class__c cls = new Class__c(Name = TEST_NAME+index);
            listOfClasses.add(cls);
        }
        insert listOfClasses;
        
        List<Student__c> listOfStudents = new List<Student__c>();
        for(Integer index=0; index < noOfStudents; index++){
            Student__c student = new Student__c(
                First_Name__c = TEST_NAME+index,
                Last_Name__c = TEST_NAME+index,
                DOB__c = TEST_DATE,
                Sex__c = TEST_SEX,
                Class__c = listOfClasses[0].Id
            );
            listOfStudents.add(student);
        }
        insert listOfStudents;
    }
    
    @isTest static void testSetSelectedStudentShouldSetSelectedStudentDetailsVisible(){
        StudentListViewController controller = getClassObject();
        
        Test.startTest();
            controller.setSelectedStudent();    
        Test.stopTest();
        
        String expected = TEST_NAME+0;
        String actual = controller.selectedStudent.Last_Name__c;
        
        System.assertEquals(expected, actual, 'Should render details of selected student');
    }
    
    @isTest static void testGetStudentsShouldGetAllStudentDetails(){
        StudentListViewController controller = getClassObject();
        
        Test.startTest();
            List<Student__c> listOfStudents = controller.getStudents();    
        Test.stopTest();
        
        Integer expected = noOfStudents;
        Integer actual = listOfStudents.size();
        
        System.assertEquals(expected, actual, 'Should render student list of '+noOfStudents+' records');
    }
}