/**
 * Created by scheck on 6/26/18.
 */

@IsTest
public class SaveInvoiceTest {

    @TestSetup
    static void createTestInvoice() {
        Account testAccount = new Account(Name='Test', AccountNumber='0118999');
        insert testAccount;

        blng__Invoice__c testInvoice = new blng__Invoice__c(blng__Account__c=testAccount.Id);
        insert testInvoice;
    }

    @IsTest
    private static void saveInvoiceTest() {
        List<blng__Invoice__c> invoices = [SELECT id FROM blng__Invoice__c];
        PageReference pageRef = new PageReference('/apex/SaveInvoice?id=' + invoices[0].Id);
        Test.setCurrentPageReference(pageRef);
        System.assert(invoices.size()> 0, 'Invoices > 0 for controller test');

        ApexPages.currentPage().getParameters().put('id',invoices[0].Id);
        ApexPages.StandardController stdInvoiceController = new ApexPages.StandardController(invoices[0]);
        SavePDF savePDFController  = new SavePDF(stdInvoiceController);

        savePDFController.saveAttachement();

        List<Attachment> attachments = [SELECT Id, ParentId FROM Attachment WHERE ParentId =: invoices[0].Id];
        System.assert(attachments.size()>0,'Attachments > 0 for controller test');
}

}