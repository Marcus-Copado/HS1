trigger beforeConsumptionSchedule on ConsumptionSchedule (before insert) {

        Id DefaultBilling = [SELECT Id FROM blng__BillingRule__c WHERE Name = 'Invoice w/ Special Treatment' LIMIT 1].Id;
        Id DefaultRevRec = [SELECT Id FROM blng__RevenueRecognitionRule__c WHERE Name = 'Order Based 50% Full - Ratable Split - 50%' LIMIT 1].Id;
        Id DefaultTax = [SELECT Id FROM blng__TaxRule__c WHERE Name = 'Standard Tax Rule' LIMIT 1].Id;
    for(ConsumptionSchedule C : trigger.new){
         if (C.blng__BillingRule__c == null) {
                C.blng__BillingRule__c = DefaultBilling;
            }
            if (C.blng__RevenueRecognitionRule__c == null) {
                C.blng__RevenueRecognitionRule__c = DefaultRevRec;
            }
            if (C.blng__TaxRule__c == null) {
                C.blng__TaxRule__c = DefaultTax;
            }
    
    }
}