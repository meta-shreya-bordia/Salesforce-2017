public class OpportunityService {
    public static void notifyOpportunityOwner(List<Opportunity> listOfOpportunities){
        String subject = Label.Opportunity_Email_Subject;
        
        for(Opportunity opportunity :listOfOpportunities){
            String emailBody = String.format(Label.Opportunity_Email_Body, new String[]{
                opportunity.Owner.Name,
                opportunity.Name,
                String.valueOf(opportunity.CloseDate),
                opportunity.StageName} );
        
            EmailService.sendMail( opportunity.Owner.Email , subject, emailBody);
        }
    }
}