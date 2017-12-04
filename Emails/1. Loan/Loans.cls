public class Loans extends fflib_SObjectDomain {     
    public Loans(List<SObject> sObjectList) {
        super(sObjectList);
    }

    public class Constructor implements fflib_SObjectDomain.IConstructable {
        public fflib_SObjectDomain construct(List<SObject> sObjectList) {
            return new Loans(sObjectList);
        }
    }
    
    public override void onApplyDefaults() {
        setCityManager();
    }
    
    public override void onAfterUpdate(Map<Id,SObject> existingRecords) {
        notifyLoanApplicant(existingRecords);
    }

    public void setCityManager(){
        List<CityManager__c> listOfManagers = CityManagerDAO.getManagerByCity();
        List<Loan__c> listOfLoans = (List<Loan__c>) Records;
        
        for(Loan__c loan :listOfLoans) {
            for(CityManager__c manager :listOfManagers){
                if( loan.City__c == manager.City__c){
                    loan.Manager__c = manager.Id;
            	}
            }
        }
    }
    
    public void notifyLoanApplicant(Map<Id,SObject> exisitingRecords){
        List<Loan__c> listOfLoans = LoanDAO.getLoanApplicantDetails( (List<Loan__c>) Records );
        List<Loan__c> listOfOldLoans = exisitingRecords.values();
        List<Loan__c> listOfLoansToEmail = new List<Loan__c>();
        
        for(Integer index = 0; index < listOfLoans.size(); index++){
            if( listOfLoans[index].Applicant_Email__c != null
              && listOfLoans[index].Status__c != listOfOldLoans[index].Status__c
              && ( LoanConstants.APPROVED == listOfLoans[index].Status__c
              	|| LoanConstants.REJECTED == listOfLoans[index].Status__c) ){
                listOfLoansToEmail.add( listOfLoans[index] );
            }
        }
        
        LoanService.sendEmaiToLoanApplicant(listOfLoansToEmail);
    }
}
