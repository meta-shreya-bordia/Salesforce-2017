public class AttachmentDAO implements IAttachmentDAO {

    public interface IAttachmentDAO{
        List<Attachment> getAttachmentsByParentId(Id parentId);
    }
    
    public static List<Attachment> getAttachmentsByParentId(Id parentId){
        return [
            SELECT Id, Name, Body, ContentType 
            FROM Attachment
            WHERE Parentid = :parentId
        ];
    }
}