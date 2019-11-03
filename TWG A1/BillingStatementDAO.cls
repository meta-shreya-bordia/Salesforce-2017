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
            SELECT Id, Name, Total_Amount__c, Paid_Amount__c, Is_Paid__c
            FROM Billing_Statement__c
            WHERE Id IN :billingStatementIds
        ];
    }
    
    public static List<Billing_Statement__c> getUnpaidPositiveTotalStatements(){
        return [
            SELECT Id, Name, Total_Amount__c, Paid_Amount__c
            FROM Billing_Statement__c
            WHERE Is_Paid__c = false
            	AND Total_Amount__c > 0
        ];
    }
    
    public static List<Billing_Statement__c> getUnpaidNegativeTotalStatements(){
        return [
            SELECT Id, Name, 
            Total_Amount__c, Paid_Amount__c
            FROM Billing_Statement__c
            WHERE Is_Paid__c = false
				AND Total_Amount__c <= 0
        ];
    }
}