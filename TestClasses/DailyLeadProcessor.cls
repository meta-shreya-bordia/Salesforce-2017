global class DailyLeadProcessor implements Schedulable {

    global void execute(SchedulableContext ctx) {
    	List<Lead> listOfLeads = [
            SELECT Id, LeadSource
            FROM Lead
            WHERE LeadSource = null
        ];
       
        for(Lead lead :listofLeads){
            lead.LeadSource = 'Dreamforce';
        }
        
        UPDATE listOfLeads;
    }
}