public class OpportunityDAO Implements IOpportunityDAO {
    public interface IOpportunityDAO{
        List<Opportunity> getUnmodifiedOpportunities();
        List<Opportunity> getRelatedOpportunityLineItem(List<Opportunity> listOfOpportunities);
        Opportunity getOpportunity(Id opportunityId);
        List<Opportunity> getOpportunityDetails(List<Opportunity> listOfOpportunities);
    }
    
    public static List<Opportunity> getUnmodifiedOpportunities(){
        return [
            SELECT Id, Owner.Email, LastModifiedDate
		    FROM Opportunity
		    WHERE LastModifiedDate != LAST_N_DAYS:30
        ];
    }
    
    public static List<Opportunity> getRelatedOpportunityLineItem(List<Opportunity> listOfOpportunities){
        return [
            SELECT Id, Custom_Status__c,
               (SELECT Id
               FROM OpportunityLineItems)
            FROM Opportunity
            WHERE Id IN :listOfOpportunities
        ];
    }
    
    public static Opportunity getOpportunity(Id opportunityId){
        return [
            SELECT Id, Manager__c, BillToContact__c
            FROM Opportunity 
            WHERE Id = :opportunityId
       ];
    }
    
    public static List<Opportunity> getOpportunityDetails(List<Opportunity> listOfOpportunities){
        return [
            SELECT Id, Name, Owner.Name, Owner.Email, StageName, CloseDate
            FROM Opportunity
            WHERE Id IN :listOfOpportunities
        ];
    }
}