// tsaarnio 2-13-2020
// billing automation trigger v1.0 will help set fields: legal entity(from account), finance book for accounting(from account), billing treatments, billing gl rules, and billing gl treatments

trigger Billing_Automation_v1_0 on OrderItem (before insert) {
    boolean debug = true;
    
    for(OrderItem Oitem : trigger.new){
        // Set Billing Account
        Id defaultAcc = [SELECT AccountId From Order Where Id =: Oitem.OrderId Limit 1].AccountId;
        if(debug){system.debug('*** New Order Item ***');}
        Oitem.blng__BillingAccount__c = defaultAcc;
        if(debug){system.debug('Billing Account::::::::::::::' + defaultAcc);}
        
/* Legal Entity & Finance Book */        
        // Set Legal Entity
        Id defaultEntity = [SELECT Id From blng__LegalEntity__c Where blng__Active__c = true Limit 1].Id;
        List <Account> accLE = [SELECT Legal_Entity__c From Account Where Id =: defaultAcc Limit 1];
        if(accLE[0].Legal_Entity__c != null){ 
            defaultEntity = accLE[0].Legal_Entity__c;
        }
        Oitem.blng__LegalEntity__c = defaultEntity;
        if(debug){system.debug('Account Legal Entity::::::::::::::' + defaultEntity);}
     
        // Set Accounting Finance Book
        Id defaultFBook = [SELECT Accounting_Finance_Book__c From Account Where Id =: defaultAcc Limit 1].Accounting_Finance_Book__c;
        Id backUpFBook = [SELECT Id,Name From blng__FinanceBook__c Where blng__PeriodType__c = 'Accounting' AND Default__c = True Limit 1].Id;
        if(defaultFBook != null){
            Oitem.blng__FinanceBookAccounting__c = defaultFBook;
        }else{
            Oitem.blng__FinanceBookAccounting__c = backUpFBook;  
        }
        if(debug){system.debug('Account Finance Book::::::::::::::' + defaultFBook);}
        if(debug){system.debug('Backup Finance Book::::::::::::::' + backUpFBook);}

        
/* Billing */
        // Set Billing Treatment
        Id bTreat = [SELECT Id From blng__BillingTreatment__c Where blng__BillingLegalEntity__c =: defaultEntity AND blng__BillingRule__c =: Oitem.blng__BillingRule__c LIMIT 1].Id;
        Oitem.blng__BillingTreatment__c = bTreat; 
        if(debug){system.debug('Billing Treatment ID::::::::::::::' + bTreat);}
        
        // Set Billing GL Rule
        Id bGLRule = [SELECT blng__BillingGLRule__c From blng__BillingTreatment__c Where Id =: bTreat LIMIT 1].blng__BillingGLRule__c;
        Oitem.blng__BillingGLRule__c  = bGLRule;
        if(debug){system.debug('Billing GL Rule ID::::::::::::::' + bGLRule);  } 
        
        // Set Billing GL Treatment
        Id bGLTreat = [SELECT Id From blng__GLTreatment__c Where blng__GLLegalEntity__c =: defaultEntity AND blng__GLRule__c  =: Oitem.blng__BillingGLRule__c LIMIT 1].Id;
        Oitem.blng__BillingGLTreatment__c   = bGLTreat;
        if(debug){system.debug('Billing GL Treatment ID::::::::::::::' + bGLTreat);}
    
        
/* Tax */
        // Set Tax Treatment
        Id tTreat = [SELECT Id From blng__TaxTreatment__c Where blng__TaxLegalEntity__c =: defaultEntity AND blng__TaxRule__c =: Oitem.blng__TaxRule__c LIMIT 1].Id;
        Oitem.blng__TaxTreatment__c = tTreat; 
        if(debug){system.debug('Tax Treatment ID::::::::::::::' + tTreat);}
        
        // Set Tax GL Rule
        Id tGLRule = [SELECT blng__TaxGLRule__c From blng__TaxTreatment__c  Where Id =: tTreat LIMIT 1].blng__TaxGLRule__c;
        Oitem.blng__TaxGLRule__c  = tGLRule;
        if(debug){system.debug('Tax GL Rule ID::::::::::::::' + tGLRule); }
        
        // Set Tax GL Treatment
        Id tGLTreat = [SELECT Id From blng__GLTreatment__c Where blng__GLLegalEntity__c =: defaultEntity AND blng__GLRule__c  =: Oitem.blng__TaxGLRule__c LIMIT 1].Id;
        Oitem.blng__TaxGLTreatment__c    = tGLTreat;
        if(debug){system.debug('Billing GL Treatment ID::::::::::::::' + tGLTreat);}
        
    }
}