global class UnmodifiedOpportunityReminder implements Schedulable{
    global void execute(SchedulableContext context) {
      	List<Opportunity> listOfOpportunities = 
            OpportunityDAO.getUnmodifiedOpportunities();

        if( listOfOpportunities != null && listOfOpportunities.size() > 0 ){
            for(Opportunity opportunity :listOfOpportunities){
                EmailService.sendMail( opportunity.Owner.Email, 
                    OpportunityConstants.UNMODIFIED_OPPORTUNITY,
                    OpportunityConstants.UNMODIFIED_OPPORTUNITY_BODY);
            }    
            

        }
    }
}