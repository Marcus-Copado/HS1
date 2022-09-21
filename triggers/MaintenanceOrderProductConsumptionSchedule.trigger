trigger MaintenanceOrderProductConsumptionSchedule on SBQQ__OrderItemConsumptionSchedule__c (before insert) {
    Id defaultEntity = [SELECT Id From blng__LegalEntity__c Where Name = 'Corporate - US' Limit 1].Id;
    
    Id defaultTaxTreatment = [SELECT Id From blng__TaxTreatment__c Where blng__TaxLegalEntity__c =:DefaultEntity Limit 1].Id;
    for(SBQQ__OrderItemConsumptionSchedule__c OIC : trigger.new){
        system.debug(OIC);
        Id pid =[SELECT Product2Id FROM OrderItem WHERE Id=:OIC.SBQQ__OrderItem__c limit 1].Product2Id;
        Product2 ThisProd = [Select blng__TaxRule__c,blng__RevenueRecognitionRule__c,blng__BillingRule__c From Product2 WHERE Id=:pid Limit 1];
        system.debug(ThisProd);
        //OIC.blng__BillingRule__c=ThisProd.blng__BillingRule__c;
        OIC.blng__LegalEntity__c=defaultEntity;
        //OIC.blng__RevenueRecognitionRule__c=ThisProd.blng__RevenueRecognitionRule__c;
        //OIC.blng__TaxRule__c=ThisProd.blng__TaxRule__c;
    }
}