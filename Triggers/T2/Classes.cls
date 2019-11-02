public class Classes extends fflib_SObjectDomain { 
    
    public Classes(List<SObject> sObjectList) {
        super(sObjectList);
    }

    public class Constructor implements fflib_SObjectDomain.IConstructable {
        public fflib_SObjectDomain construct(List<SObject> sObjectList) {
            return new Classes(sObjectList);
        }
    }
    
    public override void onBeforeDelete(){
    	checkForFemaleStudent();
    }
        
    public void checkForFemaleStudent(){
        List<Class__c> listOfClasses = (List<Class__c>) Records;
        List<Class__c> listOfClassStudents = 
            ClassDAO.getFemaleStudents(listOfClasses);
        
        for(Integer cls = 0; cls < listOfClasses.size(); cls++) {
        	if( listOfClassStudents[cls].Student__r.size() > 0 ){
                listOfClasses[cls].addError(
                    ClassConstants.ACCESS_DENIED_TO_DELETE);   
            }
        }
    }
}