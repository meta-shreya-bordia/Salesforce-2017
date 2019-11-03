public class BillingStatementController {
   	/*VF PAGE Properties*/
    public Decimal PaymentAmount {get; set;}
    public Decimal TotalAllocated {get; set;}
    public Decimal TotalAvailableToAllocate {get; set;}
    
    public Id selectedBillingStatement{get; set;}
    public Decimal oldValue {get; set;}
    
    /*Controller properties*/
    private List<BillingStatementWrapper> listOfBillingStatementWrappers;
    
	public BillingStatementController(){
        TotalAllocated = 0.0;
        TotalAvailableToAllocate = 0.0;
        listOfBillingStatementWrappers = new List<BillingStatementWrapper>();
    }
    
    public List<BillingStatementWrapper> getPositiveTotalBillingStatements(){
        List<BillingStatementWrapper> listOfPositiveBillingStatementWrappers = new List<BillingStatementWrapper>();
        
        for(Billing_Statement__c statement: BillingStatementDAO.getUnpaidPositiveTotalStatements()) {
            BillingStatementWrapper billingStatement = new BillingStatementWrapper(statement);
            listOfPositiveBillingStatementWrappers.add(billingStatement);
            listOfBillingStatementWrappers.add( billingStatement );
        }
        
        return listOfPositiveBillingStatementWrappers;
    }
    
        public List<BillingStatementWrapper> getNegativeTotalBillingStatements(){
        List<BillingStatementWrapper> listOfNegativeBillingStatementWrappers = new List<BillingStatementWrapper>();
        
        for(Billing_Statement__c statement: BillingStatementDAO.getUnpaidNegativeTotalStatements()) {
            BillingStatementWrapper billingStatement = new BillingStatementWrapper(statement);
            listOfNegativeBillingStatementWrappers.add( billingStatement );
            listOfBillingStatementWrappers.add( billingStatement );
        }
        
        return listOfNegativeBillingStatementWrappers;
    }

    /*Wrapper Class*/
    public class BillingStatementWrapper {
        public Billing_Statement__c billingStatement {get; set;}
        public Decimal outstanding {get; set;}
        public Decimal allocate {get; set;}
        public Boolean selected {get; set;}
        
        public BillingStatementWrapper(Billing_Statement__c statement){
            this.billingStatement = statement;
            selected = false;
            allocate = 0.0;
            outstanding = statement.Total_Amount__c + statement.Paid_Amount__c;
        }
    }
}