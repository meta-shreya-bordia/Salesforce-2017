@isTest class ClassDAOTests {
    static final Integer noOfClasses = 2;
    static final Integer noOfStudents = 5;
    static final Integer noOfTeachers = 3;
    static final Date TEST_DATE = System.today();
    static final String TEST_NAME = 'Test';
    static final String TEST_SEX = 'Female';
    static final String TEST_SUBJECT = 'Hindi';
    
    static Map<Id, Class__c> getClasses(){
        return new Map<Id, Class__c> ([
            SELECT Id
            FROM Class__c
            WHERE Name LIKE :TEST_NAME+'%'
        ]);
    }
    static List<Student__c> getStudents(){
        return [
            SELECT Id
            FROM Student__c
            WHERE First_Name__c LIKE :TEST_NAME+'%'
        ];
    }
    
    @testSetup static void setup(){
        List<Contact> listOfTeachers = new List<Contact>();
        for(Integer index = 0; index < noOfTeachers; index++){
            Contact classTeacher = new Contact(
                FirstName = TEST_NAME + index,
                LastName = TEST_NAME + index,
                Subjects__c = TEST_SUBJECT);
            
            listOfTeachers.add(classTeacher);
        }
        insert listOfTeachers;
        
        List<Class__c> listOfClasses = new List<Class__c>();
        for(Integer index = 0; index< noOfClasses; index++){
            Class__c cls = new Class__c(
                Name = TEST_NAME+index,
                Contact__c = listOfTeachers[0].Id);
            
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
                Class__c = listOfClasses[0].Id);

            listOfStudents.add(student);
        }
        insert listOfStudents;
        
        List<Teach__c> listOfTeaches = new List<Teach__c>();
        for(Integer index = 0; index < noOfClasses; index++){
            Teach__c classSubject = new Teach__c(
                Subject__c = TEST_SUBJECT,
                Teacher__c = listOfTeachers[0].Id,
                Class__c = listOfClasses[index].Id);
            
            listOfTeaches.add(classSubject);
        }
        insert listOfTeaches;
    }
    
    @isTest static void testGetRelatedStudentsShouldReturnAClassStudentsSearchedByStudentSearchPattern(){
        Test.startTest();
            List<Class__c> listOfClasses = ClassDAO.getRelatedStudents(TEST_NAME);
        Test.stopTest();
        
        Integer expected = noOfStudents;
        Integer actual = listOfClasses[0].Student__r.size();
        
        System.assertEquals(expected, actual, 
            'Should Return A Class Students\' Searched By Student Search Pattern');
    }
    
    @isTest static void testGetRelatedStudentsShouldReturnMapOfClassesWithTheirStudents(){
        Test.startTest();
            Map<Class__c, Set<Id>> mapOfClassStudents = ClassDAO.getRelatedStudents();
        Test.stopTest();
        
        Integer expected = noOfStudents;
        Integer actual = mapOfClassStudents.values()[0].size();
        
        System.assertEquals(expected, actual, 
            'Class DAO must return set of all student ids in a class');
    }
    
    @isTest static void testGetClassDetailsShouldReturnMapOfClassStudents(){
        Test.startTest();
       		Map<Id, Class__c> mapOfClassStudents = ClassDAO.getClassDetails();
        Test.stopTest();
        
        Integer expected = noOfClasses;
        Integer actual = mapOfClassStudents.size();
        
        System.assertEquals(expected, actual, 
            'Class DAO must return details of each class with their students');
    }
    
    @isTest static void testGetByClassTeacherReturnsClassesByClassTeacher(){
        Test.startTest();
        	List<Class__c> listOfClasses = ClassDAO.getByClassTeacher(TEST_NAME);
        Test.stopTest();
        
        Integer expected = noOfClasses;
        Integer actual = listOfClasses.size();
        
        System.assertEquals(expected, actual, 
            'Class DAO must return class with its class teacher name starting as '+TEST_NAME);
    }
    
    @isTest static void testGetClassBySubjectShouldReturnClassesListedByTaughtSubjects(){
        Test.startTest();
            List<Id> listOfClassIds = ClassDAO.getClassBySubject();
        Test.stopTest();
        
        Integer expected = noOfClasses;
        Integer actual = listOfClassIds.size();
        
        System.assertEquals(expected, actual, 
            'Class DAO must return all subjects taught in a class');
    }
    
    @isTest static void testGetClassDetailsShouldReturnAllClassDetails(){
        List<Id> listOfClassIds = new List<Id>( getClasses().keySet() ); 
        
        Test.startTest();
            List<Class__c> listOfClasses = ClassDAO.getClassDetails(listOfClassIds);
        Test.stopTest();
        
        Integer expected = noOfClasses;
        Integer actual = listOfClasses.size();
        
        System.assertEquals(expected, actual,
            'Class DAO must return list of all class details from their ids');
    }
    
    @isTest static void testGetFemaleStudentsShouldReturnClassesThatContainFemaleStudents(){
        List<Class__c> listOfTestClasses = getClasses().values(); 
        
        Test.startTest();
        	List<Class__c> listOfClasses = ClassDAO.getFemaleStudents(listOfTestClasses);
        Test.stopTest();
        
        Integer expected = noOfStudents;
        Integer actual = listOfClasses[0].Student__r.size();
        
        System.assertEquals(expected, actual,
            'Class DAO does not return all classes that have female students');
    }
}