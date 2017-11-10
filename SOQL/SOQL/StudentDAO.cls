public class StudentDAO 
	implements IStudentDAO {

    public interface IStudentDAO{
   		List<Student__c> getStudentDetails(String searchPattern);
        List<Student__c> getStudentByClass(String searchPattern);
        List<Student__c> getStudentByClass(List<Student__c> listOfStudents);
        List<Student__c> getStudentByClassId(Id classId);
        List<Student__c> getByDOB(Integer searchYear);
        List<Student__c> getStudentsBySubject();
    }
        
    public List<Student__c> getStudentDetails(String searchPattern) {
        return [
            SELECT Id, First_Name__c, Last_Name__c,
            	DOB__c, Sex__c
            FROM Student__c
            WHERE Last_Name__c LIKE :searchPattern 
        ]; 
    }
        
    public List<Student__c> getStudentByClass(String searchPattern) {
    	return [
            SELECT First_Name__c, Last_Name__c,
            	Class__r.Name
            FROM Student__c
            WHERE Class__r.Name LIKE :searchPattern
        ];        
    }
    
    public List<Student__c> getStudentByClass(List<Student__c> listOfStudents){
    	return [
            SELECT Id, Class__c
            FROM Student__c
            WHERE Id IN :listOfStudents
        ];        
    }    
        
    public List<Student__c> getStudentByClassId(Id classId) {
    	return [
            SELECT First_Name__c, Last_Name__c,
            	Class__r.Name, Sex__c
            FROM Student__c
            WHERE Class__r.Id = :classId
        ];
    }
        
    public List<Student__c> getByDOB(Integer searchYear){
    	return [ 
            SELECT First_Name__c, Last_Name__c, DOB__c
			FROM Student__c
			WHERE CALENDAR_YEAR(DOB__c) > :searchYear
        ];
    }
        
    public List<Student__c> getStudentsBySubject(){
        List<Id> listofClassIds = new ClassDAO().getClassBySubject();
        
    	return [
            SELECT First_Name__c, 
            	Last_Name__c,
            	Class__r.Name
			FROM Student__c
			WHERE Class__r.Id IN :listofClassIds
        ];        
    }      
}