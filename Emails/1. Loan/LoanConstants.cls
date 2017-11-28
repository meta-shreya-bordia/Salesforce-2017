public class LoanConstants {
	public static final String EMAIL_SUBJECT_APPROVED = 'Loan approved';
    public static final String EMAIL_SUBJECT_DECLINED = 'Loan declined';
    
    public static final String EMAIL_BODY_APPROVED = 
        'Your loan {!Loan__c.Name} numbered {Loan__c.Id} for amount {!Loan__c.Amount__c} has been approved by {!Loan__c.Manager__c}';
    public static final String EMAIL_BODY_DECLINED = 
        'Your loan {!Loan__c.Name} numbered {Loan__c.Id} for amount {!Loan__c.Amount__c} has been declined by {!Loan__c.Manager__c}.'
        +'Contact administration for further queries.';

    public static final String APPROVED = 'Approved';
    public static final String REJECTED = 'Rejected';    
}