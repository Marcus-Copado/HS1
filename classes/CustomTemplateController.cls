public class CustomTemplateController{
	public string quoteId {get; set;}
	public string templateId {get; set;}
	public SBQQ__Quote__c quote {get; set;}
	public List<SBQQ__QuoteLine__c> lines {get; set;}
    public List<SBQQ__QuoteLineGroup__c> groups {get; set;}
    public List<SBQQ__QuoteLineConsumptionSchedule__c> linesWithConsumptionSchedules {get; set;}
    public List<SBQQ__QuoteLineConsumptionRate__c> consumptionRates {get; set;}
    public List<SBQQ__QuoteLineConsumptionRate__c> consumptionOverageRates {get; set;}
    public List<Id> lineIDsWithCS {get; set;}
    public SBQQ__QuoteTemplate__c template {get;set;}
    //public Map<Id, List<SBQQ__QuoteLineConsumptionRate__c>> quoteLineRates {get;set;}
    //public Map<Id, List<SBQQ__QuoteLineConsumptionRate__c>> quoteLineOverageRates {get;set;}
    public boolean showConsumptionSchedule {get;set;}
	

	public CustomTemplateController(){
		quoteId = ApexPages.currentPage().getParameters().get('qid');
		templateId = ApexPages.currentPage().getParameters().get('tid');
        lineIDsWithCS = new List<Id>{};
        consumptionRates = new List<SBQQ__QuoteLineConsumptionRate__c>{};
        consumptionOverageRates = new List<SBQQ__QuoteLineConsumptionRate__c>{};
        showConsumptionSchedule = false;
        //quoteLineRates = new Map<Id, List<SBQQ__QuoteLineConsumptionRate__c>>{};
        //quoteLineOverageRates = new Map<Id, List<SBQQ__QuoteLineConsumptionRate__c>>{};
        system.debug(quoteId);
        system.debug(templateId);
		this.populateQuote();
        //system.debug(this);
		this.populateLineData();
        
        this.populateGroupData();
        //system.debug(this);
		this.populateCSData();
        system.debug(this);
        
        
	}

	public void populateQuote(){
		quote = [SELECT Id, SBQQ__LineItemsGrouped__c, SBQQ__NetAmount__c, SBQQ__BillingName__c, SBQQ__StartDate__c, SBQQ__BillingStreet__c, SBQQ__BillingCity__c, SBQQ__BillingState__c, SBQQ__BillingPostalCode__c, SBQQ__ShippingName__c, SBQQ__ShippingStreet__c, SBQQ__ShippingCity__c, SBQQ__ShippingState__c, SBQQ__ShippingPostalCode__c, SBQQ__SalesRep__r.Name, SBQQ__SalesRep__r.Phone, SBQQ__SalesRep__r.Email, SBQQ__Account__c, SBQQ__Account__r.Name, SBQQ__Account__r.ShippingAddress, SBQQ__Account__r.BillingStreet, SBQQ__Account__r.BillingCity, SBQQ__Account__r.BillingState, SBQQ__Account__r.BillingCountry, SBQQ__Account__r.BillingPostalCode, SBQQ__PrimaryContact__r.FirstName, SBQQ__PrimaryContact__r.LastName, SBQQ__PrimaryContact__r.Phone, SBQQ__PrimaryContact__r.Email FROM SBQQ__Quote__c WHERE Id = :quoteId];    
		template = [SELECT Id, SBQQ__BillToTitle__c, SBQQ__BorderColor__c, SBQQ__BottomMargin__c, SBQQ__CompanyCity__c, SBQQ__CompanyCountry__c, SBQQ__CompanyEmail__c, SBQQ__CompanyFax__c, Company_Image_Height__c, Company_Image_URL__c, Company_Image_Width__c, SBQQ__CompanyName__c, SBQQ__CompanyPhone__c, SBQQ__CompanyPostalCode__c, Company_Primary_Color__c, SBQQ__CompanySlogan__c, SBQQ__CompanyState__c, SBQQ__CompanyStreet__c, CreatedById, CreatedDate, CurrencyIsoCode, SBQQ__CustomerDiscountField__c, SBQQ__CustomerDiscountLabel__c, SBQQ__Default__c, IsDeleted, SBQQ__DeploymentStatus__c, SBQQDS__DocuSignTemplateId__c, SBQQ__ExcludeHeaderFooter__c, SBQQ__ExcludedPages__c, SBQQ__FontFamily__c, SBQQ__FontSize__c, SBQQ__FooterContent__c, SBQQ__FooterHeight__c, SBQQ__GeneratorName__c, SBQQ__GrandTotalPrefix__c, SBQQ__GroupField__c, SBQQ__GroupFontFamily__c, SBQQ__GroupFontSize__c, SBQQ__GroupFontStyle__c, SBQQ__GroupGap__c, SBQQ__GroupShadingColor__c, SBQQ__GroupTextAlignment__c, SBQQ__GroupTextColor__c, SBQQ__HeaderContent__c, SBQQ__HeaderHeight__c, SBQQ__ComponentProductsHidden__c, SBQQ__HideGroupSubtotals__c, SBQQ__TotalsHidden__c, SBQQ__IntroductionTitle__c, LastModifiedById, LastModifiedDate, LastReferencedDate, LastViewedDate, SBQQ__LeftMargin__c, SBQQ__LineNumbering__c, SBQQ__LineSortField__c, SBQQ__LogoDocumentId__c, SBQQ__NotesTitle__c, SBQQ__TermsNumbered__c, OwnerId, SBQQ__PageHeight__c, SBQQ__PageNumberAlignment__c, SBQQ__PageNumberPosition__c, SBQQ__PageNumberText__c, SBQQ__PageOrientation__c, SBQQ__PageWidth__c, SBQQ__PartnerDiscountLabel__c, SBQQDS__ReviewBeforeSending__c, SBQQ__RightMargin__c, SBQQ__RollUpField__c, SBQQ__ShadingColor__c, SBQQ__ShipToTitle__c, SBQQ__AllPackageProductsShown__c, SBQQ__BundledProductsShown__c, SBQQ__CustomerDiscountShown__c, SBQQ__DiscountScheduleShown__c, SBQQ__PartnerDiscountShown__c, SBQQ__RenewedProductsShown__c, SBQQ__SubGroupField__c, SBQQ__SubtotalField__c, SBQQ__SubtotalLabel__c, SystemModstamp, Name, SBQQ__TermBodyIndent__c, SBQQ__TermsConditions__c, SBQQ__TermsConditionsTitle__c, SBQQ__TextColor__c, SBQQ__TopMargin__c, SBQQ__TotalField__c, SBQQ__TotalLabel__c, SBQQ__WatermarkId__c FROM SBQQ__QuoteTemplate__c WHERE Id = :templateId];
    }
    
    
    

	public void populateLineData(){
		lines = [SELECT Id,  SBQQ__Quantity__c, SBQQ__Group__c, SBQQ__ProductFamily__c, SBQQ__EffectiveStartDate__c, SBQQ__HasConsumptionSchedule__c, SBQQ__Product__r.Name, SBQQ__Product__r.ProductCode, SBQQ__Product__r.Description, SBQQ__ListPrice__c, SBQQ__ListTotal__c, SBQQ__NetTotal__c FROM SBQQ__QuoteLine__c WHERE SBQQ__Quote__c = :quoteId ORDER BY SBQQ__Number__c ASC];
        
        //system.debug(lines);
        for(SBQQ__QuoteLine__c line : lines){
            System.debug(line);
            if(line.SBQQ__HasConsumptionSchedule__c){
                //System.debug('GOT A CS');
                //System.debug(line.Id);
                lineIDsWithCS.add(line.Id);
                showConsumptionSchedule = TRUE;
                //System.debug(lineIDsWithCS);
            }
        }
    }
    
    public void populateGroupData(){
        groups = [SELECT Id, SBQQ__Quote__c, Name, SBQQ__Description__c, SBQQ__Number__c, SBQQ__StartDate__c, SBQQ__NetTotal__c FROM SBQQ__QuoteLineGroup__c WHERE SBQQ__Quote__c = :quoteId ORDER BY SBQQ__Number__c ASC];
    }
    
    public void populateCSData(){
        //List<SBQQ__QuoteLineConsumptionRate__c> lineRates = new List<SBQQ__QuoteLineConsumptionRate__c>{};
        //List<SBQQ__QuoteLineConsumptionRate__c> lineOverageRates = new List<SBQQ__QuoteLineConsumptionRate__c>{};
		linesWithConsumptionSchedules = [SELECT Id, SBQQ__BillingTerm__c, SBQQ__BillingTermUnit__c, SBQQ__Category__c, SBQQ__ConsumptionSchedule__c, SBQQ__Description__c, CurrencyIsoCode, SBQQ__MatchingAttribute__c, SBQQ__QuoteLine__c, SBQQ__QuoteLine__r.Id, SBQQ__QuoteLine__r.SBQQ__ProductName__c,  Name, SBQQ__RatingMethod__c, SBQQ__Type__c, SBQQ__UnitOfMeasure__c, (SELECT Id, Name, SBQQ__Description__c, SBQQ__ProcessingOrder__c, SBQQ__LowerBound__c, SBQQ__UpperBound__c, SBQQ__Price__c, SBQQ__OriginalPrice__c, CurrencyIsoCode, SBQQ__QuoteLineConsumptionSchedule__c, SBQQ__QuoteLineConsumptionSchedule__r.SBQQ__UnitOfMeasure__c, SBQQ__QuoteLineConsumptionSchedule__r.SBQQ__QuoteLine__c FROM SBQQ__QuoteLineConsumptionRates__r ORDER BY SBQQ__ProcessingOrder__c) FROM SBQQ__QuoteLineConsumptionSchedule__c WHERE SBQQ__QuoteLine__r.Id IN :lineIDsWithCS];    
        for(SBQQ__QuoteLineConsumptionSchedule__c schedule : linesWithConsumptionSchedules){
			//system.debug(schedule.SBQQ__QuoteLineConsumptionRates__r);
			
            for(SBQQ__QuoteLineConsumptionRate__c rate : schedule.SBQQ__QuoteLineConsumptionRates__r){
                
                
                    consumptionRates.add(rate);
                	system.debug(rate);
                
            }
			
            
        }
    }
    
}