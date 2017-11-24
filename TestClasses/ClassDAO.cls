public class ClassDAO implements IClassDAO {
        
    public interface IClassDAO{
    	List<Class__c> getRelatedStudents(String searchPattern);
        Map<Class__c, Set<Id>> getRelatedStudents();
        List<Class__c> getByClassTeacher(String searchPattern);
        List<Id> getClassBySubject();
        Map<Id, Class__c> getClassDetails();
        List<Class__c> getClassDetails(List<Id> listOfClassIds);
    }
      
    public static List<Class__c> getRelatedStudents(String searchPattern){
    	return [
            SELECT Name, 
            	(SELECT First_Name__c, 
                 	Last_Name__c
                 FROM Student__r
                 WHERE First_Name__c LIKE :searchPattern +'%'
                )
			FROM Class__c
        ];        
    }
          
    public static Map<Class__c, Set<Id>> getRelatedStudents(){
    	Map<Class__c, Set<Id>> mapOfClasses = new Map<Class__c, Set<Id>>();
        
        List<Class__c> listOfClasses = [
            SELECT Id,
            	(SELECT Id FROM Student__r)
            FROM Class__c
        ];        
        
        for(Class__c cls :listOfClasses){
            Set<Id> setOfStudentIds = new Set<Id>();
                
            for(Student__c student :cls.Student__r){
                setOfStudentIds.add( student.Id );
            }

			mapOfClasses.put( cls, setOfStudentIds );            
        }
        
        return mapOfClasses;
    }   
        
    public static Map<Id, Class__c> getClassDetails(){
    	return new Map<Id, Class__c>( [
            SELECT Id, Name, Contact__c, Board__c, Fee__c,
            	Max_Size__c, MyCount__c,
            	Number_of_Students__c,
            	(SELECT Id
                FROM Student__r)
            FROM Class__c
        ]);       
    }    
        
    public static List<Class__c> getByClassTeacher(String searchPattern){
    	return [  
            SELECT Name, 
            	Contact__r.FirstName, Contact__r.LastName
			FROM Class__c
			WHERE Contact__r.FirstName LIKE :searchPattern +'%'
        ];
    }
        
    public static List<Id> getClassBySubject(){
    	List<Teach__c> listOfTeaches = [
        	SELECT Class__r.Id
			FROM Teach__c
			WHERE Subject__c = 'hindi'
				OR Subject__c = 'maths'
        ];
        
        List<Id> listOfClassIds = new List<Id>();
        for(Teach__c cls :listOfTeaches){
            listOfClassIds.add(cls.Class__r.Id);
        }
        
        return listOfClassIds;
    }          
    
    public static List<Class__c> getClassDetails(List<Id> listOfClassIds){
    	return [
            SELECT Id, Name, Contact__c, 
            	Max_Size__c, Fee__c, Board__c,
	            Number_of_Students__c, MyCount__c
            FROM Class__c
            WHERE Id IN :listOfClassIds
        ];        
    }
        
    public static List<Class__c> getFemaleStudents(List<Class__c> listOfClasses){
    	return [
        	SELECT Id,
            	(SELECT Id
                FROM Student__r
                WHERE Sex__c = 'Female')
            FROM Class__c
            WHERE Id IN :listOfClasses
        ];
    }
}