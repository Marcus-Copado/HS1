public class qtcEinsteinAnalyzerController{
    public Id qLine {get;set;}
    public Id productId {get; set;}
    public boolean isDone {get; set;}
    public SBQQ__QuoteLine__c ql {get;set;}
    public Product2 productObj {get; set;}    
    public String getFg(){
        return null;
    }
    public Decimal lp {get; set;}
    public Decimal net {get; set;}
    public Decimal cp {get;set;}
    public Decimal uc {get;set;}
    public Decimal ssp {get;set;}
    public Decimal ntp {get;set;}
    public Decimal lev1 {get;set;}
    public Decimal lev2 {get;set;}
    public Decimal lev3 {get;set;}
    public String app {get;set;}


    
    public qtcEinsteinAnalyzerController(){
        this.isDone = false; //true will not display Analytics & standard should be false!
        try{
            qLine = ApexPages.currentPage().getParameters().get('Id');
        } catch(Exception e){
            this.isDone = true;
            //qLine = 'a0h3c00000bPDp0AAG';
            system.debug('Error caught, no value for qLine. qLine was not written into memory.');
        }
        //qLine = ApexPages.currentPage().getParameters().get('Id'); // ISSUE IS HERE.. null breaks every time
        //system.debug('qLine: ' + qLine);
        
        if (this.isDone == false) {
            system.debug('inside condition, this.isDone: ' + this.isDone);
            system.debug('qLine: ' + qLine);
        //String strId = Id.valueOf(qLine); // switch to compare value with string = ''

            ql = [SELECT Id, SBQQ__Product__c, SBQQ__ListPrice__c, SBQQ__Quote__r.SBQQ__Account__r.Name,
                        SBQQ__NetPrice__c, SBQQ__TotalDiscountRate__c, SBQQ__CustomerPrice__c, SBQQ__UnitCost__c, Standalone_Selling_Total_Price__c, Net_Term_Price__c, Threshold_1_Amount__c, Threshold_2_Amount__c, Threshold_3_Amount__c, Approval__c                                
                        FROM SBQQ__QuoteLine__c
                        WHERE Id =: qLine].get(0);
            system.debug('inside isDone condition, scripts are running');
            getProdId();
            getProdObj();
            lp = ql.SBQQ__ListPrice__c;
            net = ql.SBQQ__NetPrice__c;
            cp = ql.SBQQ__CustomerPrice__c;
            uc = ql.SBQQ__UnitCost__c;
            ssp = ql.Standalone_Selling_Total_Price__c;
            ntp = ql.Net_Term_Price__c;
            lev1 = ql.Threshold_1_Amount__c;
            lev2 = ql.Threshold_2_Amount__c;
            lev3 = ql.Threshold_3_Amount__c; 
            app = ql.Approval__c;
        }
    }

    public Id getProdId(){
        productId = [SELECT Id, Name, SBQQ__Product__c, SBQQ__ListPrice__c, 
                        SBQQ__NetPrice__c, SBQQ__UnitCost__c, SBQQ__CustomerPrice__c
                        FROM SBQQ__QuoteLine__c
                        WHERE Id =: qLine].get(0).SBQQ__Product__c;

        return productId;
    }


    public Product2 getProdObj(){
        productObj = [SELECT Id, Name FROM Product2 WHERE Id =: productId].get(0);

        return productObj;
    }

        
}