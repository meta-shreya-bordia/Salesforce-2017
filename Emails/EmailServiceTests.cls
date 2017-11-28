@isTest class EmailServiceTests {
    static final String TEST_SUBJECT = 'Subject';
    static final String TEST_BODY = 'Email Body';
    static final String TEST_ADDRESS = 'shreya.bordia@metacube.com';
    static final String ERROR_MSG = 'Email Service did not deliver the mail';
    
    static final String TEST_FILENAME = 'contact.xml';
    static final String ATTACHMENT_BODY = 
        '<contacts>'
            +'<contact>'
                +'<FirstName>Severus</FirstName>'
                +'<LastName>Snape</LastName>'
                +'<Subjects__c>Hindi</Subjects__c>'
                +'<Department>Dark Arts</Department>'
                +'<Email>Severus@Snape.com</Email>'
            +'</contact>'
            +'<contact>'
                +'<FirstName>Sirius</FirstName>'
                +'<LastName>Black</LastName>'
                +'<Subjects__c>English;Maths</Subjects__c>'
                +'<Department>Askaban</Department>'
                +'<Email>Sirius@Black.com</Email>'
            +'</contact>'
		+'</contacts>';
    
	static Messaging.InboundEmail getEmail(){
        Messaging.InboundEmail email = new Messaging.InboundEmail() ;
   		
        email.Subject = TEST_SUBJECT;
        email.fromAddress = TEST_ADDRESS;
        
        Messaging.InboundEmail.TextAttachment attachmenttext = 
            new Messaging.InboundEmail.TextAttachment();
		attachmenttext.body = ATTACHMENT_BODY;
  		attachmenttext.fileName = TEST_FILENAME;
        
  		email.textAttachments = new Messaging.inboundEmail.TextAttachment[] { attachmenttext };            
        return email;    
    }
    static Messaging.InboundEnvelope getEnvelope(){
        return new Messaging.InboundEnvelope();
    }
    
    @isTest static void testHandleInboundEmailShouldHandleEmailAttachments(){
        EmailService service = new EmailService();
        Messaging.InboundEmail email = getEmail();
        Messaging.InboundEnvelope envelope = getEnvelope();
        
        Test.startTest();
	        Messaging.InboundEmailResult result = service.handleInboundEmail(email, envelope);
        Test.stopTest();
        
        Boolean expected = true;
        Boolean actual = result.success;
        
        System.assertEquals(expected, actual, ERROR_MSG);
    }
    
    @isTest static void testSendEmailShouldDeliverAnEmailToAddress(){
        Test.startTest();
	    	EmailService.sendMail( TEST_ADDRESS, TEST_SUBJECT, TEST_BODY );    
        Test.stopTest();
    }
}