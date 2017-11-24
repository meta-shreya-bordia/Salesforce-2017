public class LoanService {
    public static void sendEmaiToLoanApplicant(List<Loan__c> listOfLoans){
        for(Loan__c loan :listOfLoans){
            String subject = 'Your loan has been '+ loan.Status__c;
            
            String emailBody = 
                'Dear '+ loan.Applicant_Name__c 
                +' Your loan '+ loan.Name 
                +' numbered '+ loan.Id 
                +' for amount '+ loan.Amount__c 
                +' has been '+loan.Status__c 
                +' by '+loan.Manager__r.Name;
            
            EmailService.sendMail(loan.Applicant_Email__c, subject, emailBody);
        }
    }
}