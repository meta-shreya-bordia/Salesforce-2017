public class Opportunities 
	extends fflib_SObjectDomain {
        
    public Opportunities(List<SObject> sObjectList) {
        super(sObjectList);
    }

    public class Constructor implements fflib_SObjectDomain.IConstructable {
        public fflib_SObjectDomain construct(List<SObject> sObjectList) {
            return new Opportunities(sObjectList);
        }
    }
        
    public override void onValidate() {
        for(Opportunity opp : (List<Opportunity>) Records) {
            if(opp.Type.startsWith(OpportunityConstants.EXISTING) 
               && opp.AccountId == null) {
                opp.AccountId.addError(OpportunityConstants.INVALID_DATA);
            }
        }
	}
        
    public override void onBeforeUpdate(Map<Id,SObject> existingRecords){
        updateAccountManager();
    	updateOppCloseDate(existingRecords);
    }    
        
    public override void onAfterUpdate(Map<Id,SObject> existingRecords){
    	deleteRelatedOpportunityLineItems();
    }    
        
    public void updateOppCloseDate(Map<Id,SObject> existingRecords){
        List<Opportunity> listOfOpportunities = (List<Opportunity>) Records;
        List<Opportunity> listOfOldOpportunities = existingRecords.values();
        
        for(Integer index =0; index < listOfOpportunities.size(); index++) {
            if((listOfOldOpportunities[index].StageName != listOfOpportunities[index].StageName)
                &&
               (OpportunityUtil.checkStageName(listOfOpportunities[index], OpportunityConstants.CLOSED_WON)
                || OpportunityUtil.checkStageName(listOfOpportunities[index], OpportunityConstants.CLOSED_LOST))  ){
                
                listOfOpportunities[index].CloseDate = System.Today();
            }
        }
    }
    
    public void updateAccountManager(){
    	for(Opportunity opp: (List<Opportunity>) Records){        
            if( opp.BillToContact__c != null && opp.Manager__c == null){
            	opp.Manager__c = opp.AccountId;    
            }
    	}           
    } 
   
    public void deleteRelatedOpportunityLineItems(){
        List<Opportunity> listOfOpportunities =
            OpportunityDAO.getRelatedOpportunityLineItem((List<Opportunity>) Records);
        
    	List<OpportunityLineItem> listOfOpportunityLineItems =
            new List<OpportunityLineItem>();
        
        for(Opportunity opp: listOfOpportunities){        
            if( opp.Custom_Status__c != null
                && opp.Custom_Status__c == OpportunityConstants.RESET
                && opp.OpportunityLineItems != null
                && opp.OpportunityLineItems.size() > 0){
                
                List<OpportunityLineItem> listOfOppLineItems = opp.OpportunityLineItems;                  
                listOfOpportunityLineItems.addAll(listOfOppLineItems);
            }
    	}

        delete listOfOpportunityLineItems;
    }      
}

/**@Trigger	ClosedOpportunityTrigger
 * trigger for before insert and before update
 * when Opportunity StageName = 'Closed Won'
 * create a follow up task 

trigger ClosedOpportunityTrigger on Opportunity (before insert, before update, before delete,
    after insert, after update, after delete, after undelete) {
        
    List<Task> listOfTasks = new List<Task>();
	OpportunityDAO oppDAO = new OpportunityDAO();
        
	if( (Trigger.isInsert || Trigger.isUpdate) && Trigger.isBefore ){
     	for(Opportunity opportunity: oppDAO.getClosedWonOpportunity((List<Opportunity>) Trigger.New)){
			Task followUpTask = Tasks.createNewTask(opportunity, OpportunityConstants.FOLLOW_UP_TEST_TASK);
        	listOfTasks.add(followUpTask);                                                    
     	}
    }
    
	TaskDAO.insertTasks(listOfTasks);
}**/