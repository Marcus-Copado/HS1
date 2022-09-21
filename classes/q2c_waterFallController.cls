public class q2c_waterFallController{
    public Id Acct {get; set;}
    public Id Quote {get; set;}
    public Date StartDate {get; set;}
    public Decimal ExistingMRR {get; set;}
    public Decimal NetNewMRR {get; set;}
    public Decimal ExpansionMRR {get; set;} 
    public Decimal ChurnMRR {get; set;}
    public Decimal EndingMRR {get; set;}
    public Decimal QuotedMRR {get; set;} 
    public Decimal SubMRR {get; set;}
    public Decimal UpliftMRR {get; set;}
    public Decimal ExpansionFromRamp {get; set;}
    public Decimal ExpansionFromAddon {get; set;}
    
    public q2c_waterFallController(){
        this.Acct = ApexPages.currentPage().getParameters().get('Account');
        this.Quote = ApexPages.currentPage().getParameters().get('Quote');
        this.StartDate = Date.valueof(ApexPages.currentPage().getParameters().get('StartDate'));

        getMRRData();
    }
    
    private void getMRRData(){
        Date EndDate=this.StartDate.addDays(-1);
        //EXISTING MRR
        List<SBQQ__Subscription__c> ExistingMRRSubscriptions = [SELECT SBQQ__Product__c, SBQQ__EndDate__c, SBQQ__StartDate__c, SBQQ__Quantity__c, SBQQ__ProrateMultiplier__c, SBQQ__QuoteLine__r.SBQQ__DefaultSubscriptionTerm__c, SBQQ__NetPrice__c FROM SBQQ__Subscription__c WHERE  SBQQ__Account__c = :this.Acct AND SBQQ__Contract__r.Status = 'Activated'];
        List<SBQQ__Subscription__c> RenewableSubscriptions = new List<SBQQ__Subscription__c>();
        List<SBQQ__Subscription__c> ActiveSubscriptions = new List<SBQQ__Subscription__c>();
        
        for(SBQQ__Subscription__c ExistSub:ExistingMRRSubscriptions){
            if((ExistSub.SBQQ__EndDate__c >= EndDate) && (ExistSub.SBQQ__StartDate__c <= EndDate)){
                RenewableSubscriptions.add(ExistSub);
            }if((ExistSub.SBQQ__EndDate__c >= this.StartDate) && (ExistSub.SBQQ__StartDate__c <= this.StartDate)){
                ActiveSubscriptions.add(ExistSub);
            }
        }
            
        Decimal ExistingMRRagg = 0;
        
        Decimal UpliftMRR = 0;
        for(SBQQ__Subscription__c ExistSub: ExistingMRRSubscriptions){
            if(ExistSub.SBQQ__StartDate__c<= EndDate && ExistSub.SBQQ__EndDate__c>= EndDate){
                ExistingMRRagg+= (ExistSub.SBQQ__Quantity__c*ExistSub.SBQQ__NetPrice__c/(ExistSub.SBQQ__ProrateMultiplier__c*ExistSub.SBQQ__QuoteLine__r.SBQQ__DefaultSubscriptionTerm__c));
            }
        }
        // NETNEW + Expansion
        List<SBQQ__QuoteLine__c> MRRQuoteLines = [SELECT SBQQ__Product__c, SBQQ__Quantity__c, SBQQ__EffectiveStartDate__c, SBQQ__ProrateMultiplier__c,SBQQ__DefaultSubscriptionTerm__c, SBQQ__NetTotal__c FROM SBQQ__QuoteLine__c WHERE SBQQ__Quote__c =:Quote AND SBQQ__DefaultSubscriptionTerm__c >0];        
        List<SBQQ__QuoteLine__c> StartMRRQuoteLines = new List<SBQQ__QuoteLine__c>();
        
        for(SBQQ__QuoteLine__c Ql: MRRQuoteLines){
            if(Ql.SBQQ__EffectiveStartDate__c == StartDate){
                StartMRRQuoteLines.add(Ql);
            }
        }
        
        Set<Id> setProds= new Set <Id>();
        List<Id> UniqueProdList = new List<Id>();
        for(SBQQ__QuoteLine__c QL :MRRQuoteLines){
            setProds.add(QL.SBQQ__Product__c);
        }
        UniqueProdList.addAll(setProds);

        Set<Id> setSubs= new Set <Id>();
        List<Id> UniqueSubList = new List<Id>();
        for(SBQQ__Subscription__c QL :ExistingMRRSubscriptions){
            setSubs.add(QL.SBQQ__Product__c);
        }
        UniqueSubList.addAll(setSubs);
        system.debug(UniqueProdList);
        system.debug(UniqueSubList);
        system.debug(StartDate);
        system.debug('debug');


      
        List<Id> LiveSubscriptions = New List<Id>();
        for (SBQQ__Subscription__c Sub : ExistingMRRSubscriptions){
            LiveSubscriptions.add(Sub.SBQQ__Product__c);
        }
        Decimal NetNewMRRagg = 0;      
        
        for(SBQQ__QuoteLine__c QL :MRRQuoteLines){
            if(!hasSub(QL.SBQQ__Product__c, LiveSubscriptions)){
                    NetNewMRRagg+=QL.SBQQ__NetTotal__c/(QL.SBQQ__ProrateMultiplier__c*QL.SBQQ__DefaultSubscriptionTerm__c);
            }
        }
        //ExpansionMRRagg = ExpansionFromRamp+ExpansionFromAddon
        Decimal ExpansionMRRagg = 0;
        Decimal ExpansionFromRamp = 0;
        Decimal ExpansionFromAddon = 0;
        //Map<Id, Decimal, Decimal> Product = new Map<Id, Decimal, Decimal>();
        //EXPANSION MRR we want the increase of currently held products.  two types of expansion MRR (add-on(quote start date < subscription end date) and ramp(quote startdate > subscription end date THIS ONE NEEDS TO BE COMPARED TO EXPIRING SUBSCRIPTION TOTALS))
            for(Id QuotedProd:UniqueProdList){
                Decimal QuotedMRR = 0;
                Decimal SubMRR = 0;
                Decimal QuotedQty = 0;
                Decimal SubQty = 0;

               for(SBQQ__QuoteLine__c QL : MRRQuoteLines ){//loop unique quoted product        
                    if(Ql.SBQQ__Product__c == QuotedProd && UniqueSubList.contains(QuotedProd)){
                        system.debug('Quoted MRR '+ QL.SBQQ__Product__c);
                        QuotedMRR +=QL.SBQQ__NetTotal__c/(QL.SBQQ__ProrateMultiplier__c*QL.SBQQ__DefaultSubscriptionTerm__c);
                        system.debug('Quoted MRR '+ QuotedMRR);
                        QuotedQty+=QL.SBQQ__Quantity__c;
                    }
               }
               for(SBQQ__Subscription__c Sub : ActiveSubscriptions){//loop unique quoted product   
                   
                    if(Sub.SBQQ__Product__c == QuotedProd){
                            system.debug('Quoted MRR '+ Sub.SBQQ__Product__c);
                        
                            QuotedMRR +=Sub.SBQQ__Quantity__c*Sub.SBQQ__NetPrice__c/(Sub.SBQQ__ProrateMultiplier__c*Sub.SBQQ__QuoteLine__r.SBQQ__DefaultSubscriptionTerm__c);
                            system.debug('Quoted MRR '+ SubMRR);
                            QuotedQty+=Sub.SBQQ__Quantity__c;
                       
                        }
                    }
               
               for(SBQQ__Subscription__c Sub : RenewableSubscriptions){//loop unique quoted product   
                   
                    if(Sub.SBQQ__Product__c == QuotedProd){
                        system.debug('Subbed MRR '+ Sub.SBQQ__Product__c);
                    
                        SubMRR +=Sub.SBQQ__Quantity__c*Sub.SBQQ__NetPrice__c/(Sub.SBQQ__ProrateMultiplier__c*Sub.SBQQ__QuoteLine__r.SBQQ__DefaultSubscriptionTerm__c);
                        system.debug('Subbed MRR '+ SubMRR);
                        SubQty+=Sub.SBQQ__Quantity__c;
                       
                    }
                }
                   
                    if(QuotedMRR>SubMRR && SubMRR>0){ 
                        ExpansionFromRamp+=QuotedMRR-SubMRR;
                        if((QuotedMRR/QuotedQty) > (SubMRR/SubQty)){
                            UpliftMRR+= ((QuotedMRR/QuotedQty) - (SubMRR/SubQty))*(SubQty);
                        }
                    }
            }
        ExpansionMRRagg=ExpansionFromRamp+ExpansionFromAddon-UpliftMRR;
        //ENDING MRR
        //We need to aggregagate this quote and all the subscriptions live at the startdate
        //
        Decimal EndingMRR=0;
        Decimal ChurnMRR=0;
        for(SBQQ__Subscription__c Sub : ActiveSubscriptions){
            EndingMRR+=Sub.SBQQ__Quantity__c*Sub.SBQQ__NetPrice__c/(Sub.SBQQ__ProrateMultiplier__c*Sub.SBQQ__QuoteLine__r.SBQQ__DefaultSubscriptionTerm__c);   
        }
        for(SBQQ__QuoteLine__c QL : StartMRRQuoteLines){
            EndingMRR+=QL.SBQQ__NetTotal__c/(QL.SBQQ__ProrateMultiplier__c*QL.SBQQ__DefaultSubscriptionTerm__c);
        }
        //CHURN MRR the difference        
        ChurnMRR= EndingMRR-(ExistingMRRagg+NetNewMRRagg+ExpansionMRRagg+UpliftMRR);
        system.debug('ENDINGMRR'+EndingMRR);
        system.debug('EX+NN+EXP'+(ExistingMRRagg+NetNewMRRagg+ExpansionMRRagg));
        system.debug('EXPANSION'+(ExpansionMRRagg));
               
                

            
        
        //ENDING MRR This is all MRR from this quote added to any live subscriptions at the start date
        this.QuotedMRR=QuotedMRR;
        this.SubMRR=SubMRR;
        this.ExpansionFromRamp=ExpansionFromRamp;
        this.ExpansionFromAddon=ExpansionFromAddon;
        
        this.UpliftMRR = Math.Round(UpliftMRR*100.00)/100.00;
        this.ExistingMRR = Math.Round(ExistingMRRagg*100.00)/100.00;
        this.NetNewMRR =Math.Round(NetNewMRRagg*100.00)/100.00;
        this.ExpansionMRR = Math.Round(ExpansionMRRagg*100.00)/100.00;
        this.ChurnMRR = Math.Round(ChurnMRR*100.00)/100.00;
        this.EndingMRR = Math.Round(EndingMRR*100.00)/100.00;
    }
    
    public boolean hasSub(Id qlProduct, List<Id> SubProdIds){
        for(Id QL : SubProdIds){
            if(qlProduct==QL){
                return true;
            }
        }
        return false;
    }
}