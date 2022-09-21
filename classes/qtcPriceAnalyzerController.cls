public class qtcPriceAnalyzerController{
    public Id productId {get; set;}
    public Product2 productObj {get; set;}
    public Decimal param1 {get; set;}
    public Decimal param2 {get; set;}
    public Decimal high {get; set;}
    public Decimal avg {get; set;}
    public Decimal low {get; set;}
    
    public qtcPriceAnalyzerController(){
        this.param1 = Decimal.valueOf(ApexPages.currentPage().getParameters().get('SBQQ__Quantity__c'));
        this.param2 = Decimal.valueOf(ApexPages.currentPage().getParameters().get('SBQQ__NetPrice__c'));
        this.productId = ApexPages.currentPage().getParameters().get('SBQQ__Product_c');
        this.productObj = [SELECT Name FROM Product2 WHERE Id = :this.productId];
        getPricePoints();
    }
    
    private void getPricePoints(){
        AggregateResult[] res = [SELECT AVG(SBQQ__NetPrice__c), MAX(SBQQ__NetPrice__c), MIN(SBQQ__NetPrice__c) FROM SBQQ__QuoteLine__c WHERE SBQQ__Product__c = :this.productId AND SBQQ__Quote__r.SBQQ__Primary__c = true AND SBQQ__Quote__r.SBQQ__Opportunity2__r.CloseDate <= TODAY and SBQQ__Quote__r.SBQQ__Opportunity2__r.IsWon = TRUE];
        this.avg = (Decimal)res[0].get('expr0');
        this.high = (Decimal)res[0].get('expr1');
        this.low = (Decimal)res[0].get('expr2');
    }
}