public class AAstatuscardCTRL {

    @AuraEnabled
    public static void updateApprovalStatus(String Approval, String Status, String Comments) {
        sbaa__Approval__c thisApproval = [SELECT Id, sbaa__Status__c, sbaa__CommentsLong__c
                                          FROM sbaa__Approval__c
                                          WHERE Id = :Approval];
        thisApproval.sbaa__Status__c = Status;
        thisApproval.sbaa__CommentsLong__c = Comments;
        Database.update(thisApproval);
    }
}