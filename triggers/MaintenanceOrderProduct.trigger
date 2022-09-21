trigger MaintenanceOrderProduct on OrderItem (before insert) {
    Id defaultEntity = [SELECT Id From blng__LegalEntity__c Where Name = 'Corporate - US' Limit 1].Id;
    Id defaultTaxTreatment = [SELECT Id From blng__TaxTreatment__c Where blng__TaxCode__c = 'A234' AND blng__Active__c = True and Name = 'Avalara - US'].Id; 
    //Tax Treatments: Avalara - a2R3c000000KZcV, Standard(US) - a2R3c000000KZcW, Standard(UK) - a2R3c000000KZcX
    
    for(OrderItem Oitem : trigger.new){
        Oitem.blng__LegalEntity__c=defaultEntity;
        Oitem.blng__TaxTreatment__c=defaultTaxTreatment;
        Oitem.SBQQ__TaxCode__c='A234';
        //Oitem.blng__InvoiceGrouping__c = 'Contract Number';
        //Oitem.blng__InvoiceGrouping__c = 'Order';
        system.debug(Oitem);
        
        String Country = [SELECT SBQQ__Quote__r.SBQQ__Account__r.BillingCountry From SBQQ__QuoteLine__c WHERE Id =:Oitem.SBQQ__QuoteLine__c].SBQQ__Quote__r.SBQQ__Account__r.BillingCountry;
        if(Country=='United Kingdom' || Country == 'UK'){
            Oitem.blng__LegalEntity__c='a203c000004H4kd';
        }
        /**
        if(Oitem.SBQQ__SubscriptionType__c == 'Evergreen'){
            Id Prod = [SELECT SBQQ__Product__c FROM SBQQ__QuoteLine__c WHERE Id = :Oitem.SBQQ__QuoteLine__c LIMIT 1].SBQQ__Product__c;
            Id BillingRule = [SELECT blng__BillingRule__c FROM Product2 Where Id =:Prod limit 1].blng__BillingRule__c;
            oitem.blng__BillingTreatment__c = [SELECT Id FROM blng__BillingTreatment__c WHERE blng__BillingRule__c =:BillingRule AND blng__BillingLegalEntity__c =: defaultEntity limit 1].Id;
        }
        **/
        if(Oitem.blng__BillingRule__c != null && Oitem.blng__LegalEntity__c != null){
            if(Oitem.blng__LegalEntity__c == 'a203c000004H4kc'){//US LEGAL ENTITY
                if(Oitem.blng__BillingRule__c == 'a1H3c0000058IHr' ){// invoice plan
                    Oitem.blng__BillingTreatment__c='a1K3c00000Df3va';
                }
                else if(Oitem.blng__BillingRule__c == 'a1H3c0000058IHq' ){// evergreen
                    Oitem.blng__BillingTreatment__c='a1K3c00000Df3vh';
                }
                else if(Oitem.blng__BillingRule__c == 'a1H3c0000058IHn' ){// sales
                    Oitem.blng__BillingTreatment__c='a1K3c00000Df3vd';
                }
                else if(Oitem.blng__BillingRule__c == 'a1H3c0000058IHo' ){// service
                    Oitem.blng__BillingTreatment__c='a1K3c00000Df3vb';
                }
                else if(Oitem.blng__BillingRule__c == 'a1H3c0000058IHp' ){// subscription
                    Oitem.blng__BillingTreatment__c='a1K3c00000Df3vf';
                }
                Oitem.blng__TaxRule__c ='a2Q3c000003bUh1';
                Oitem.blng__TaxTreatment__c = 'a2R3c000000KZcV';
                Oitem.blng__FinanceBookAccounting__c = 'a1U3c000009p5GY';
                Oitem.blng__BillingGLRule__c = 'a1X3c00000ItOKn';
                Oitem.blng__TaxGLRule__c = 'a1X3c00000ItOKo';
                Oitem.blng__BillingGLTreatment__c = 'a1Y3c0000024WHC';
                Oitem.blng__TaxGLTreatment__c= 'a1Y3c0000024WHD';
            }  
            if(Oitem.blng__LegalEntity__c == 'a203c000004H4kd'){//UK LEGAL ENTITY
                if(Oitem.blng__BillingRule__c == 'a1H3c0000058IHr' ){// invoice plan
                    Oitem.blng__BillingTreatment__c='a1K3c00000Df3vj';
                }
                else if(Oitem.blng__BillingRule__c == 'a1H3c0000058IHq' ){// evergreen
                    Oitem.blng__BillingTreatment__c='a1K3c00000Df3vi';
                }
                else if(Oitem.blng__BillingRule__c == 'a1H3c0000058IHn' ){// sales
                    Oitem.blng__BillingTreatment__c='a1K3c00000Df3ve';
                }
                else if(Oitem.blng__BillingRule__c == 'a1H3c0000058IHo' ){// service
                    Oitem.blng__BillingTreatment__c='a1K3c00000Df3vc';
                }
                else if(Oitem.blng__BillingRule__c == 'a1H3c0000058IHp' ){// subscription
                    Oitem.blng__BillingTreatment__c='a1K3c00000Df3vg';
                }
                Oitem.blng__TaxRule__c ='a2Q3c000003bUh1';
                Oitem.blng__TaxTreatment__c = 'a2R3c000000KZcX';
                Oitem.blng__FinanceBookAccounting__c = 'a1U3c000009p5GZ';
                Oitem.blng__BillingGLRule__c = 'a1X3c00000ItOKn';
                Oitem.blng__TaxGLRule__c = 'a1X3c00000ItOKo';
                Oitem.blng__BillingGLTreatment__c = 'a1Y3c0000024WHE';
                Oitem.blng__TaxGLTreatment__c= 'a1Y3c0000024WHF';
            }  
            
        }
    }
}