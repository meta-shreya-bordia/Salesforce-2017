public class BillingStatementDAO implements IBillingStatementDAO {

    public interface IBillingStatementDAO{
        List<Billing_Statement__c> getUnpaidPositiveTotalStatements();
        List<Billing_Statement__c> getUnpaidNegativeTotalStatements();
        List<Billing_Statement__c> getBillingStatements(
            List<Billing_Statement__c> billingStatementIds);
    }
    
    public static List<Billing_Statement__c> getBillingStatements(
        List<Billing_Statement__c> billingStatementIds){
        return [
            select Id, Name, 
            	Total_Amount__c, Paid_Amount__c,
                Is_Paid__c
            from Billing_Statement__c
            where Id in :billingStatementIds
        ];
    }
    
    public static List<Billing_Statement__c> getUnpaidPositiveTotalStatements(){
        return [
            select Id, Name, 
            	Total_Amount__c, Paid_Amount__c
            from Billing_Statement__c
            where Is_Paid__c = false
            	and Total_Amount__c > 0
        ];
    }
    
    public static List<Billing_Statement__c> getUnpaidNegativeTotalStatements(){
        return [
            select Id, Name, 
            Total_Amount__c, Paid_Amount__c
            from Billing_Statement__c
            where Is_Paid__c = false
				and Total_Amount__c <= 0
        ];
    }
}