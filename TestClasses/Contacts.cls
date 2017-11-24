public class Contacts extends fflib_SObjectDomain { 
    
    public Contacts(List<SObject> sObjectList) {
        super(sObjectList);
    }

    public class Constructor implements fflib_SObjectDomain.IConstructable {
        public fflib_SObjectDomain construct(List<SObject> sObjectList) {
            return new Contacts(sObjectList);
        }
    }

    public override void onBeforeInsert(){
    }
    
    public override void onBeforeUpdate(Map<Id,SObject> existingRecords){
    	denyAccess();
    }
    
    
    
    public void denyAccess(){
        for(Contact contact :((List<Contact>)Records) ) {
            if(	contact.Subjects__c != null
                && contact.Subjects__c.contains(ContactConstants.HINDI)){
                contact.addError(ContactConstants.ACCESS_DENIED);
            }
        }
    }
}