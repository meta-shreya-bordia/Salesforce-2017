public class DeleteStudentsExtension {
    public List<Student__c> listOfSelectedStudents;
    public DeleteStudentsExtension(ApexPages.StandardSetController controller){
        listOfSelectedStudents = controller.getSelected();
    }
    
    public List<Student__c> getSelectedStudents(){
        if(listOfSelectedStudents == null || listOfSelectedStudents.size() == 0){
            ApexPages.addmessage(new ApexPages.message(
                ApexPages.severity.WARNING, 'No records selected'));
            return null;
        }

        List<Student__c> listOfStudents = StudentDAO.getStudentByClass(
        	listOfSelectedStudents);
        
        return listOfStudents;
    }
    
    public PageReference continueDeletion(){
        if(listOfSelectedStudents.size() != 0){
            delete listOfSelectedStudents;
        }
        
        return redirect();
    }
    
    private PageReference redirect(){
        return new PageReference('/a07/o');
    }
}