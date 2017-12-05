public class Opportunities extends fflib_SObjectDomain {
        
    public Opportunities(List<SObject> sObjectList) {
        super(sObjectList);
    }

    public class Constructor implements fflib_SObjectDomain.IConstructable {
        public fflib_SObjectDomain construct(List<SObject> sObjectList) {
            return new Opportunities(sObjectList);
        }
    }
    
    public override void onBeforeUpdate(Map<Id,SObject> existingRecords){
        updateAccountManager();
        updateOppCloseDate(existingRecords);
        notifyOpportunityOwnerWhenStatusUpdated(existingRecords);
    }    
        
    public override void onAfterUpdate(Map<Id,SObject> existingRecords){
    	deleteRelatedOpportunityLineItems();
    }    
        
    public void updateOppCloseDate(Map<Id,SObject> existingRecords){
        List<Opportunity> listOfOpportunities = (List<Opportunity>) Records;
        List<Opportunity> listOfOldOpportunities = existingRecords.values();
        
        for(Integer index =0; index < listOfOpportunities.size(); index++) {
            if((listOfOldOpportunities[index].StageName != listOfOpportunities[index].StageName)
                && (OpportunityConstants.CLOSED_WON.equals(listOfOpportunities[index].StageName)
                || OpportunityConstants.CLOSED_LOST.equals(listOfOpportunities[index].StageName) ) ){
                
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
        List<Opportunity> listOfOpportunities = OpportunityDAO.getRelatedOpportunityLineItem((List<Opportunity>) Records);
    	List<OpportunityLineItem> listOfOpportunityLineItems = new List<OpportunityLineItem>();
        
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
        
    public void notifyOpportunityOwnerWhenStatusUpdated(Map<Id,SObject> existingRecords){
        List<Opportunity> listOfOpportunities = OpportunityDAO.getOpportunityDetails((List<Opportunity>) Records);
        List<Opportunity> listOfOldOpportunities = existingRecords.values();
        List<Opportunity> listOfOpportunitiesToEmail = new List<Opportunity>();
        
        for(Integer index =0; index < listOfOpportunities.size(); index++) {
            if( listOfOpportunities[index].Owner.Email != null
                && ! listOfOldOpportunities[index].StageName.equals(listOfOpportunities[index].StageName) ){
                
				listOfOpportunitiesToEmail.add(listOfOpportunities[index]);    
            }
        }
		
        OpportunityService.notifyOpportunityOwner( listOfOpportunitiesToEmail ); 	   
    }  
}