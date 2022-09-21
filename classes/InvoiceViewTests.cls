/**
 * Created by scheck on 8/6/18.
 */

@IsTest
private class InvoiceViewTests {

    @TestSetup static void setup(){
        Account testAccount = new Account(
                Name='Universal Testing',
                AccountNumber='0118999'
        );

        Database.insert(testAccount);

        Contact testContact = new Contact(
                AccountId=testAccount.Id,
                FirstName='Test',
                LastName='User'
        );

        Database.insert(testContact);


        blng__Invoice__c testInvoice = new blng__Invoice__c(
                blng__Account__c=testAccount.Id
        );

        Database.insert(testInvoice);


    }

    @IsTest
    private static void testViewInvoices() {
        Contact testContact = [
                SELECT
                        Id
                FROM Contact
                WHERE LastName='User'];
        System.debug('Test Contact: ');
        System.debug(JSON.serializePretty(testContact));


        Profile custCommProfile= [SELECT Id FROM Profile WHERE Name='Customer Community User'];
        UserRole r = new UserRole(DeveloperName = 'CustomCustomerCommunityRole', Name = 'CC Test Role');
        Database.insert(r);

        String orgId=UserInfo.getOrganizationId();
        String dateString=String.valueOf(Datetime.now()).replace(' ','').replace(':','').replace('-','') ;
        Integer randId=Integer.valueOf(Math.rint(Math.random()*1000000));
        String uniqueName=orgId+dateString+randId;

        User custTestUsr = new User(FirstName = 'Test',
                LastName = 'User',
                Email = uniqueName + '@test' + orgId + '.org',
                Username = uniqueName + '@test' + orgId + '.org',
                EmailEncodingKey = 'ISO-8859-1',
                Alias = uniqueName.substring(18, 23),
                TimeZoneSidKey = 'America/Los_Angeles',
                LocaleSidKey = 'en_US',
                LanguageLocaleKey = 'en_US',
                ProfileId = custCommProfile.Id,
                UserRole = r,
                ContactId = testContact.Id
        );

        Database.insert(custTestUsr);

        System.debug('Test User: ');
        System.debug(JSON.serializePretty(custTestUsr));


        System.runAs(custTestUsr) {
            System.debug('Running as user');
            List<blng__Invoice__c> invoices = InvoiceViewCtrl.getInvoices();
            System.assert(invoices.size()>0);
        }
    }

    @IsTest
    private static void testIsRendered() {
        Contact testContact = [
                SELECT
                        Id
                FROM Contact
                WHERE LastName='User'];
        System.debug('Test Contact: ');
        System.debug(JSON.serializePretty(testContact));


        Profile custCommProfile= [SELECT Id FROM Profile WHERE Name='Customer Community User'];
        UserRole r = new UserRole(DeveloperName = 'CustomCustomerCommunityRole', Name = 'CC Test Role');
        Database.insert(r);

        String orgId=UserInfo.getOrganizationId();
        String dateString=String.valueOf(Datetime.now()).replace(' ','').replace(':','').replace('-','') ;
        Integer randId=Integer.valueOf(Math.rint(Math.random()*1000000));
        String uniqueName=orgId+dateString+randId;

        User custTestUsr = new User(FirstName = 'Test',
                LastName = 'User',
                Email = uniqueName + '@test' + orgId + '.org',
                Username = uniqueName + '@test' + orgId + '.org',
                EmailEncodingKey = 'ISO-8859-1',
                Alias = uniqueName.substring(18, 23),
                TimeZoneSidKey = 'America/Los_Angeles',
                LocaleSidKey = 'en_US',
                LanguageLocaleKey = 'en_US',
                ProfileId = custCommProfile.Id,
                UserRole = r,
                ContactId = testContact.Id
        );

        Database.insert(custTestUsr);

        System.debug('Test User: ');
        System.debug(JSON.serializePretty(custTestUsr));


        System.runAs(custTestUsr) {
            System.debug('Running as user');
            Boolean isRenderedBoolean = InvoiceViewCtrl.isRendered();
            System.assert(isRenderedBoolean);
        }
    }
}