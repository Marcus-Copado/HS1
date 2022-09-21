public class qtcBOMContoller {
    public List<Material__c> bom { get; set; }
    public String quoteID = ApexPages.currentPage().getParameters().get('qid');
    public SBQQ__Quote__c quote { get; set; }
    
    public qtcBOMContoller(){
        List<Material__c> fullBOM = new List<Material__c>();
        List<SBQQ__QuoteLine__c> QLs = [Select SBQQ__Product__c FROM SBQQ__QuoteLine__c Where SBQQ__Quote__c =: quoteID];
            system.debug(bom);
            for(SBQQ__QuoteLine__c QL : QLs){
                system.debug(QL);
                List<Material__c> Mats = [SELECT Id, Item__c, Name, Code__c, Product__r.Name, Inventory_Status__c,Site__c,Quantity__c FROM Material__c Where Product__c =: QL.SBQQ__Product__c];                
                system.debug(Mats);
                fullBOM.addAll(Mats);
            }
        this.bom=fullBOM;
        


         System.debug('BOM:' + bom); 
        quote = [select Name, SBQQ__Account__r.Name FROM SBQQ__Quote__c where Id =: quoteID];
    }
    
}