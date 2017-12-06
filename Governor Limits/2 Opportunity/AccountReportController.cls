public class AccountReportController {
    public String name {get;set;}
    public integer quantity {get;set;}
    
    public AccountReportController(){}

    public AccountReportController(string name,integer quantity){
        this.quantity = quantity;
        this.name = name;
    }
    
    public List<AccountReportController> getAccounts(){
        List<AccountReportController> listOfAccounts = new List<AccountReportController>();
        List<AggregateResult> listOfAccountOpportunities = AccountDAO.getAccountOpportunities();
        
        for(AggregateResult account :listOfAccountOpportunities){
            listOfAccounts.add( new AccountReportController(String.valueOf(account.get('AccountName')), Integer.valueOf(account.get('SumOfOpportunity'))));
        }
        
        return listOfAccounts;
    }
}