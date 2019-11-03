public class TeacherDAO implements ITeacherDAO {
    
    public interface ITeacherDAO{
        List<Contact> getTeacherBySubjects(String allSubjects);
        List<Contact> getTeacherDetails(List<Contact> listOfContacts);
    }
        
    public static List<Contact> getTeacherBySubjects(String allSubjects){
        return [
            SELECT FirstName, LastName, Subjects__c
            FROM Contact as Teacher
         	WHERE Subjects__c INCLUDES(:allSubjects)
        ];
    }
        
    public static List<Contact> getTeacherDetails(List<Contact> listOfContacts){
        return [
            SELECT Id, Subjects__c
            FROM Contact
        ];
    }    
}