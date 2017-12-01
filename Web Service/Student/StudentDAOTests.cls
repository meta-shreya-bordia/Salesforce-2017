@isTest class StudentDAOTests {
    static final Integer noOfClasses = 2;
    static final Integer noOfStudents = 5;
    static final Integer noOfTeachers = 3;
    static final Integer noOfTeaches = 3;
    static final Date TEST_DATE = Date.newInstance(1999, 2, 2);
    static final String TEST_NAME = 'Test';
    static final String TEST_SUBJECT = 'Hindi';
    
    static List<Class__c> getClasses(){
        return [
            SELECT Id
            FROM Class__c
            WHERE Name LIKE :TEST_NAME+'%'
        ];
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
                Class__c = listOfClasses[0].Id
            );
            listOfStudents.add(student);
        }
        insert listOfStudents;
        
        List<Contact> listOfTeachers = new List<Contact>();
        for(Integer index = 0; index < noOfTeachers; index++){
            Contact classTeacher = new Contact(
                FirstName = TEST_NAME + index,
                LastName = TEST_NAME + index,
                Subjects__c = TEST_SUBJECT);
            
            listOfTeachers.add(classTeacher);
        }
        insert listOfTeachers;
        
        List<Teach__c> listOfTeaches = new List<Teach__c>();
        for(Integer index = 0; index < noOfTeaches; index++){
            Teach__c classSubject = new Teach__c(
                Subject__c = TEST_SUBJECT,
                Teacher__c = listOfTeachers[0].Id,
                Class__c = listOfClasses[index].Id);
            
            listOfTeaches.add(classSubject);
        }
        insert listOfTeaches;
    }
    
    @isTest static void testGetStudentDetailsShouldReturnStudentsBySearchField(){
        Test.startTest();
            List<Student__c> listOfStudents = StudentDAO.getStudentDetails(TEST_NAME);
        Test.stopTest();
        
        Integer expected = noOfStudents;
        Integer actual = listOfStudents.size();
        
        System.assertEquals(expected, actual, 'Should Return List Of Student By Search Field');
    }
    
    @isTest static void testGetStudentByClassShouldReturnStudentsByClassSearchField(){
        Test.startTest();
            List<Student__c> listOfStudents = StudentDAO.getStudentByClass(TEST_NAME);
        Test.stopTest();
        
        Integer expected = noOfStudents;
        Integer actual = listOfStudents.size();
        
        System.assertEquals(expected, actual, 'Should Return Students By Class Search Field');
    }
    
    @isTest static void testGetStudentByClassShouldReturnStudentsFromClasses(){
        List<Student__c> listOfTestStudents = getStudents();
        
        Test.startTest();
            List<Student__c> listOfStudents = StudentDAO.getStudentByClass(listOfTestStudents);
        Test.stopTest();
        
        Integer expected = noOfStudents;
        Integer actual = listOfStudents.size();
        
        System.assertEquals(expected, actual, 'Should Return Students by their Classes');
    }

    @isTest static void testGetStudentByClassIdShouldReturnStudentsInAClassById(){
        List<Class__c> listOfClasses = getClasses();

        Test.startTest();
            List<Student__c> listOfStudents = StudentDAO.getStudentByClassId(listOfClasses[0].Id);
        Test.stopTest();
        
        Integer expected = noOfStudents;
        Integer actual = listOfStudents.size();
        
        System.assertEquals(expected, actual, 'Should return students from a class' );
    }
    
    @isTest static void testGetByDOBShouldReturnStudentsBySearchedYear(){
        Test.startTest();
            List<Student__c> listOfStudents = StudentDAO.getByDOB( TEST_DATE.year() );
        Test.stopTest();
        
        Integer expected = noOfStudents;
        Integer actual = listOfStudents.size();
        
        System.assertEquals(expected, actual, 'Should return students by their birth year' );
    }
    
    @isTest static void testGetStudentsBySubjectShouldReturnStudentsStudyingSubjects(){
        List<Class__c> listOfClasses = getClasses();

        Test.startTest();
            List<Student__c> listOfStudents = StudentDAO.getStudentsBySubject();
        Test.stopTest();
        
        Integer expected = noOfStudents;
        Integer actual = listOfStudents.size();
        
        System.assertEquals(expected, actual, 'Should return students by subjects taught to them' );
    }	
}
