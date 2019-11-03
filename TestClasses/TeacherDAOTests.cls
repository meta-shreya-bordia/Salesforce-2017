@isTest class TeacherDAOTests {
    static final Integer noOfClasses = 2;
    static final Integer noOfTeachers = 3;
    static final String TEST_NAME = 'Test';
    static final String TEST_SUBJECTS = 'English;Hindi';
    
    static Map<Id, Class__c> getClasses(){
        return new Map<Id, Class__c> ([
            SELECT Id
            FROM Class__c
            WHERE Name LIKE :TEST_NAME+'%'
        ]);
    }
    
    static List<Contact> getTeachers(){
        return [
            SELECT Id
            FROM Contact
            WHERE LastName LIKE :TEST_NAME+'%'
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
        
        List<Class__c> listOfClasses = new List<Class__c>();
        for(Integer index = 0; index < noOfClasses; index++){
            Class__c cls = new Class__c(
                Name = TEST_NAME+index,
                Contact__c = listOfTeachers[0].Id);
            
            listOfClasses.add(cls);
        }
        insert listOfClasses;
    }
    
    @isTest static void testGetTeacherBySubjectsShouldReturnTeacherTeachingRequestedSubject(){
        Test.startTest();
            List<Contact> listOfTeachers = TeacherDAO.getTeacherBySubjects(TEST_SUBJECTS);
        Test.stopTest();
        
        Integer expected = noOfTeachers;
        Integer actual = listOfTeachers.size();
        
        System.assertEquals(expected, actual, 'Should Return Teacher Teaching '+TEST_SUBJECTS+' Subjects');
    }
    
    @isTest static void testGetTeacherDetailsShouldReturnListOfSubjectsTaughtByTeacher(){
        List<Contact> listOfTestTeachers = getTeachers();
        
        Test.startTest();
            List<Contact> listOfTeachers = TeacherDAO.getTeacherDetails(listOfTestTeachers);
        Test.stopTest();
        
        String expected = TEST_SUBJECTS;
        String actual = listOfTeachers[0].Subjects__c;
        
        System.assertEquals(expected, actual, 'Should Return List Of All Subjects Taught By Teacher');
    }
}