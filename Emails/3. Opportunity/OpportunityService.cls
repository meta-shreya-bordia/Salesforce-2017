public class OpportunityService {
    public static void notifyOpportunityOwner(List<Opportunity> listOfOpportunities){
        String subject = 'Your opportunity has been modified';
        
        for(Opportunity opportunity :listOfOpportunities){
			String emailBody = 'Dear '+opportunity.Owner.Name
                +'\nYour opportunity '+opportunity.Name
                +' due on '+opportunity.CloseDate
                +' has been modified to '+opportunity.StageName;
        
            EmailService.sendMail( opportunity.Owner.Email , subject, emailBody);
        }
    }
}