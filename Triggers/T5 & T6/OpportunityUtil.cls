public class OpportunityUtil {
    public static Boolean checkStageName(Opportunity opportunity, String searchPattern){
        if( opportunity.StageName == searchPattern )
            return true;
        return false;
    }
}