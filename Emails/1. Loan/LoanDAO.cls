public class LoanDAO implements ILoanDAO {
    public interface ILoanDAO{
        List<Loan__c> getLoanApplicantDetails(List<Loan__c> listOfLoans);
    }
    
    public static List<Loan__c> getLoanApplicantDetails(List<Loan__c> listOfLoans){
        return [
            SELECT Applicant_Name__c, Applicant_Email__c, Name , Amount__c, Manager__r.Name, Status__c
            FROM Loan__c
            WHERE Id IN :listOfLoans
                AND (Status__c = :LoanConstants.APPROVED
                OR Status__c = :LoanConstants.REJECTED)
        ];
    }
}