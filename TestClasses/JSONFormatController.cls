public class JSONFormatController {
	public String jsonString {get;set;}

    public JSONFormatController(){
        jsonString = prepareData();
    }
    
    private String prepareData(){
        Account account = new Account(Name = 'Test Account');
        account.Industry = 'Agriculture';
        account.BillingCountry = 'USA';
        account.Description = 'Add description to each test account';
        
        return JSON.serialize(account);
    }
}