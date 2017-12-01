@isTest class ClassesTests {
    static final Integer noOfClasses = 2;
    static final Integer noOfStudents = 5;
    static final String TEST_NAME = 'X';
    static final String TEST_GENDER = 'Female';
    static final String ACCESS_DENIED_TO_DELETE = 'Cannot delete class with female students';

    static List<Class__c> getClasses(){
        return [
            SELECT Id
            FROM Class__c
        ];
    }
    
    @testSetUp static void setup(){
        List<Class__c> listOfClasses = new List<Class__c>();
        for(Integer index = 0; index< noOfClasses; index++){
            Class__c cls = new Class__c(
                Name = TEST_NAME + index,
                Max_Size__c = noOfStudents);
            
            listOfClasses.add(cls);
        }
        insert listOfClasses;

        List<Student__c> listOfStudents = new List<Student__c>();
        for(Integer index = 0; index < noOfStudents; index++){
            Student__c student = new Student__c(
                First_Name__c = TEST_NAME + index,
                Last_Name__c = TEST_NAME + index,
                Sex__c = TEST_GENDER,
                Class__c = listOfClasses[0].Id);
            
            listOfStudents.add(student);
        }
        insert listOfStudents;
    }

    @isTest static void testCheckForFemaleStudentShouldBlockClassWithFemaleStudentsFromBeingDeleted(){
        List<Class__c> listOfClasses = getClasses();
        
        try{
            Test.startTest();
		        delete listOfClasses;
            Test.stopTest();
        }catch(Exception error){
            Boolean expected = error.getMessage().contains(ACCESS_DENIED_TO_DELETE);
            System.assert(expected, 'Class containing female students cannot be deleted');
        }
    }    
}