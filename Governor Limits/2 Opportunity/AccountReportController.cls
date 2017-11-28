public class AccountReportController {
    public String name {get;set;}
    public integer quantity {get;set;}

    public AccountReportController(string n,integer q){
        this.quantity=q;
        this.name=n;
    }
    
    public AccountReportController(ApexPages.StandardController controller){
    }
    
    public List<AccountReportController> assetList = new List<AccountReportController>();
    
    public List<AccountReportController> getAccounts(){
        List<AggregateResult>  ag = [
            SELECT Account.Name name, 
            	SUM(Amount) quantity
            FROM Opportunity 
            GROUP BY Account.Name
            LIMIT 10
        ];
        
        for(AggregateResult resultList :ag){
            assetList.add( new AccountReportController(String.valueOf(resultList.get('name')),integer.valueOf(resultList.get('quantity'))) );
        }
        
        return assetList;
    }
}