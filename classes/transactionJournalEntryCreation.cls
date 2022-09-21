// tony saarnio
// 2-13-2020

public class transactionJournalEntryCreation {
    
    @future(callout=true)   
    public static void CreateTransactionJournalEntries(Id invId){
        
        boolean debug = false;
        
        //instantiate list of journal entry and journal entry line objects
        List <Transaction_Journal_Entry__c> JEsToInsert = new List <Transaction_Journal_Entry__c> ();
        List <Transaction_Journal_Entry_Line__c> JELinesToInsert = new List <Transaction_Journal_Entry_Line__c> ();
        
        //query invoice line detail from invoice ID
        List <blng__InvoiceLine__c> invLines = [SELECT Id, 
                                                blng__Invoice__c,
                                                Account__c,
                                                blng__ChargeDate__c,
                                                blng__BillingFinanceBook__c,
                                                blng__BillingFinancePeriod__c,
                                                blng__LegalEntity__c,
                                                blng__TaxGLTreatment__c,
                                                blng__BillingGLTreatment__c,
                                                blng__Subtotal__c,
                                                blng__TaxAmount__c,
                                                blng__TotalAmount__c,
                                                blng__BillingGLTreatment__r.blng__CreditGLAccount__r.Id,
                                                blng__BillingGLTreatment__r.blng__DebitGLAccount__r.Id,
                                                blng__TaxGLTreatment__r.blng__CreditGLAccount__r.Id,
                                                blng__TaxGLTreatment__r.blng__DebitGLAccount__r.Id
                                                FROM blng__InvoiceLine__c WHERE blng__Invoice__c = :invId];
        
        
        if(debug){ system.debug(invId); }
        if(debug){ system.debug(invLines); }
        
        for(blng__InvoiceLine__c invLine : invLines){
            
            //instantiate the TJE object
            Transaction_Journal_Entry__c je = new Transaction_Journal_Entry__c(); 
            
            //map invoice line fields to new vehicle TJE object 
            je.Invoice_Line__c = invLine.Id;
            je.Account__c = invLine.Account__c;
            je.Transaction_Date__c = invLine.blng__ChargeDate__c;
            je.Transaction_Type__c = 'Invoice Line';
            je.Posting_Status__c = 'Drraft';
            je.Finance_Book__c = invLine.blng__BillingFinanceBook__c;
            je.Finance_Period__c = invLine.blng__BillingFinancePeriod__c;
            je.Legal_Entity__c = invLine.blng__LegalEntity__c;
            je.Tax_GL_Treatment__c = invLine.blng__TaxGLTreatment__c;
            je.Billing_GL_Treatment__c = invLine.blng__BillingGLTreatment__c;
            je.Subtotal__c = invLine.blng__Subtotal__c;
            je.Tax_Amount__c = invLine.blng__TaxAmount__c;
            //je.Total_CR__c = invLine.blng__TotalAmount__c;
            //je.Total_DR__c = invLine.blng__TotalAmount__c;
            je.Total_CR__c = invLine.blng__Subtotal__c;
            je.Total_DR__c = invLine.blng__Subtotal__c;
            je.Credit_GL_Account__c = invLine.blng__BillingGLTreatment__r.blng__CreditGLAccount__r.Id;
            je.Debit_GL_Account__c = invLine.blng__BillingGLTreatment__r.blng__DebitGLAccount__r.Id;
            je.Tax_Credit_GL_Account__c = invLine.blng__TaxGLTreatment__r.blng__CreditGLAccount__r.Id;
            je.Tax_Debit_GL_Account__c = invLine.blng__TaxGLTreatment__r.blng__DebitGLAccount__r.Id;
            
            //add new TJE to the list to be inserted.
            JEsToInsert.add(je);
        }
        
        // insert journal entries
        try {
            insert JEsToInsert; 
        } catch (system.Dmlexception e) {
            system.debug (e);
        }
        
        
        for(Transaction_Journal_Entry__c insertedJE : JEsToInsert){  
            
            //instantiate the TJELine objects
            Transaction_Journal_Entry_Line__c  jeLineCR = new Transaction_Journal_Entry_Line__c(); 
            Transaction_Journal_Entry_Line__c  jeLineDR = new Transaction_Journal_Entry_Line__c();
            Transaction_Journal_Entry_Line__c  jeLineCrTax = new Transaction_Journal_Entry_Line__c();
            Transaction_Journal_Entry_Line__c  jeLineDrTax = new Transaction_Journal_Entry_Line__c();
            
            //map TJE fields to new vehicle TJELine Credit object 
            jeLineCR.Account__c = insertedJE.Account__c;
            jeLineCR.Transaction_Journal_Entry__c = insertedJE.Id;
            jeLineCR.Invoice_Line__c = insertedJE.Invoice_Line__c;
            jeLineCR.Legal_Entity__c = insertedJE.Legal_Entity__c;
            jeLineCR.Finance_Book__c = insertedJE.Finance_Book__c;
            jeLineCR.Finance_Period__c = insertedJE.Finance_Period__c;
            jeLineCR.Journal_Entry_Line_Type__c = 'CR';
            jeLineCR.Transaction_Date__c = insertedJE.Transaction_Date__c;
            jeLineCR.Transaction_Type__c = 'Invoice Line';
            jeLineCR.Posting_Status__c = 'Draft';
            jeLineCR.Credit__c = insertedJE.Total_CR__c;
            jeLineCR.Transaction_Currency__c = 'USD';
            jeLineCR.Credit_GL_Account__c = insertedJE.Credit_GL_Account__c;
            jeLineCR.Debit_GL_Account__c = insertedJE.Debit_GL_Account__c ;
            
            //add new TJELine object to the list to be inserted.
            JELinesToInsert.add(jeLineCR);
            
            
            //map TJE fields to new vehicle TJELine Debit object
            jeLineDR.Account__c = insertedJE.Account__c;
            jeLineDR.Transaction_Journal_Entry__c = insertedJE.Id;
            jeLineDR.Invoice_Line__c = insertedJE.Invoice_Line__c;
            jeLineDR.Legal_Entity__c = insertedJE.Legal_Entity__c;
            jeLineDR.Finance_Book__c = insertedJE.Finance_Book__c;
            jeLineDR.Finance_Period__c = insertedJE.Finance_Period__c;
            jeLineDR.Journal_Entry_Line_Type__c = 'DR';
            jeLineDR.Transaction_Date__c = insertedJE.Transaction_Date__c;
            jeLineDR.Transaction_Type__c = 'Invoice Line';
            jeLineDR.Posting_Status__c = 'Draft';
            jeLineDR.Debit__c = insertedJE.Total_DR__c;
            jeLineDR.Transaction_Currency__c = 'USD';
            jeLineDR.Credit_GL_Account__c = insertedJE.Credit_GL_Account__c;
            jeLineDR.Debit_GL_Account__c = insertedJE.Debit_GL_Account__c ;
            
            //add new TJELine objects to the list to be inserted.
            JELinesToInsert.add(jeLineDR);
            
            
            if(insertedJE.Tax_Amount__c > 0){
                
                //map TJE fields to new vehicle TJELine CreditTax object if tax is applied
                jeLineCrTax.Account__c = insertedJE.Account__c;
                jeLineCrTax.Transaction_Journal_Entry__c = insertedJE.Id;
                jeLineCrTax.Invoice_Line__c = insertedJE.Invoice_Line__c;
                jeLineCrTax.Legal_Entity__c = insertedJE.Legal_Entity__c;
                jeLineCrTax.Finance_Book__c = insertedJE.Finance_Book__c;
                jeLineCrTax.Finance_Period__c = insertedJE.Finance_Period__c;
                jeLineCrTax.Journal_Entry_Line_Type__c = 'CR';
                jeLineCrTax.Transaction_Date__c = insertedJE.Transaction_Date__c;
                jeLineCrTax.Transaction_Type__c = 'Invoice Line';
                jeLineCrTax.Posting_Status__c = 'Draft';
                jeLineCrTax.Credit__c = insertedJE.Tax_Amount__c;
                jeLineCrTax.Transaction_Currency__c = 'USD';
                jeLineCrTax.Credit_GL_Account__c = insertedJE.Tax_Credit_GL_Account__c ;
                jeLineCrTax.Debit_GL_Account__c = insertedJE.Tax_Debit_GL_Account__c ;
                
                //add new TJELine objects to the list to be inserted.
                JELinesToInsert.add(jeLineCrTax);
            
        
                //map TJE fields to new vehicle TJELine DebitTax object if tax is applied
                jeLineDrTax.Account__c = insertedJE.Account__c;
                jeLineDrTax.Transaction_Journal_Entry__c = insertedJE.Id;
                jeLineDrTax.Invoice_Line__c = insertedJE.Invoice_Line__c;
                jeLineDrTax.Legal_Entity__c = insertedJE.Legal_Entity__c;
                jeLineDrTax.Finance_Book__c = insertedJE.Finance_Book__c;
                jeLineDrTax.Finance_Period__c = insertedJE.Finance_Period__c;
                jeLineDrTax.Journal_Entry_Line_Type__c = 'DR';
                jeLineDrTax.Transaction_Date__c = insertedJE.Transaction_Date__c;
                jeLineDrTax.Transaction_Type__c = 'Invoice Line';
                jeLineDrTax.Posting_Status__c = 'Draft';
                jeLineDrTax.Debit__c = insertedJE.Tax_Amount__c;
                jeLineDrTax.Transaction_Currency__c = 'USD';
                jeLineDrTax.Credit_GL_Account__c = insertedJE.Tax_Credit_GL_Account__c ;
                jeLineDrTax.Debit_GL_Account__c = insertedJE.Tax_Debit_GL_Account__c ;
                
                
                //add new TJELine objects to the list to be inserted.
                JELinesToInsert.add(jeLineDrTax);
            }
            
        }
        
        // insert journal entry lines
        try {
            insert JELinesToInsert; 
        } catch (system.Dmlexception f) {
            system.debug (f);
        }
    }
}