public class qtcBuildBOM {

    public Id Pid { get; set; }
    public List<Material__c> bom{ get; set; }
    public Integer Mats { get; set; }
    
    private ApexPages.StandardController Controller;

// This is an Extension Controller. Thus, we must invoke the standard controller.
    public qtcBuildBOM(ApexPages.StandardController controller) {
        this.Pid = controller.getId();
        this.Controller = controller;
        this.bom = [SELECT  Item__c, Name, Code__c, Quantity__c, Inventory_Status__c, Site__c FROM Material__c WHERE Product__c=:this.Pid Order By Item__c ASC];
    }

// Method for creating Quote 
    public PageReference BOM() {
        Id a = this.Pid;
        List<Material__c> Materialstodelete = [SELECT Id, Name, Code__c, Quantity__c, Inventory_Status__c, Site__c FROM Material__c WHERE Product__c=:a];
       
        delete Materialstodelete;
        Product2 Prod = [SELECT Name, ProductCode from Product2 where Id =: Pid];
        List<Material__c> Materials = new List<Material__c>();
        String Code;
         if(Prod.ProductCode==null || Prod.ProductCode==''){
                Code = 'PN-';
            }else{
                
                Code = Prod.ProductCode+'-';
            }
        for(Integer i = 1; i<this.Mats+1; i++){  
        Materials.add(new Material__c(
            Item__c= i,
            Product__c= a,
            Name = Prod.Name + ' Component '+i,
            Code__c= Code+i,
            Quantity__c= Math.Random() *100,
            Inventory_Status__c= 'Available',
            Site__c= 'Columbus'
            ));
        }

        insert Materials;
        this.bom = [SELECT Item__c, Name, Code__c, Quantity__c, Inventory_Status__c, Site__c FROM Material__c WHERE Product__c=:this.Pid Order By Item__c ASC];

        return null;
    }
    public PageReference clearBOM() {
        Id a = this.Pid;
        List<Material__c> Materials = [SELECT Item__c, Name, Code__c, Quantity__c, Inventory_Status__c, Site__c FROM Material__c WHERE Product__c=:a];
       
        delete Materials;
        this.bom = [SELECT Item__c, Name, Code__c, Quantity__c, Inventory_Status__c, Site__c FROM Material__c WHERE Product__c=:this.Pid Order By Item__c ASC];

        return null;
    }
    public PageReference CloseRedirect(){
           Id a = this.Pid;

        return New PageReference('/'+a);
    }  
}