public class StudentFormExtension {
   public Student__c student {get; set;}
   
   public StudentFormExtension(ApexPages.StandardController pdfController){
       student = (Student__c)pdfController.getRecord();
   }
   
   public PageReference attach() {
       List<Attachment> listOfAttachments = 
           AttachmentDAO.getAttachmentsByParentId(student.Id);
       
       Attachment attachmentToDelete = new Attachment();
       Attachment addAttachment = new Attachment();
       
       addAttachment.ParentId = student.Id;
       addAttachment.name = student.Id+'-StudentDetails.pdf';
       
       PageReference addPdf = Page.StudentForm;
       addPdf.getParameters().put('id',student.Id);
       
       Blob body;
       try{
           body = addPdf.getContentAsPDF();
       }catch(VisualforceException vfe) {
           body = Blob.valueOf('Error :'+vfe);
       }
       
       addAttachment.body = body;
       for(Attachment attachment: listOfAttachments) {
           if((attachment.Name).equals( student.Id+'-StudentDetails.pdf')){
               delete attachment;
               break;
           }
       }
       
       insert addAttachment;
       return new PageReference('/'+student.Id );
   }
}