public class BillingStatmentTriggerHandler {

    public static void handleTrigger(List<Billing_Statement__c> listOfNewBillingStatements ){
        if( (Trigger.isInsert || Trigger.isUpdate) && Trigger.isBefore ){
            List<Billing_Statement__c> listOfBillingStatements = BillingStatementDAO.getBillingStatements(listOfNewBillingStatements);
            
            onApplyDefaults(listOfBillingStatements);
            onBeforeInsert(listOfBillingStatements);
        }
    }
    
    public static void onApplyDefaults(List<Billing_Statement__c> listOfNewBillingStatements ){
        setPaidAmountToZero(listOfNewBillingStatements);
    }
    
    public static void onBeforeInsert(List<Billing_Statement__c> listOfNewBillingStatements ){   
        paidStatement( listOfNewBillingStatements );
    }
    
    public static void paidStatement(List<Billing_Statement__c> listOfBillingStatements ){
        for( Billing_Statement__c billingStatement :listOfBillingStatements ){
            if( billingStatement.Total_Amount__c == billingStatement.Paid_Amount__c && billingStatement.Is_Paid__c == false){               
			    billingStatement.Is_Paid__c = true;
            }
        }
    }
    
    public static void setPaidAmountToZero(list<Billing_Statement__c> listOfNewBillingStatements ){
        for( Billing_Statement__c billingStatement :listOfNewBillingStatements ){
            if( billingStatement.Paid_Amount__c == null || billingStatement.Paid_Amount__c <= 0 ){            
			    billingStatement.Paid_Amount__c = 0.0;
            }
        }
    }
}