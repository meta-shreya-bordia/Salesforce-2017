public class XMLParser {
   public List<Contact> listOfContactsToInsert;
   Contact contact;
   
   public XMLParser(String XMLString){
       listOfContactsToInsert = new List<Contact>();
       
       DOM.Document document = new DOM.Document();
       try {
           document.load(XMLString);
           DOM.XmlNode rootNode = document.getRootElement();
           parseXML(rootNode);
           listOfContactsToInsert.add(contact);
           insert listOfContactsToInsert;
       }catch(Exception errors){
           System.debug( ContactConstants.ERROR_PARSING_DOCUMENT + errors);
       }
   }
   
   void parseXML(DOM.XMLNode node) {
       if(node.getNodeType() == DOM.XMLNodeType.ELEMENT){
           if( ContactConstants.CONTACT == node.getName() ) {
               if( contact != null) {
                   listOfContactsToInsert.add(contact);
               }
               contact = new Contact();
           }
           if(ContactConstants.FIRST_NAME == node.getName()){
               contact.FirstName = node.getText().trim();
           }
           if(ContactConstants.LAST_NAME == node.getName()){
               contact.LastName = node.getText().trim();
           }
           if(ContactConstants.SUBJECTS == node.getName()){
               contact.Subjects__c = node.getText().trim();
           }
           if(ContactConstants.Department == node.getName()){
               contact.Department = node.getText().trim();
           }
           if(ContactConstants.Email == node.getName()){
               contact.Email = node.getText().trim();
           }    
       }
               
       for (Dom.XMLNode child : node.getChildElements()) {
           parseXML(child);
       }
   }
}
