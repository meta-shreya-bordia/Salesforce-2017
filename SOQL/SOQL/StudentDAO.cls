public class StudentDAO implements IStudentDAO {

    public interface IStudentDAO{
        Map<Id, Student__c> getStudentDetails();
        List<Student__c> getStudentDetails(String searchPattern);
        List<Student__c> getStudentByClass(String searchPattern);
        List<Student__c> getStudentByClass(List<Student__c> listOfStudents);
        List<Student__c> getStudentByClassId(Id classId);
        List<Student__c> getByDOB(Integer searchYear);
        List<Student__c> getStudentsBySubject();
    }
    
    public static Map<Id, Student__c> getStudentDetails(){
    	return new Map<Id, Student__c>([
            SELECT Id, Name, First_Name__c, Last_Name__c, DOB__c, Sex__c, Class__r.Name
            FROM Student__c
        ]);    
    }    
        
    public static List<Student__c> getStudentDetails(String searchPattern) {
        return [
            SELECT Id, First_Name__c, Last_Name__c, DOB__c, Sex__c, Class__r.Name
            FROM Student__c
            WHERE Last_Name__c LIKE :searchPattern 
        ]; 
    }
        
    public static List<Student__c> getStudentByClass(String searchPattern) {
    	return [
            SELECT First_Name__c, Last_Name__c, Class__r.Name
            FROM Student__c
            WHERE Class__r.Name LIKE :searchPattern
        ];        
    }
    
    public static List<Student__c> getStudentByClass(List<Student__c> listOfStudents){
    	return [
            SELECT Id, Class__c, Class__r.Name, First_Name__c, Last_Name__c
            FROM Student__c
            WHERE Id IN :listOfStudents
        ];        
    }    
        
    public static List<Student__c> getStudentByClassId(Id classId) {
    	return [
            SELECT First_Name__c, Last_Name__c, Class__r.Name, Sex__c
            FROM Student__c
            WHERE Class__r.Id = :classId
        ];
    }
        
    public static List<Student__c> getByDOB(Integer searchYear){
    	return [ 
            SELECT First_Name__c, Last_Name__c, DOB__c
            FROM Student__c
            WHERE CALENDAR_YEAR(DOB__c) >= :searchYear
        ];
    }
        
    public static List<Student__c> getStudentsBySubject(){
        List<Id> listofClassIds = ClassDAO.getClassBySubject();
        
    	return [
            SELECT First_Name__c, Last_Name__c, Class__r.Name
            FROM Student__c
            WHERE Class__c IN :listofClassIds
        ];        
    }      
}