public class Q2CsendtoERP {
    public Id OrderId { get; set; }
    private ApexPages.StandardController Controller;
// This is an Extension Controller. Thus, we must invoke the standard controller.
    public Q2CsendtoERP(ApexPages.StandardController controller) {
        this.OrderId = controller.getId();
        this.Controller = controller;
    }

// Method for creating Quote 
    public PageReference sendtoERP() {
        Id a = this.OrderId;
        Order thisOrder = [SELECT blng__BillNow__c FROM Order WHERE Id = :a];
        thisOrder.ERP_Reference_ID__c = 'ER' + Math.floor((Math.random() * 10000000));
        update thisOrder;
        return this.Controller.view();
    }
}