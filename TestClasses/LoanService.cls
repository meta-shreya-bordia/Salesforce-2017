public class LoanService {
    public static void sendEmaiToLoanApplicant(List<Loan__c> listOfLoans){
        for(Loan__c loan :listOfLoans){
            String subject = String.format(Label.Loan_Email_Subject, new String[] {loan.Status__c});
            
            String emailBody = String.format(Label.Loan_Email_Body, new String[] { 
                loan.Applicant_Name__c,
                loan.Name__c,
                loan.Id,
                String.valueOf(loan.Amount__c), 
                loan.Status__c,
                loan.Manager__r.Name });
            
            EmailService.sendMail(loan.Applicant_Email__c, subject, emailBody);
        }
    }
}