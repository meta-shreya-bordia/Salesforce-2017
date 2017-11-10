public class Assignment2 {
    StudentDAO studentDAO;
    ClassDAO classDAO;
    
    public Assignment2(){
        studentDAO = new StudentDAO();
        classDAO = new ClassDAO();
    }
    
    /*Write SOQL Select all strudent Name,Dob,Sex where LastName starts with S*/
    public void getStudentDetails(){
        List<Student__c> listOfStudents = studentDAO.getStudentDetails('s%');
    	
        for(Student__c student :listOfStudents){
            System.debug( student.First_Name__c + ' ' + student.Last_Name__c );
        }
    }
    
    /*Select All students where ClassName starts with X*/
    public void getStudentByClass(){
        List<Student__c> listOfStudents = studentDAO.getStudentByClass('X%');
        
        for(Student__c student :listOfStudents){
            System.debug( student.First_Name__c + ' ' 
            	+ student.Last_Name__c + ' '
                + student.Class__r.Name );
        }
    }
    
    /*Select all Student and ClassName*/
    public void getAllStudents(){
        List<Student__c> listOfStudents = studentDAO.getStudentByClass('%');
        
        for(Student__c student :listOfStudents){
            System.debug( student.First_Name__c + ' ' 
            	+ student.Last_Name__c + ' '
                + student.Class__r.Name );
        }
    }
    
    /*Select all Classes with students in every class as sub query*/
    public void getClassDetails(){
        List<Class__c> listOfClasses = classDAO.getRelatedStudents('%'); 
        
        for(Class__c cls :listOfClasses){
            System.debug( cls.Name + ' ' 
                + cls.student__r + ' ');   
        }
    }
    
    /*Select all students where class teacher name starts with */
    public void getByClassTeacher(){
        List<Class__c> listOfClasses = classDAO.getByClassTeacher('S%');
        
        for(Class__c cls :listOfClasses){
            System.debug( cls.Name + ' ' 
                + cls.Contact__c + ' ');      
        }
    }
    
    /*All students where DOB > Year 2000*/
    public void getByDOB(){
        List<Student__c> listOfStudents = studentDAO.getByDOB(2000);
        
        for(Student__c student :listOfStudents){
            System.debug( student.First_Name__c + ' ' 
            	+ student.Last_Name__c + ' '
                + student.DOB__c );
        }
    }
    
    /*All Leads Where ModifiedDate in current month*/
    public void getModifiedLeads(){
        List<Lead> listOfLeads = new LeadDAO().getByModifiedDate();
        
        for(Lead lead :listOfLeads){
            System.debug( lead.Name + ' ' 
                + lead.Company + ' '
            	+ lead.LastModifiedDate);
        }
    }
    
    /*All Classes with Students as sub query where student Name Starts with S*/
    public void getClassRelatedStudents(){
        List<Class__c> listOfClasses = classDAO.getRelatedStudents('S%');
        
        for(Class__c cls :listOfClasses){
            System.debug( cls.Name + ' ');
            
            List<Student__c> listOfStudents = cls.student__r;
            
            for(Student__c std :listOfStudents){
            	System.debug( std.First_Name__c + ' ' + std.Last_Name__c );    
            }
        }
    }
    
    /*All Teachers who have Hindi and English both subjects*/
    public void getTeacherBySubject(){
        List<Contact> listOfTeachers = new TeacherDAO()
            .getTeacherBySubjects('Hindi;English');
        
        for(Contact teacher :listOfTeachers){
            System.debug( teacher.FirstName + ' ' 
            	+ teacher.LastName + ' '
                + teacher.Subjects__c );
        }
    }
    
    /*All students who have hindi or maths */
    public void getStudentsBySubject(){
        List<Student__c> listOfStudents = studentDAO
            .getStudentsBySubject();

        for(Student__c student :listOfStudents){
            System.debug( student.First_Name__c + ' ' 
            	+ student.Last_Name__c + ' '
                + student.Class__r.Name);
        }
    }
}