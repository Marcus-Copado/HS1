public class AccountingPeriodModCtrl {
      
    @AuraEnabled  
	public static List <blng__FinancePeriod__c> getAccountingPeriods() {
    	return [SELECT Id, name, blng__FinanceBook__r.Name, blng__LegalEntity__r.Name , blng__PeriodType__c , blng__PeriodStartDate__c , blng__PeriodEndDate__c, blng__PeriodStatus__c FROM blng__FinancePeriod__c WHERE blng__PeriodType__c = 'Accounting' AND CurrencyIsoCode = 'USD' AND blng__PeriodStartDate__c > LAST_YEAR AND blng__LegalEntity__r.Name LIKE '%US%' ORDER BY blng__PeriodStartDate__c ASC LIMIT 12];
    }
    
    @AuraEnabled
    public static List <blng__FinancePeriod__c> getRevenuePeriods() {
        return [SELECT Id, name, blng__FinanceBook__r.Name, blng__LegalEntity__r.Name , blng__PeriodType__c , blng__PeriodStartDate__c , blng__PeriodEndDate__c, blng__PeriodStatus__c FROM blng__FinancePeriod__c WHERE blng__PeriodType__c = 'Revenue' AND CurrencyIsoCode = 'USD' AND blng__PeriodStartDate__c > LAST_YEAR AND blng__LegalEntity__r.Name LIKE '%US%' ORDER BY blng__PeriodStartDate__c ASC LIMIT 6];
    }
    
    @AuraEnabled
    public static List <blng__FinanceBook__c > getDemBooks() {
        return [SELECT Id, name, blng__PeriodType__c FROM blng__FinanceBook__c WHERE blng__Active__c  = true ORDER BY blng__PeriodType__c DESC];
    }
    
    @AuraEnabled
    public static List <blng__LegalEntity__c> getDemEntities() {
        return [SELECT Id, Name, blng__LegalEntityNumber__c, blng__Street1__c, blng__City__c, blng__County__c, blng__State__c, blng__Country__c, blng__ZipPostalCode__c FROM blng__LegalEntity__c WHERE blng__Active__c  = true];
    }
    
}