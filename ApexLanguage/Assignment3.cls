public class Assignment3 {
    StudentDAO studentDAO;
    ClassDAO classDAO;
    
    public Assignment3(){
    	studentDAO = new StudentDAO();
        classDAO = new ClassDAO();
    }
    
    /*1. all names of the students in that class as a list.*/
    public void getClassStudents(){
	List<Student__c> listOfStudents = studentDAO.getStudentByClassId('a067F000002sqx3QAA');
        
        for(Student__c student :listOfStudents){
            System.debug( student.First_Name__c + ' ' 
            	+ student.Last_Name__c + ' '
                + student.Class__r.Name);
        }
    }
    
    /*2. map where key is class and value is set of studentid in it.*/
    public void getRelatedStudents(){
        Map<Class__c, Set<Id>> mapOfClassStudent = classDAO.getRelatedStudents();
        
        for(Class__c classObj :mapOfClassStudent.keySet()){
            Set<Id> setOfStudentIds = mapOfClassStudent.get( classObj );
            
            System.debug( classObj + ' ' + setOfStudentIds );
        }
    }  
    
    /*3. number of working days between two days excluding both days(Saturday and Sunday is nonworking)*/
    public void getWorkingDays(){
        Integer workDays = new DateUtil().getWeekdayDifference(Date.newInstance(1900, 10, 28),
            Date.newInstance(1900, 10, 30)
        );
        
        System.debug( workDays );
    }
    
    /*4. stack class*/
    public void stackFunctionality(){
        Stack stck = new Stack();
	System.debug( stck.pop() );
 	stck.push(null);
	System.debug( stck.pop() );

        stck.push( new Contact(LastName = 'ABC') );
        stck.push('ABC');
 	stck.push( new Student__c(First_Name__c = 'ABC', Last_Name__c = 'XYZ',
            Class__c = 'a067F000002sqx3QAA') );
		
        System.debug( stck.pop() );
	System.debug( 'Size: '+ stck.size() );
    }
    
    /*5. Scheduler to mail to Opportunity Owner , if not modified for last 30 days*/
    public void scheduleOpportunityCheck(){
        UnmodifiedOpportunityReminder remindeOppOwner = new UnmodifiedOpportunityReminder();
        
        // Seconds Minutes Hours Day_of_month Month Day_of_week optional_year
        String CRON_EXPR = '0 0 0 * * ?';	//run everyday at 12 am
        String jobID = System.schedule('UnmodifiedOpportunities', CRON_EXPR, remindeOppOwner);
    }

    /*6. list of sobjects exists in Organization*/
    public void getObjectsInOrg(){
        Map<String, Schema.SObjectType> orgInstances = new OrganisationInformation().getObjectsInOrg();
        
        for(String objectName :orgInstances.keySet()){
            System.debug( orgInstances.get(objectName) );
        }
    }
}
