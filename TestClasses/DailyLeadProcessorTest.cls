@isTest
private class DailyLeadProcessorTest {
    public static String CRON_EXP = '0 0 0 15 3 ? 2022';
 
	@testSetup
    public static void setup(){
    	List<Lead> listofLeads = new List<Lead>();
        
        for(Integer index =0; index<200; index++){
            listOfLeads.add(
            	new Lead(LastName = 'Test Lead ' +index,
                        Company = 'Test Company '+index )
            );
        }
        
        listOfLeads.add(
        	new Lead(LastName = 'With LeadSource',
					Company	= 'Agriculture',
                    LeadSource = 'Web Service')
        );
        
        insert listOfLeads;
    }
    
    @isTest
    public static void test1(){
        Test.startTest();
        // Schedule the test job
        String jobId = System.schedule('ScheduledApexTest',
            CRON_EXP, 
            new DailyLeadProcessor());  
        
        System.assertEquals(200, [
            SELECT count()
            FROM Lead
            WHERE LeadSource = 'Dreamforce'
            AND LastName = 'Test Lead %'
        ]);
        
        System.assertEquals(1, [
            SELECT count()
            FROM Lead
            WHERE LeadSource = 'Web Service'
            AND LastName = 'With LeadSource'
        ]);
        
        Test.stopTest();
    }
}