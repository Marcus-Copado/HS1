public class Q2CeditTiers {
    public Product2 Prod;
    public Approval_Threshold__c del;
    public List < Approval_Threshold__c > addThreshList { get; set; }
    public List < Approval_Threshold__c > delThreshList { get; set; }
    public List < Approval_Threshold__c > ThreshList { get; set; }
    public Integer totalCount { get; set; }
    public Integer rowIndex { get; set; }
    public List < Approval_Threshold__c > delThreshs { get; set; }

    public Q2CeditTiers(ApexPages.StandardController controller) {
        Prod = (Product2) controller.getRecord();
        ThreshList = [SELECT Id, Approval_Level__c, Lower_Bound_Percent__c, Product__c, Upper_Bound_Percent__c FROM Approval_Threshold__c WHERE Product__c = :Prod.Id];
        totalCount = ThreshList.size();
        delThreshList = new List < Approval_Threshold__c >();
        delThreshs = new List < Approval_Threshold__c >();
    }

    public void addRow() {
        addThreshList = new List < Approval_Threshold__c >();
        ThreshList.add(new Approval_Threshold__c(Product__c = Prod.Id));
    }

    public PageReference save() {
        upsert ThreshList;
        delete delThreshList;
        //return (new ApexPages.StandardController(Prod)).view();
        PageReference pageRef = new PageReference('/' + Prod.Id);
        pageRef.getParameters().put('id', Prod.Id);
        return pageRef;
    }
    public void deleteRow() {
        rowIndex = Integer.valueOf(ApexPages.currentPage().getParameters().get('rowIndex'));
        del = ThreshList.remove(rowIndex);
        delThreshList.add(del);
    }
}