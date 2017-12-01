@isTest class AttachmentDAOTests {
    static final Integer noOfClasses = 2;
	static final Integer noOfStudents = 3;
    static final Integer noOfAttachments = 3;
    static final String CONTENT_TYPE = 'application/json';
    static final String TEST_NAME = 'Test';
    static final Blob TEST_BODY = Blob.valueOf( 'Attachment Body' );
    
    static List<Student__c> getStudents(){
        return [
            SELECT Id
            FROM Student__c
            WHERE First_Name__c LIKE :TEST_NAME +'%'
        ];
    }
    
    @testSetup static void setup(){
        List<Class__c> listOfClasses = new List<Class__c>();
        for(Integer index = 0; index < noOfClasses; index++){
            Class__c cls = new Class__c(Name = TEST_NAME +index);
            listOfClasses.add(cls);
        }
        
        insert listOfClasses;
        
        List<Student__c> listOfStudents = new List<Student__c>();
        for(Integer index = 0; index < noOfStudents; index++){
            Student__c student = new Student__c(
                First_Name__c = TEST_NAME+index,
                Last_Name__c = TEST_NAME+index,
                Class__c = listOfClasses[0].Id);
            listOfStudents.add(student);
        }
        
        insert listOfStudents;
        
        List<Attachment> listOfAttachments = new List<Attachment>();
        for(Integer index = 0; index < noOfAttachments; index++){
            Attachment attachment = new Attachment(
			    Name = TEST_NAME + index,
                Body = TEST_BODY,
                ContentType = CONTENT_TYPE,
                ParentId = listOfStudents[0].Id);
            listOfAttachments.add(attachment);
        }
        
        insert listOfAttachments;
    }
    
    @isTest static void testGetAttachmentsByParentIdShouldReturnListOfAttacmentsByAnId(){
        List<Student__c> listOfStudents = getStudents();
        
        Test.startTest();
            List<Attachment> listOfAttachments = AttachmentDAO.getAttachmentsByParentId(listOfStudents[0].Id);
        Test.stopTest();
        
        Integer expected = noOfAttachments;
        Integer actual = listOfAttachments.size();
        
        System.assertEquals( expected, actual, 'Attachment dao should return student attachments');
    }
}