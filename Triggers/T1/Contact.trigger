trigger Contact on Contact (before insert, before update, before delete,
	after insert, after update, after delete, after undelete) {
    
    fflib_SObjectDomain.triggerHandler(Contacts.class);            
}