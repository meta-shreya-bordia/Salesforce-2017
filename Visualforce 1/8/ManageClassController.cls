public class ManageClassController {
   
   public Id classId {get; set;}
   public Class__c classObject {get; set;}
   public Boolean toBeRendered{get; set;}
   public Map<Id,Class__c> mapOfClass;
   
   public ManageClassController(){
       hide();
   }
   
   public void setClassObject(){
       classObject = mapOfClass.get(classId);
       toBeRendered = true;
   }
   
   public List<Class__c> getClasses(){
       mapOfClass = ClassDAO.getClassDetails();
       return mapOfClass.values();
   }
   
   public void hide() {
       toBeRendered = false;
   }
   
   public void save(){
       update classObject;
       toBeRendered = false;
   }
   
   public void deleteClass(){
       setClassObject();
       delete classObject;
       mapOfClass.remove(classObject.Id);
   }
}