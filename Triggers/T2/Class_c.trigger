trigger Class_c on Class__c (before insert, before update, before delete,
	after insert, after update, after delete, after undelete) {
    
    fflib_SObjectDomain.triggerHandler(Classes.class);
}