public class StudentListViewController {
    public Id selectedStudentId {get; set;}
    public Student__c selectedStudent {get; set;}
    public Boolean renderDetails {get; set;}
    
    private Map<Id, Student__c> mapOfStudents;
    
    public StudentListViewController(){        
    	mapOfStudents = StudentDAO.getStudentDetails();
    }
    
    public void setSelectedStudent(){
        renderDetails = true;
        selectedStudent = mapOfStudents.get(selectedStudentId);
    }
    
    public List<Student__c> getStudents(){
        return mapOfStudents.values();
    }
}