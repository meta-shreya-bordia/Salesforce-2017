import com.sforce.soap.enterprise.Connector;
import com.sforce.soap.enterprise.EnterpriseConnection;
import com.sforce.soap.enterprise.Error;
import com.sforce.soap.enterprise.QueryResult;
import com.sforce.soap.enterprise.SaveResult;
import com.sforce.ws.ConnectionException;
import com.sforce.ws.ConnectorConfig;
import com.sforce.soap.enterprise.sobject.Contact;
import com.sforce.soap.enterprise.sobject.Class__c;
import com.sforce.soap.enterprise.sobject.Student__c;

public class SalesforceCRUD {
	static Integer noOfClasses = 2;
	static Integer noOfStudents = 3;
	
	static String className = "Class-X";
	static String studentName = "Student-X";
	
	static final String USERNAME = "meta.shreya.bordia@metacube.com";
	static final String PASSWORD = "Salesforce1gWWFOJZB5bAEJxkfDPzrcTURp";
	
	static EnterpriseConnection connection;
	
	public static void main(String[] args) {
		ConnectorConfig config = new ConnectorConfig();
		config.setUsername(USERNAME);
		config.setPassword(PASSWORD);
		
		try {
			connection = Connector.newConnection(config);
		
			System.out.println("Auth EndPoint: "+config.getAuthEndpoint());
			System.out.println("Service EndPoint: "+config.getServiceEndpoint());
			System.out.println("Username: "+config.getUsername());
			System.out.println("SessionId: "+config.getSessionId());
			
			queryContacts();
			createStudents();
			
		}catch(ConnectionException error) {
			error.printStackTrace();
		}
	}
	
	public static void queryContacts() {
		System.out.println(" Contacts: ");
		try {
			QueryResult queryResult = connection.query("SELECT Id, FirstName, LastName, Account.Name FROM Contact WHERE AccountId != NULL LIMIT 10");
		
			if( queryResult.getSize() > 0 ) {
				for(Integer index = 0; index < queryResult.getSize(); index++) {
					Contact contact = (Contact) queryResult.getRecords()[index];
					
					System.out.println( "ID: "+ contact.getId()
						+" Name: "+ contact.getFirstName() +" "+ contact.getLastName()
						+" Account: "+contact.getAccount().getName() );
				}
			}
		}catch(Exception error) { 
			error.printStackTrace();
		}
	}
	
	public static void createStudents() {
		System.out.println("Insert Students: ");
		try {
			Class__c[] listOfClasses = new Class__c[noOfClasses];
			
			for(Integer index = 0; index < noOfClasses; index++) {
				Class__c cls = new Class__c();
				cls.setName(className);
				
				listOfClasses[index] = cls;
			}
			
			SaveResult[] classResults = connection.create(listOfClasses);
			
			if( classResults.length > 0 ) {
				Student__c[] listOfStudents = new Student__c[noOfStudents];
				
				for(Integer index = 0; index < noOfStudents; index++) {
					Student__c student = new Student__c();
					
					student.setLast_Name__c(studentName);
					student.setClass__c(classResults[0].getId());
					
					listOfStudents[index] = student;
				}
				
				 SaveResult[] studentResults = connection.create(listOfStudents);
			 
				 for(Integer index = 0; index < studentResults.length; index++) {
					 if(studentResults[index].isSuccess()) {
						 System.out.println("Successfully Created Student Record : " +studentResults[index].getId() );
						 
					 }else {
						 Error[] errors = studentResults[index].getErrors();
						 
						 System.out.println("Error creating document: "+ errors );
					 }
				 }
			}
		}catch(Exception error) { 
			error.printStackTrace();
		}
	}
}
