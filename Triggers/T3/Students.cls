public class Students extends fflib_SObjectDomain {     
    public Students(List<SObject> sObjectList) {
        super(sObjectList);
    }

    public class Constructor implements fflib_SObjectDomain.IConstructable {
        public fflib_SObjectDomain construct(List<SObject> sObjectList) {
            return new Students(sObjectList);
        }
    }
    
    public override void onBeforeInsert(){
        checkClassSize();
    }
    
   	public override void onAfterInsert(){
        updateClassCount();
    }
    
    public override void onAfterDelete(){
        updateClassCount();
    }
    
    public void checkClassSize(){
       List<Student__c> listOfStudents = (List<Student__c>) Records;
       Map<Id, Class__c> mapOfClasses = ClassDAO.getClassDetails();

       for(Student__c student :listOfStudents){
           Class__c cls = mapOfClasses.get(student.Class__c);
           if( cls.Max_Size__c != null
               && cls.Max_Size__c <= cls.Number_of_Students__c ){
               student.addError(StudentConstants.ACCESS_DENIED_TO_INSERT);    
           }
       }
    }
    
    public void updateClassCount(){
		List<Student__c> listOfStudents = 
           StudentDAO.getStudentByClass((List<Student__c>) Records);
        Map<Id, Class__c> mapOfClasses =
            ClassDAO.getClassDetails();
        
        for(Student__c student :listOfStudents){
            Class__c cls = mapOfClasses.get(student.Class__c);
            if( cls.Student__r != null){
                cls.MyCount__c = cls.Student__r.size();    
            }
        }
        
        update mapOfClasses.values();
    }
}