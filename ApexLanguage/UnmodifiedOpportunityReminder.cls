global class UnmodifiedOpportunityReminder implements Schedulable{
	
    global void execute(SchedulableContext ctx) {
        OpportunityDAO opportunityDAO = new OpportunityDAO();
        
        List<Opportunity> listOfOpportunities = 
            opportunityDAO.getUnmodifiedOpportunities();

        List<String> emailAddresses = new List<String>();
        
        for(Opportunity opp :listOfOpportunities){
            emailAddresses.add( opp.Owner.Email );
        }    
        
     	BulkEmailManager.sendEmail(emailAddresses,
            'Unmodified Opporunity',
            'Hello, Your opporunity has not been modified from past 30 days');
    }
}