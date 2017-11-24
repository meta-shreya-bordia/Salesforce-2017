public class ObjectListController {
    public String queryObject{get; set;}
    public Integer size {get; set;}
    public String sortOrder {get; set;}
    public Integer jumpToPage {get; set;}
        
    public List<String> listOfFieldNames {
        get{
            if(listOfFieldNames == null || listOfFieldNames.size() == 0){
                listOfFieldNames = new List<String>(
	            	Schema.getGlobalDescribe().get(queryObject).getDescribe()
                    .fields.getMap().keySet() );
            }
            
            return listOfFieldNames;
        }
        set;
    }
    
   	private String fieldsString {
        get {
            if( fieldsString == '' ){
                for(String field :listOfFieldNames){
            		fieldsString += field+',';
	        	}
            	fieldsString = fieldsString.removeEnd(',');
        	}
            
        	return fieldsString;    
        }
        set;
    }

    public ObjectListController(){
    	fieldsString = '';
        sortOrder = '';
        size = 10;
    }
    
    public List<sObject> getObjectList(){ 
        return (List<sObject>) controller.getRecords();
    }
    
    public List<String> getFieldNames(){
        return listOfFieldNames;
    }
    
    public ApexPages.StandardSetController controller {
       get {
           if(controller == null) {
               controller = new ApexPages.StandardSetController(
					sObjectDAO.getObjects(fieldsString, queryObject));
               controller.setPageSize(size);  
           }         
           return controller;
       }
       set;
   	}
    
    public void sorting(){
       controller = new ApexPages.StandardSetController(
           sObjectDAO.getObjects(fieldsString, queryObject, sortOrder));
    } 
    
    public void goToPage(){
        if(jumpToPage > 0 && jumpToPage <= (controller.getResultSize()/controller.getPageSize()+1 )){
            controller.setPageNumber(jumpToPage);
        }
    }
}