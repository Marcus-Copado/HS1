public class Q2CContractsController {
    
    @AuraEnabled
    public static List<Contract> getContracts() {
        ID contactId = [Select contactid from User where id =: Userinfo.getUserid()].contactId;
        ID AccID  = [Select AccountID from Contact where id =: contactId].AccountId;  
        return [SELECT Id, AccountId, ContractNumber, Status, StartDate, EndDate, ContractTerm FROM Contract WHERE AccountId =: AccID ORDER BY ContractNumber ASC];
    }

    @AuraEnabled
    public static List<SBQQ__Subscription__c> getSubs() {
        ID contactId = [Select contactid from User where id =: Userinfo.getUserid()].contactId;
        ID AccID  = [Select AccountID from Contact where id =: contactId].AccountId; 
        return [SELECT Id, SBQQ__Contract__c, SBQQ__Account__c, SBQQ__ContractNumber__c, Name, SBQQ__StartDate__c, SBQQ__EndDate__c, SBQQ__ProductName__c, SBQQ__NetPrice__c, SBQQ__Quantity__c FROM SBQQ__Subscription__c WHERE SBQQ__Account__c =: AccID ORDER BY SBQQ__ContractNumber__c ASC LIMIT 10];
    }
    
     @AuraEnabled
    public static List<blng__Invoice__c> getInvoices() {
        ID contactId = [Select contactid from User where id =: Userinfo.getUserid()].contactId;
        ID AccID  = [Select AccountID from Contact where id =: contactId].AccountId; 
        return [SELECT Id, Name, blng__Account__c, blng__Account__r.Name, blng__Order__c, blng__Order__r.OrderNumber , blng__InvoiceStatus__c, blng__PaymentStatus__c, blng__TotalAmount__c, blng__Balance__c, blng__InvoiceDate__c, blng__DueDate__c, blng__StatusFlag__c  FROM blng__Invoice__c WHERE blng__Account__c =: AccID ORDER BY blng__Order__r.OrderNumber ASC];
    }
    
    @AuraEnabled
    public static Id fireAmend(String contractId) {
        System.debug('inside fireAmend');
        System.debug(contractId);
        
        String quoteModelJSON = SBQQ.ServiceRouter.load('SBQQ.ContractManipulationAPI.ContractAmender', contractId, null);
        QuoteModel qModel = (QuoteModel)JSON.deserialize(quoteModelJSON, QuoteModel.class);
        System.debug(qModel);
        System.debug(qModel.record.id);
        SBQQ__Quote__c quote = [SELECT Id, SBQQ__StartDate__c, SBQQ__Account__c, SBQQ__Opportunity2__c FROM SBQQ__Quote__c where Id =: qModel.record.id];
        return quote.id;
        
    }
    
}