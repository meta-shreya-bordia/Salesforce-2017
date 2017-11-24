@isTest class LoanDAOTests {
	static final Integer noOfManagers = 2;
    static final Integer noOfLoans = 4;
    
    static final Decimal TEST_AMOUNT = 200;

    static final String TEST_NAME = 'Test';
    static final String TEST_CITY = 'jaipur';
    static final String TEST_EMAIL= 'abc@abc.com';
    static final String TEST_STATUS = 'Approved';
    
    static final String ERROR_MSG = 'Expected records were not found';
    
    static List<Loan__c> getLoans(){
        return [
            SELECT Id
            FROM Loan__c
            WHERE Amount__c = :TEST_AMOUNT
        ];
    }
    
    @testSetup static void setup(){
        List<CityManager__c> listofCityManagers =
            new List<CityManager__c>();
        for(Integer index = 0; index < noOfManagers; index++){
            CityManager__c manager = new CityManager__c(
            	Name = TEST_NAME,
                City__c = TEST_CITY);
            listOfCityManagers.add(manager);
        }
	    insert listOfCityManagers;
		
		List<Loan__c> listOfLoans = new List<Loan__c>();
        for(Integer index = 0; index< noOfLoans; index++){
            Loan__c loan = new Loan__c(
            	Name__c = TEST_NAME+index,
                Manager__c = listOfCityManagers[0].Id,
                City__c = TEST_CITY,
                Applicant_Name__c = TEST_NAME,
                Applicant_Email__c= TEST_EMAIL,
                Amount__c = TEST_AMOUNT,
                Status__c = TEST_STATUS
            );
            listOfLoans.add(loan);
        }       
        insert listOfLoans;
    }
    
    @isTest static void testGetLoanApplicantDetailsShouldReturnListOfProcessedLoans(){
        List<Loan__c> listofLoanIds = getLoans();

        Test.startTest();
        	List<Loan__c> listOfLoans = LoanDAO.getLoanApplicantDetails(listOfLoanIds);
        Test.stopTest();
        
        Integer expected = noOfLoans;
        Integer actual = listOfLoans.size();
        
        System.assertEquals(expected, actual, ERROR_MSG);
    }
}