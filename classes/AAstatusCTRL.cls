public class AAstatusCTRL {

    @AuraEnabled // Annotation that makes the method available to Lightning Components
    public static List<sbaa__Approval__c> getCurrentUserApprovals() {
        return [SELECT Id, Quote__c, Quote__r.Name, Quote__r.Id, sbaa__Rule__r.Name, sbaa__Status__c, 
                       sbaa__Rule__c, sbaa__AssignedTo__c, Quote_Amount__c, Margin__c, Owner.Name,
                       Date_Requested__c, Quote__r.SBQQ__Opportunity2__r.CloseDate 
                FROM sbaa__Approval__c 
                WHERE sbaa__AssignedTo__c = :userInfo.getUserId() AND sbaa__Status__c = 'Assigned' 
               ];
    }
    
    @AuraEnabled
    public static void updateApprovalStatus(String Approval, String Status, String Comments) {
        sbaa__Approval__c thisApproval = [SELECT Id, sbaa__Status__c, sbaa__CommentsLong__c
                                          FROM sbaa__Approval__c
                                          WHERE Id = :Approval];
        thisApproval.sbaa__Status__c = Status;
        thisApproval.sbaa__CommentsLong__c = Comments;
        Database.update(thisApproval);
    }
    
    @AuraEnabled
    public static List<ListView> getListViews() {
    List<ListView> listviews = 
        [SELECT Id, Name FROM ListView WHERE SobjectType = 'sbaa__Approval__c' AND Name = 'My Approvals'];
    return listviews;
}
}