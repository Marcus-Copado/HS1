/**
 * Created by scheck on 8/6/18.
 */
@isTest
public class ContractViewTests {


    @TestSetup static void setup(){
        Account testAccount = new Account(
                Name='Universal Testing',
                AccountNumber='0118999'
        );

        Database.insert(testAccount);

        Contract testContract = new Contract(
                AccountId=testAccount.Id,
                Status='Draft',
                StartDate=System.today(),
                ContractTerm=12
        );

        Database.insert(testContract);

        testContract.Status = 'Activated';
        Database.update(testContract);

        Contact testContact = new Contact(
                AccountId=testAccount.Id,
                FirstName='Test',
                LastName='User'
        );

        Database.insert(testContact);


    }


    @IsTest
    private static void testViewContracts() {
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
            List<Contract> lc = ContractViewCtrl.getContracts();
            System.assert(lc.size()>0);
        }
    }

    @IsTest
    private static void testRendered() {
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
            Boolean isRendered = ContractViewCtrl.isRendered();
            System.assert(isRendered);
        }
    }

    @IsTest
    private static void testFireAmend() {
        Contract testContract = [SELECT Id FROM Contract LIMIT 1];

        Test.startTest();
        Id amendId = ContractViewCtrl.fireAmend(testContract.Id);
        Test.stopTest();

        System.assertNotEquals(amendId, null);

    }


    @IsTest
    private static void testFireCancel() {
        Contract testContract = [SELECT Id FROM Contract LIMIT 1];

        Test.startTest();
        Id amendId = ContractViewCtrl.fireCancel(testContract.Id);
        Test.stopTest();

        System.assertNotEquals(amendId, null);

    }
    

}