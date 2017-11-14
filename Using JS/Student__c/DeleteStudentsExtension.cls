public class DeleteStudentsExtension {
    public String Id { get { return Label.Id; } } 
    public String First_Name { get { return Label.First_Name; } } 
    public String Last_Name { get { return Label.Last_Name; } } 
    public String ClassLabel { get { return Label.ClassLabel; } } 
    public String ContinueLabel { get { return Label.ContinueLabel; } } 
    public String Cancel { get { return Label.Cancel; } } 
    
    private List<Student__c> listOfSelectedStudents;
    public DeleteStudentsExtension(ApexPages.StandardSetController controller){
        listOfSelectedStudents = controller.getSelected();
    }
    
    public List<Student__c> getSelectedStudents(){
        if(listOfSelectedStudents.size() == 0){
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
    
    public PageReference cancel(){
        return redirect();
    }
    
    private PageReference redirect(){
        return new PageReference('/a07/o');
    }
}