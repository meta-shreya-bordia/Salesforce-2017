global with sharing class EmailService implements Messaging.InboundEmailHandler {
    global Messaging.InboundEmailResult handleInboundEmail(
        Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {
        
        Messaging.InboundEmailResult result = new Messaging.InboundEmailResult();
        
        Messaging.InboundEmail.TextAttachment[] attachments = email.textAttachments;
        String XMLData = '';
        
        if (attachments != null) {
            for(Messaging.InboundEmail.TextAttachment attachment : attachments){
                if(attachment.filename.endsWith('.xml')){ 
                    XMLData = attachment.body;
                }
            }
        }
        
        XMLParser parsedResults = new XMLParser(XMLData);
        result.success = (parsedResults.listOfContactsToInsert !=null);
        return result;
    }
    
    public static void sendMail(String mailingAddress, String subject, String body) {
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        
        String[] toAddresses = new String[] {mailingAddress};
            
        mail.setToAddresses(toAddresses);
        mail.setSaveAsActivity(false);
        mail.setSubject(subject);
        mail.setPlainTextBody(body);
        
        Messaging.SendEmailResult[] results = Messaging.sendEmail(
            new Messaging.SingleEmailMessage[] { mail });
        
        inspectResults(results);
    }
    
    static Boolean inspectResults(Messaging.SendEmailResult[] results) {
        Boolean sendResult = true;
        
        for (Messaging.SendEmailResult mailSent : results) {
            if (mailSent.isSuccess()) {
                System.debug(EmailConstants.SUCCESS);
            }
            else {
                sendResult = false;
                System.debug(EmailConstants.ERROR + mailSent.getErrors());                 
            }
        }
        
        return sendResult;
    }
}