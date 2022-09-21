/**
 * Created by scheck on 8/6/18.
 */

@IsTest
private class QuickQuoteTests {

    @IsTest(SeeAllData=true)
    static void testCreateQuote(){
        String startDate = '08/31/2020';
        Integer subTerm = 12;
        Id newQuoteId = ccQuickQuoteCtrl.createQuote(startDate, subTerm);
        List<SBQQ__Quote__c> thisQuote = [SELECT Id FROM SBQQ__Quote__c WHERE Id =: newQuoteId];
        System.assert(thisQuote.size()>0, 'Quote created!');

    }
}