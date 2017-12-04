@isTest class LoansTests {
    static final Integer noOfManagers = 2;
    static final Integer noOfLoans = 4;
    static final Decimal TEST_AMOUNT = 200;
    static final String TEST_NAME = 'Test';
    static final String TEST_CITY = 'jaipur';
    static final String TEST_EMAIL= 'abc@abc.com';
    static final String TEST_STATUS = 'Pending';
    static final String TEST_STATUS_REJECTED = 'Rejected';
    
    static List<Loan__c> getLoans(){
 	    List<Loan__c> listOfLoans = new List<Loan__c>();
        for(Integer index = 0; index< noOfLoans; index++){
            Loan__c loan = new Loan__c(
                Name__c = TEST_NAME+index,
                Manager__c = getCityManagers()[0].Id,
                City__c = TEST_CITY,
                Applicant_Name__c = TEST_NAME,
                Applicant_Email__c= TEST_EMAIL,
                Amount__c = TEST_AMOUNT,
                Status__c = TEST_STATUS);
            listOfLoans.add(loan);
        }
        return listOfLoans;
    }
    static List<CityManager__c> getCityManagers(){
        return [
            SELECT Id, City__c
            FROM CityManager__c
        ];
    }
    static list<Loan__c> getLoanDetails(){
        return [
            SELECT Id, Manager__r.Name, Status__c
            FROM Loan__c
        ];
    }
    
    @testSetup static void setup(){
        List<CityManager__c> listofCityManagers = new List<CityManager__c>();
        for(Integer index = 0; index < noOfManagers; index++){
            CityManager__c manager = new CityManager__c(
                Name = TEST_NAME+index,
                City__c = TEST_CITY);
            listOfCityManagers.add(manager);
        }
	    insert listOfCityManagers;  
    }
    
    @isTest static void testOnApplyDefaultsShouldSetDefaultLoanManagerFromSameCity(){
        List<Loan__c> listofLoans = getLoans();

        Test.startTest();
            insert listOfLoans;
        Test.stopTest();
        
        String expected = TEST_NAME+1;
        String actual = getLoanDetails()[0].Manager__r.Name;
        
        System.assertEquals(expected, actual, 'Should Set Default Loan Manager From Same City');
    }
    
    @isTest static void testOnBeforeUpdateShouldNotifyApplicantOfLoanStatus(){
        List<Loan__c> listOfLoans = getLoans();
        insert listOfLoans;
        listOfLoans[0].Status__c = TEST_STATUS_REJECTED;

        Test.startTest();
            update listOfLoans;
        Test.stopTest();
        
        String expected = TEST_STATUS_REJECTED;
        String actual = getLoanDetails()[0].Status__c;
        
        System.assertEquals(expected, actual, 'Should Notify Applicant Of Loan Status on status update');
    }
}