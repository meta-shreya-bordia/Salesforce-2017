public class AddStudentExtension {
    public String Add_Student {get { return Label.Add_Student; }}
    public String Cancel {get { return Label.Cancel; }}
    public Student__c student {get; set;}
        
    public AddStudentExtension(ApexPages.StandardController stdController) {
        student = new Student__c();
    }
    
    public PageReference addStudent(){
        Id classId = ApexPages.currentPage().getParameters().get('id');
        
        Student__c addStudent = new Student__c(
            First_Name__c = student.First_Name__c,
            Last_Name__c  = student.Last_Name__c,
            Class__c = classId
        );
        
        insert addStudent;
        return new PageReference('/'+addStudent.Id);
    }
    
    public void cancel(){
    }
}
