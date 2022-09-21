public class QTCProd {

    public Id prodid { get; set; }
    private ApexPages.StandardController Controller;

// This is an Extension Controller. Thus, we must invoke the standard controller.
    public QTCProd(ApexPages.StandardController controller) {
        this.prodid = controller.getId();
        this.Controller = controller;
    }

// Method for creating Quote 
    public PageReference deleteprod(){
        Id a = this.prodid;
        
        this.disableBillingTriggers();
        
        //Credit
        List<blng__CreditNoteLine__c> cnlinestodelete = [SELECT Id, blng__CreditNote__c FROM blng__CreditNoteLine__c Where Blng__Product__c=:a];
        Set<Id> cIds = new Set<Id>();
        for(blng__CreditNoteLine__c oi : cnlinestodelete){
            cIds.add(oi.blng__CreditNote__c);
        }
        List<blng__CreditNote__c> ctodelete = [SELECT Id FROM blng__CreditNote__c where Id IN :cIds ];
        delete ctodelete;
        
        //Debit
        List<blng__DebitNoteLine__c> dnlinestodelete = [SELECT Id, blng__DebitNote__c FROM blng__DebitNoteLine__c Where Blng__Product__c=:a];
        Set<Id> dIds = new Set<Id>();
        for(blng__DebitNoteLine__c oi : dnlinestodelete){
            dIds.add(oi.blng__DebitNote__c);
        }
        List<blng__DebitNote__c> dtodelete = [SELECT Id FROM blng__DebitNote__c where Id IN :dIds ];
        delete dtodelete;
        
        
        //Invoices
        List<blng__InvoiceLine__c> invoicelinestodelete = [SELECT Id, blng__Invoice__c FROM blng__InvoiceLine__c Where Blng__Product__c=:a];
        Set<Id> invIds = new Set<Id>();
        for(blng__InvoiceLine__c oi : invoicelinestodelete){
            invIds.add(oi.blng__Invoice__c);
        }
        list<blng__Invoice__c> invoicesToDelete = [SELECT Id, blng__InvoiceStatus__c FROM blng__Invoice__c WHERE Id IN :invIds];
        if (!invoicesToDelete.isEmpty()) {
            Set<Id> invoiceIds = new Set<Id>();
            blng__Invoice__c[] invoicesToUpdate = new List<blng__Invoice__c>();
            
            for (blng__Invoice__c invoice : invoicesToDelete) {
                invoiceIds.add(invoice.Id);
                if (invoice.blng__InvoiceStatus__c == 'Posted') {
                    blng.InvoiceAPI.creditInvoice(invoice.Id, 'Cancel and Re-bill');
                    invoicesToUpdate.add(invoice);
                }
            }
            if (!invoicesToUpdate.isEmpty()) {
                Database.update(invoicesToUpdate);
            }
            blng__InvoiceLine__c[] invoiceLines = getInvoiceLines(invoiceIds);
            if (!invoiceLines.isEmpty()) {
                this.deleteRevenueSchedules(invoiceLines);
            }
            Database.delete(invoicesToDelete);
        }

        
        //orders
        List<OrderItem> orderItemsToDelete = [SELECT Id, OrderId FROM OrderItem Where Product2Id=:a];
        Set<Id> ordsToDelete = new Set<Id>();
        for(OrderItem oi : orderItemsToDelete){
            ordsToDelete.add(oi.OrderId);
        }
        
        //Order Hard Part
        
        blng__BillingSchedule__c[] BS = [SELECT Id FROM blng__BillingSchedule__c WHERE blng__OrderProduct__r.Product2Id=:a];
        delete BS;
        Order[] ordersToDelete = [SELECT Id FROM Order WHERE Id IN :ordsToDelete];
        if (!ordersToDelete.isEmpty()) {
            Set<Id> orderIds = new Set<Id>();
            for (Order o : ordersToDelete) {
                orderIds.add(o.Id);
                //o.Status = 'Draft';
                o.SBQQ__Contracted__c = false;
            }
            update ordersToDelete;
            OrderItem[] orderItems = getOrderItems(orderIds);
            if (!orderItems.isEmpty()) {
                for (OrderItem oi : orderItems) {
                    oi.SBQQ__Contracted__c = false;
                }

                this.deleteRevenueSchedules(orderItems);
                this.deleteUsages(orderItems);
                this.deleteUsageSummaries(orderItems);
                Database.update(orderItems);
            }
            for (Order o : ordersToDelete) {
                orderIds.add(o.Id);
                o.Status = 'Draft';
                o.SBQQ__Contracted__c = false;
            }
            Database.update(ordersToDelete);
            Database.delete(ordersToDelete);
        }

        
        
        
        //quotes
        List<SBQQ__QuoteLine__c> qlsToDelete = [SELECT Id, SBQQ__Quote__c FROM SBQQ__QuoteLine__c Where SBQQ__Product__c=:a];
        Set<Id> qsToDelete = new Set<Id>();
        for(SBQQ__QuoteLine__c oi : qlsToDelete){
            qsToDelete.add(oi.SBQQ__Quote__c);
        }
        SBQQ__Quote__c[] quotesToDelete =[select Id from SBQQ__Quote__c where id IN :qsToDelete];
        if (!quotesToDelete.isEmpty()) {
            Set<Id> quoteIds = new Set<Id>();
            for (SBQQ__Quote__c q : quotesToDelete) {
                quoteIds.add(q.Id);
            }
            this.deleteProcessInputValues(quoteIds);
            Database.delete(quotesToDelete);
        }
        
        //Opportunities
            List<OpportunityLineItem> oppItemsToDelete = [SELECT Id, OpportunityId FROM OpportunityLineItem Where Product2Id=:a];
            Set<Id> oppsToDelete = new Set<Id>();
            for(OpportunityLineItem oi : oppItemsToDelete){
                oppsToDelete.add(oi.OpportunityId);
            }
        
            Opportunity[] opportinitiesToDelete = [SELECT Id FROM Opportunity Where Id IN: oppsToDelete];
            if (!opportinitiesToDelete.isEmpty()) {
                Database.delete(opportinitiesToDelete);
            }       
            //assets
            Asset[] assetsToDelete = [SELECT Id FROM Asset WHERE Product2Id = :a];
            if (!assetsToDelete.isEmpty()) {
                Database.delete(assetsToDelete);
            }
            //subscriptions/contracts
             SBQQ__Subscription__c[] subscriptionsToDelete = [SELECT Id FROM SBQQ__Subscription__c WHERE SBQQ__Product__c = :a];
                if (!subscriptionsToDelete.isEmpty()) {
                    Database.delete(subscriptionsToDelete);
                }
            //product
        product2[] deleteprod = [select id from product2 where id = :a];
        
        delete deleteprod;
        
        this.enableBillingTriggers();
        
        
        return this.Controller.view();
        
    }
     private static List<blng__InvoiceLine__c> getInvoiceLines(Set<Id> invoiceIds) {
        blng__InvoiceLine__c[] invoiceLines = [SELECT Id FROM blng__InvoiceLine__c WHERE blng__Invoice__c IN :invoiceIds];
        return invoiceLines;
    }
    private Boolean deleteRevenueSchedules(OrderItem[] orderItems) {
        if (!orderItems.isEmpty()) {
            Set<Id> orderItemIds = new Set<Id>();
            for (OrderItem oi : orderItems) {
                orderItemIds.add(oi.Id);
            }
            blng__RevenueSchedule__c[] revenueSchedulesToDelete = [SELECT Id FROM blng__RevenueSchedule__c WHERE blng__OrderProduct__c IN :orderItemIds];
            if (!revenueSchedulesToDelete.isEmpty()) {
                Database.delete(revenueSchedulesToDelete);
            }
        }

        System.debug('Total Number of SOQL Queries after deleteRevenueSchedules(): ' + Limits.getQueries());

        return true;
    }
      private Boolean deleteRevenueSchedules(blng__InvoiceLine__c[] invLines) {
        if (!invLines.isEmpty()) {
            Set<Id> invLineIds = new Set<Id>();
            for (blng__InvoiceLine__c line : invLines) {
                invLineIds.add(line.Id);
            }
            blng__RevenueSchedule__c[] revenueSchedulesToDelete = [SELECT Id FROM blng__RevenueSchedule__c WHERE blng__InvoiceLine__c IN :invLineIds];
            if (!revenueSchedulesToDelete.isEmpty()) {
                Database.delete(revenueSchedulesToDelete);
            }
        }

        System.debug('Total Number of SOQL Queries after deleteRevenueSchedules(): ' + Limits.getQueries());

        return true;
    }
    private Boolean deleteProcessInputValues(Set<Id> quotes) {
        SBQQ__ProcessInputValue__c[] valuesToDelete = [SELECT Id FROM SBQQ__ProcessInputValue__c WHERE SBQQ__QuoteId__c IN :quotes];
        if (!valuesToDelete.isEmpty()) {
            Database.delete(valuesToDelete);
        }

        System.debug('Total Number of SOQL Queries after deleteProcessInputValues(): ' + Limits.getQueries());

        return true;
    }
    private static List<OrderItem> getOrderItems(Set<Id> orderIds) {
        OrderItem[] orderItems = [SELECT Id FROM OrderItem WHERE OrderId IN :orderIds];
        return orderItems;
    }
        private Boolean deleteUsages(OrderItem[] orderItems) {
        if (!orderItems.isEmpty()) {
            Set<Id> orderItemIds = new Set<Id>();
            for (OrderItem oi : orderItems) {
                orderItemIds.add(oi.Id);
            }
            blng__Usage__c[] usagesToDelete = [SELECT Id FROM blng__Usage__c WHERE blng__OrderProduct__c IN :orderItemIds];
            if (!usagesToDelete.isEmpty()) {
                Database.delete(usagesToDelete);
            }
        }

        System.debug('Total Number of SOQL Queries after deleteUsages(): ' + Limits.getQueries());

        return true;
    }

    private Boolean deleteUsageSummaries(OrderItem[] orderItems) {
        if (!orderItems.isEmpty()) {
            Set<Id> orderItemIds = new Set<Id>();
            for (OrderItem oi : orderItems) {
                orderItemIds.add(oi.Id);
            }
            blng__UsageSummary__c[] usageSummariesToDelete = [SELECT Id FROM blng__UsageSummary__c WHERE blng__OrderProduct__c IN :orderItemIds];
            if (!usageSummariesToDelete.isEmpty()) {
                Database.delete(usageSummariesToDelete);
            }
        }

        System.debug('Total Number of SOQL Queries after deleteUsageSummaries(): ' + Limits.getQueries());

        return true;
    }
        private Boolean disableBillingTriggers() {
        blng__BillingConfig__c triggerConfig = [SELECT Id, Name, blng__BooleanValue__c FROM blng__BillingConfig__c WHERE Name = 'DISABLE_TRIGGERS'];
        triggerConfig.blng__BooleanValue__c = true;
        SObject s = (SObject) triggerConfig;
        Database.SaveResult sr = Database.updateImmediate(s);
        if (sr.isSuccess()) {
            System.debug('Successfully disabled Billing Triggers');
            return true;
        } else {
            for (Database.Error err : sr.getErrors()) {
                System.debug('The following error has occurred.');
                System.debug(err.getStatusCode() + ': ' + err.getMessage());
            }
            return false;
        }
    }

    private Boolean enableBillingTriggers() {
        blng__BillingConfig__c triggerConfig = [SELECT Id, Name, blng__BooleanValue__c FROM blng__BillingConfig__c WHERE Name = 'DISABLE_TRIGGERS'];
        triggerConfig.blng__BooleanValue__c = false;
        SObject s = (SObject) triggerConfig;
        Database.SaveResult sr = Database.updateImmediate(s);
        if (sr.isSuccess()) {
            System.debug('Successfully enabled Billing Triggers');
            return true;
        } else {
            for (Database.Error err : sr.getErrors()) {
                System.debug('The following error has occurred.');
                System.debug(err.getStatusCode() + ': ' + err.getMessage());
            }
            return false;
        }
    }
      
}