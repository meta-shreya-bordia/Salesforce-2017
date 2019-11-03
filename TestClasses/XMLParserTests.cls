@isTest class XMLParserTests {
    static final String TEST_EXPECTED = 'Error Parsing Document';
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
        
    @isTest static void testXMLParserShouldParseContactsAndInsertContacts(){
        Test.startTest();
            XMLParser parsedResults = new XMLParser(ATTACHMENT_BODY);
		Test.stopTest();
        
        Integer expected = 2;
        Integer actual = parsedResults.listOfContactsToInsert.size();

        System.assertEquals(expected, actual, 'Should parse 2 contacts');
    }
    
    @isTest static void testXMLParserShouldThrowErrorWhenStringIsNotContact(){
        try{
            Test.startTest();
                XMLParser parsedResults = new XMLParser(null);
            Test.stopTest();
        }catch(Exception error){
            Boolean expected = error.getMessage().contains(TEST_EXPECTED);
            System.assert(expected, 'Should Throw Error When String Is Not A Contact');
        }
    }
}