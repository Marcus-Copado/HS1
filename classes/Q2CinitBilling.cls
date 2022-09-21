public class Q2CinitBilling {
    public static void initBill() {
        CPQB_RecordReset.disableBillingTriggers(true);
        //deleteRevenueSchedules();
        deleteFinancePeriods();
        CPQB_RecordReset.disableBillingTriggers(false);
        //clearit();
        //System.enqueueJob(new DeleteRecords());
        createFinancePeriods();
        createRevenueTreatments();
        resetPG();
        resetTR();
    }
    
    public static void purgeBillingData() { // ALEX!!!!!!
        //CPQB_RecordReset.disableBillingTriggers(true);
        // delete revenue transactions...
        BatchRTRecordDelete delRT = new BatchRTRecordDelete(); 
		Id batchId = Database.executeBatch(delRT, 10000);
        // delete revenue schedules();
        BatchRSRecordDelete delRS = new BatchRSRecordDelete(); 
		Id batchId2 = Database.executeBatch(delRS, 10000);
    }

    @future
    public static void resetPG() {
        List<blng__PaymentGateway__c> PGs = [SELECT 
                                                   adnblng__APILoginId__c, 
                                                   adnblng__APITransactionKey__c, 
                                                   csblng__MerchantId__c, 
                                                   csblng__MerchantReference__c, 
                                                   blng__GatewayType__c, 
                                                   blng__Default__c, 
                                                   csblng__TestMode__c, 
                                                   adnblng__TestMode__c
                                             FROM blng__PaymentGateway__c 
                                             WHERE Name = 'CyberSource'];
        for (blng__PaymentGateway__c pg : PGs) {
            if ((pg.blng__GatewayType__c == 'CyberSource') && (pg.csblng__TestMode__c == TRUE)) {
                pg.csblng__MerchantId__c = 'salesforcebilling';
                pg.csblng__MerchantReference__c = 'salesforcebilling';
                pg.blng__Default__c = FALSE;
            } else if (pg.blng__GatewayType__c == 'AuthorizeDotNet' && (pg.adnblng__TestMode__c == TRUE)) {
                pg.adnblng__APILoginId__c = '3y33JXnnN5Z4';
                pg.adnblng__APITransactionKey__c = '57zJ2sG376mXkRqf';
                pg.blng__Default__c = FALSE;
            } else if (pg.blng__GatewayType__c == 'MockGateway') {
                pg.blng__Active__c = TRUE;
                pg.blng__Default__c = TRUE;
            }
        }
        update PGs;
    }

    //tax treatments
    @future
    public static void resetTR() {
        List<blng__TaxRate__c> NewTRs = new List<blng__TaxRate__c>();
        List<blng__TaxRate__c> OldTRs = [SELECT 
                                               Name, blng__State__c, 
                                               blng__City__c, 
                                               blng__ZipCode__c, 
                                               blng__Country__c, 
                                               blng__Priority__c, 
                                               blng__TaxCode__c, 
                                               blng__Rate__c, 
                                               blng__LegalEntity__c
                                         FROM blng__TaxRate__c ];
        for (Integer i = 0; i < OldTRs.size(); i++) {
            blng__TaxRate__c NewTR = OldTRs.get(i).clone(false, true);
            NewTR.blng__AddressComparison__c = NewTR.blng__Country__c + '----' + NewTR.blng__TaxCode__c + '-' + NewTR.blng__LegalEntity__c;
            NewTR.blng__PriorityAddressComparison__c = NewTR.blng__Priority__c + '-' + NewTR.blng__Country__c + '----' + NewTR.blng__TaxCode__c + '-' + NewTR.blng__LegalEntity__c;
            NewTRs.add(NewTR);
        }
        delete OldTRs;
        insert NewTRs;
    }

    //Finance Periods
    public static void createFinancePeriods() {
        List<CurrencyType> currencies = [SELECT 
                                               ConversionRate, 
                                               DecimalPlaces, 
                                               IsCorporate, 
                                               IsoCode
                                         FROM CurrencyType
                                         WHERE IsActive = TRUE];
        Integer mutableYear, mutableMonth;
        Date periodStart, periodEnd;
        List<blng__FinancePeriod__c> fpToInsert = new List<blng__FinancePeriod__c>();
        List<blng__LegalEntity__c> allLegalEntities = [SELECT 
                                                             Id, 
                                                             Name
                                                       FROM blng__LegalEntity__c ];
        Date todayDate = Date.today();
        Integer monthZero = 1;
        //Integer monthZero = todayDate.month();
        Integer yearZero = todayDate.year();
        Map<Integer, String> monthNameMap = new Map<Integer, String>{1 => 'Jan', 2 => 'Feb', 3 => 'Mar', 4 => 'Apr', 5 => 'May', 6 => 'Jun', 7 => 'Jul', 8 => 'Aug', 9 => 'Sep', 10 => 'Oct', 11 => 'Nov', 12 => 'Dec'};

        for (blng__FinanceBook__c fb : [SELECT 
                                              Id, 
                                              Name, blng__PeriodType__c
                                        FROM blng__FinanceBook__c ]) {
            for (blng__LegalEntity__c le : allLegalEntities) {
                for (CurrencyType curr : currencies) {
                    for (Integer i = 0; i < 48; i++) {
                        if (i == 0) {
                            periodStart = Date.newInstance(yearZero, monthZero, 1);
                            periodEnd = Date.newInstance(yearZero, monthZero, Date.daysInMonth(yearZero, monthZero));
                        } else {
                            periodStart = periodStart.addMonths(1);
                            mutableYear = periodStart.year();
                            mutableMonth = periodStart.month();
                            periodEnd = Date.newInstance(mutableYear, mutableMonth, Date.daysInMonth(mutableYear, mutableMonth));

                        }
                        //blng__FinancePeriod__c fp = new blng__FinancePeriod__c(Name = monthNameMap.get(periodStart.month())+' ' + String.valueOf(periodStart.year())+'-' + fb.blng__PeriodType__c + '-' + le.Name + '-' + curr.IsoCode, blng__PeriodStartDate__c = periodStart, blng__PeriodEndDate__c = periodEnd, blng__FinanceBook__c = fb.Id, blng__PeriodStatus__c = 'Open', blng__LegalEntity__c = le.Id, CurrencyIsoCode = curr.IsoCode);
                        blng__FinancePeriod__c fp = new blng__FinancePeriod__c(Name = String.valueOf(periodStart.year())+'.' + String.valueOf(periodStart.month())+'-' + fb.blng__PeriodType__c + '-' + le.Name + '-' + curr.IsoCode, blng__PeriodStartDate__c = periodStart, blng__PeriodEndDate__c = periodEnd, blng__FinanceBook__c = fb.Id, blng__PeriodStatus__c = 'Open', blng__LegalEntity__c = le.Id, CurrencyIsoCode = curr.IsoCode);

                        fpToInsert.add(fp);
                    }
                }
            }
        }

        insert fpToInsert;
    }

    //Revenue Distribution Methods
    @future
    public static void createRevenueTreatments() {
        List<blng__RevenueRecognitionTreatment__c> NewRevTreats = new List<blng__RevenueRecognitionTreatment__c>();
        List<blng__RevenueRecognitionTreatment__c> OldRevTreats = [SELECT 
                                                                         Name, blng__Active__c, 
                                                                         blng__FlatAmount__c, 
                                                                         blng__Notes__c, 
                                                                         blng__Percentage__c, 
                                                                         blng__ProcessingOrder__c, 
                                                                         blng__RevenueAgreementAssociation__c, 
                                                                         blng__RevenueDistributionMethod__c, blng__RevenueFinanceBook__c, 
                                                                         blng__RevenueGLRule__c, 
                                                                         blng__RevenueLegalEntity__c, 
                                                                         blng__RevenueRecognitionRule__c, blng__RevenueScheduleAmount__c, 
                                                                         blng__RevenueScheduleCreationAction__c, 
                                                                         blng__Type__c
                                                                   FROM blng__RevenueRecognitionTreatment__c ];

        for (Integer i = 0; i < OldRevTreats.size(); i++) {
            blng__RevenueRecognitionTreatment__c NewRev = OldRevTreats.get(i).clone(false, true);
            NewRevTreats.add(NewRev);
        }
        delete OldRevTreats;
        insert NewRevTreats;
        List<blng__TaxRate__c> NewTaxRate = new List<blng__TaxRate__c>();
        List<blng__TaxRate__c> OldTaxRate = [SELECT 
                                                   Name, blng__TaxCode__c, 
                                                   blng__State__c, 
                                                   blng__City__c, 
                                                   blng__Rate__c, 
                                                   blng__ZipCode__c, 
                                                   blng__Country__c, 
                                                   blng__LegalEntity__c, blng__Priority__c
                                             FROM blng__TaxRate__c ];

        for (Integer i = 0; i < OldTaxRate.size(); i++) {
            blng__TaxRate__c NewTR = OldTaxRate.get(i).clone(false, true);
            NewTaxRate.add(NewTR);
        }
        delete OldTaxRate;
        insert NewTaxRate;
    }

    public static void clearit() {
        List<blng__RevenueSchedule__c> deleteRS = [SELECT 
                                                         Id
                                                   FROM blng__RevenueSchedule__c ];
        delete deleteRS;
        List<blng__FinancePeriod__c> deleteFP = [SELECT 
                                                       Id
                                                 FROM blng__FinancePeriod__c ];
        delete deleteFP;
    }

    static void deleteFinancePeriods() {
        Map<Id, blng__FinancePeriod__c> fpMap = new Map<Id, blng__FinancePeriod__c>([SELECT 
                                                                                           Id
                                                                                     FROM blng__FinancePeriod__c ]);
        List<blng__FinancePeriod__c> deleteFp = fpMap.values();
        try {
            delete deleteFp;
        } catch (DmlException e) {
            System.debug(e);
            throw new AuraHandledException(e.getMessage());
        }
    }

    public static void deleteRevenueSchedules() {
        Map<Id, blng__RevenueSchedule__c> rsMap = new Map<Id, blng__RevenueSchedule__c>([SELECT 
                                                                                               Id
                                                                                         FROM blng__RevenueSchedule__c ]);
        List<blng__RevenueSchedule__c> deleteRs = rsMap.values();
        try {
            delete deleteRs;
        } catch (DmlException e) {
            System.debug(e);
            throw new AuraHandledException(e.getMessage());
        }
    }

    static void deleteRevenueTransactions() {
        Map<id, blng__RevenueTransaction__c> rtMap = new Map<id, blng__RevenueTransaction__c>([SELECT 
                                                                                                     Id
                                                                                               FROM blng__RevenueTransaction__c]);
        System.debug('Total rtMap size to delete: '+ rtMap.size() );
        for(Integer i = 0; i < rtMap.size(); i++){
            System.debug('Delete loop where i: ' + i);
            Map<id, blng__RevenueTransaction__c> rtMap2 = new Map<id, blng__RevenueTransaction__c>([SELECT 
                                                                                                     Id
                                                                                               FROM blng__RevenueTransaction__c LIMIT 1999]);
        	List<blng__RevenueTransaction__c> deleteRT2 = rtMap2.values();
        	try {
                System.debug('Attempting to delete ' + deleteRT2.size() + ' rt rows.');
           		delete deleteRT2;
        	} catch (DmlException e) {
            	System.debug(e);
            	throw new AuraHandledException(e.getMessage());
        	}
            
            rtMap2.clear();
            deleteRT2.clear();
        }
        
    }

    public class DeleteRecords implements Queueable {
        public void execute(QueueableContext context){
            //System.debug('Enqueue Limit : '+Limits.getQueueableJobs());
            //System.enqueueJob(new DeleteRevenueTransactions());
            System.debug('Enqueue Limit : '+Limits.getQueueableJobs());
            System.enqueueJob(new DeleteRevenueSchedules());
            System.debug('Enqueue Limit : '+Limits.getQueueableJobs());
            System.enqueueJob(new DeleteFinancePeriods());
        }
    }

    public class DeleteRevenueTransactions implements Queueable {
        private List<blng__RevenueTransaction__c> rtToDelete;

        public void getRevenueTransactions() {
            Map<Id, blng__RevenueTransaction__c> rtMap = new Map<Id, blng__RevenueTransaction__c>([SELECT 
                                                                                               Id
                                                                                         FROM blng__RevenueTransaction__c ]);
            this.rtToDelete = rtMap.values();
        }
        
        public void execute(QueueableContext context) {
            delete rtToDelete;
        }
    }
    
    public class DeleteRevenueSchedules implements Queueable {
        private List<blng__RevenueSchedule__c> rsToDelete;

        public void getRevenueSchedules() {
            Map<Id, blng__RevenueSchedule__c> rsMap = new Map<Id, blng__RevenueSchedule__c>([SELECT 
                                                                                               Id
                                                                                         FROM blng__RevenueSchedule__c ]);
            this.rsToDelete = rsMap.values();
        }
        
        public void execute(QueueableContext context) {
            delete rsToDelete;
        }
    }

    public class DeleteFinancePeriods implements Queueable {
        private List<blng__FinancePeriod__c> fps;

        public void getFinancePeriods() {
            Map<Id, blng__FinancePeriod__c> fpMap = new Map<Id, blng__FinancePeriod__c>([SELECT 
                                                                                               Id
                                                                                         FROM blng__FinancePeriod__c ]);
            this.fps = fpMap.values();
        }
        
        public void execute(QueueableContext context) {
            delete fps;
        }
    }
    
}