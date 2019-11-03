@isTest class ManageClassControllerTests {
    static final Integer noOfClasses = 2;
    static final String TEST_NAME = 'TEST';
    static final String TEST_UPDATE_NAME = 'Class';
    
    static ManageClassController getController(){
        return new ManageClassController();
    }
    
    static List<Class__c> getClasses(){
        return [
            SELECT Id, Name
            FROM Class__c
        ];
    }
    
    @testSetup static void setup() {
        List<Class__c> listOfClasses = new List<Class__c>();
        for(Integer index=0; index< noOfClasses; index++){
            Class__c cls = new Class__c(Name= TEST_NAME+index);
            listOfClasses.add(cls);
        }
        insert listOfClasses;
    }
    
    @isTest static void testSetClassObjectShouldRenderClassDetails(){
        ManageClassController controller = getController();
        controller.classId = getClasses()[0].Id;
        
        Test.startTest();
            controller.setClassObject();
        Test.stopTest();
        
        Boolean expected = true;
        Boolean actual = controller.toBeRendered;
        
        System.assertEquals(expected, actual, 'Should Render Class Details');
    }
    
    @isTest static void testGetClassesReturnsAllClassDetails(){
        ManageClassController controller = getController();
        
       	Test.startTest();
            List<Class__c> listOfClasses = controller.getClasses();
        Test.stopTest();
        
        Integer expected = noofClasses;
        Integer actual = listOfClasses.size();
        
        System.assertEquals(expected, actual, 'Should return class details of all classes');
    }
    
    @isTest static void testSaveShouldUpdateClassDetails(){
        ManageClassController controller = getController();
        List<Class__c> listOfClasses = getClasses();
        controller.classId = listOfClasses[0].Id;
        controller.setClassObject();
        controller.getClasses()[0].Name = TEST_UPDATE_NAME;
        
        Test.startTest();
            controller.save();
        Test.stopTest();
        
        String expected = TEST_UPDATE_NAME;
        String actual = controller.getClasses()[0].Name;
        
        System.assertEquals(expected, actual, 'Should update class name to '+TEST_UPDATE_NAME);
    }
    
    @isTest static void testHideShouldHideClassDetails(){
        ManageClassController controller = getController();
        controller.classId = getClasses()[0].Id;
        
        Test.startTest();
            controller.hide();
        Test.stopTest();
        
        Boolean expected = false;
        Boolean actual = controller.toBeRendered;
        
        System.assertEquals(expected, actual, 'Should render class details to be hidden');
    }
    
    @isTest
    static void testDeleteClassShouldDeleteSelectedClass(){
        ManageClassController controller = getController();
        controller.classId = getClasses()[0].Id;
        
        Test.startTest();
            controller.deleteClass();
        Test.stopTest();
        
        Integer expected = noOfClasses-1;
        Integer actual = controller.getClasses().size();
        
        System.assertEquals(expected, actual, 'Should delete selected class record');
    }    
}