public class AccountSearchController {
    private final Integer SIZE = 10;
    private List<Account> listOfAccounts;
    
	public String billingCity { get; set;}
    public String billingState { get; set;}
    public String billingCountry { get; set;}
    
    public AccountSearchController(){
        listOfAccounts = AccountDAO.getByBillingAddress('');
    }

	public ApexPages.StandardSetController accountList {
       get {
           if(accountList == null) {    
               accountList = new ApexPages.StandardSetController(listOfAccounts);
               accountList.setPageSize(SIZE);
           }           
           return accountList;
       }
       set;
   }
    
    public List<Account> getAccounts(){
        return (List<Account>)accountList.getRecords();
    }
    
    public void search(){
        String whereClause = '';
       
       	if(billingCity != null && billingCity != '') {
           whereClause = 'WHERE BillingCity = \'' + this.billingCity+'\'';
       	}
	    if(billingState != null && billingState != '') {
        	if(whereClause != ''){
               	whereClause += ' AND BillingState = \'' + this.BillingState+'\'';
           	}
           	else {
               	whereClause = 'WHERE BillingState = \'' + this.billingState+'\'';
           	}
       	}
       	if(billingCountry != null && billingCountry != '') {
           	if(whereClause != ''){
               	whereClause += ' AND BillingCountry = \'' + this.BillingCountry+'\'';
           	}
           	else {
               	whereClause = 'WHERE BillingCountry = \'' + this.billingCountry+'\'';
           	}
       	}
      
        accountList = new ApexPages.StandardSetController(
            AccountDAO.getByBillingAddress(whereClause) );      
        accountList.setPageSize(SIZE);
	}
}