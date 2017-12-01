public class OrganisationInformation {
    public Map<String, Schema.SObjectType> getObjectsInOrg(){
        return Schema.getGlobalDescribe();
    }
}