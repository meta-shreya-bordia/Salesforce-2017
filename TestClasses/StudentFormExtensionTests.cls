@isTest class StudentFormExtensionTests {
    static String TEST_NAME = 'Student';
    static String ATTACHMENT_NAME = '-StudentDetails.pdf';
    static final String CONTENT_TYPE = 'application/json';
    static final Blob TEST_BODY = Blob.valueOf( 'Attachment Body' );
    
    static final String ERROR_MSG = 'Controller does not attach expected attachment';
    
    static Student__c getStudent(){
        return [
            SELECT Id,First_Name__c,
            	Last_Name__c,Class__r.Name,
            	(SELECT Id,Name
                FROM Attachments)
            FROM Student__c
            WHERE Last_Name__c = :TEST_NAME
        ];
    }
		    
    static StudentFormExtension getClassController(){
        return new StudentFormExtension(
            new ApexPages.StandardController( getStudent() ));
    }
    
    @testSetup static void setup(){
        Class__c cls = new Class__c(Name = TEST_NAME);
        insert cls;
        
        Student__c student = new Student__c(
        	First_Name__c = TEST_NAME,
            Last_Name__c = TEST_NAME,
            Class__c = cls.Id
        );
        insert student;
        
        Attachment attachment = new Attachment(
			Name = student.Id + ATTACHMENT_NAME,
            Body = TEST_BODY,
            ContentType = CONTENT_TYPE,
            ParentId = student.Id
        );
        insert attachment;
    }
    
    @isTest static void testAttachShouldAttachNewAttachmentToStudentRecord(){
        StudentFormExtension formExtension = getClassController();
        
        Test.startTest();
        	formExtension.attach();
        Test.stopTest();
        
        Id expected = getStudent().Attachments[0].Id;
        Id actual = formExtension.student.Attachments[0].Id;
        
        System.assertNotEquals(expected, actual, ERROR_MSG);
    }
    
    @isTest static void testAttachShouldRedirectToStudentDetailsPage(){
        StudentFormExtension formExtension = getClassController();
        
        Test.startTest();
        	PageReference actual = formExtension.attach();
        Test.stopTest();
        
        PageReference expected = new PageReference('/'+ getStudent().Id);
        
        System.assertEquals(expected, actual, ERROR_MSG);
    }
}