public class ApprovalThresholdUtility {
    public static void updateProcessor(List<Approval_Threshold__c> ats) {
        List<Id> thresholdsBeingUpdated = new List<Id>();
        Map<Id, List<Approval_Threshold__c>> productToThresholdsMap = new Map<Id, List<Approval_Threshold__c>>();

        for (Approval_Threshold__c at : ats) {

        }
    }

    public static void insertProcessor(List<Approval_Threshold__c> ats) {

    }
}