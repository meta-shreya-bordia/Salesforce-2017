public class BillToContactController {
    public BillToContactController(){
        opportunityId = ApexPages.currentPage().getParameters().get('id');
        opportunity = OpportunityDAO.getOpportunity(opportunityId);
    }
    
    private Id opportunityId;
    private Opportunity opportunity;

    public Id billToContact {get;set;}   
    public void setBillToContact(Id setBillToContact){
        this.billToContact = setBillToContact;
    }
    
    public List<SelectOption> contactAsManager {
    	get{
            List<SelectOption> listOfSelectOptions = 
                new List<SelectOption>();
        	Id accountId = opportunity.Manager__c;          
            List<Contact> listOfContacts = new List<Contact>();
            
            if(accountId == null){
            	listOfContacts = null;
            }else{
                listOfContacts = AccountDAO.getRelatedContacts(accountId).contacts;
                for(Contact contact :listOfContacts){
                    //value, label, isDisabled
                    listOfSelectOptions.add( new SelectOption(contact.Id, contact.Name) ); 
                }
            }

            return listOfSelectOptions;
        }
    }
 
    public PageReference save(){
        if(billToContact != null){
            opportunity.BillToContact__c = billToContact;
            update opportunity;
        }
        
      	return redirect();
    }
    
    public PageReference clear(){
        if(opportunity.BillToContact__c!=null || billToContact != null){
            setBillToContact(null);
            opportunity.BillToContact__c = null;
            update opportunity;
        }
        
        return redirect();
    }
    
    public PageReference cancel(){
        return redirect();
    }
    
    private PageReference redirect(){
        PageReference retURL = new PageReference('/'+ opportunityId);
     	retURL.setRedirect(true);
      	return retURL;
    }
}