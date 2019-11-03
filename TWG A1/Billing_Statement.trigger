trigger Billing_Statement on Billing_Statement__c (before insert, before update, before delete,
    after insert, after update, after delete, after undelete) {
        BillingStatmentTriggerHandler.handleTrigger( (List<Billing_Statement__c>)Trigger.New );
}