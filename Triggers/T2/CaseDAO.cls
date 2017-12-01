public class CaseDAO implements ICaseDAO {
    
    public interface ICaseDAO{
        List<Case> getCases(String searchIn, String searchParameter);
        Case getCaseById(String caseId);
        List<Case> getCaseById(Set<Id> setOfCaseIds, String statusClosed);
    }
    
    public static List<Case> getCases(String searchIn, String searchParameter){
        return Database.query(
            'SELECT Id, CaseNumber '+
            'FROM Case '+
            'WHERE '+ searchIn + '= \''+ searchParameter + '\''
        );
    }
    
    public static Case getCaseById(Id caseId){
        return [
            SELECT CaseNumber, Subject, Status, Origin, Priority
            FROM Case
            WHERE Id = :caseId
        ];
    }
    
    public static List<Case> getCaseById(Set<Id> setOfCaseIds, String statusClosed){
        return [
            SELECT Id, Status, Reason
            FROM Case
            WHERE Id IN :setOfCaseIds
            AND Status != :statusClosed
        ];
    }
}