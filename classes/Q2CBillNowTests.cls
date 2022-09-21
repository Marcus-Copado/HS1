@IsTest
public class Q2CBillNowTests {
    
  @TestSetup 
  static void setup(){
        Account testAccount = new Account(
                Name='Universal Testing',
                AccountNumber='0118999'
        );

        Database.insert(testAccount);

        Order testOrder = new Order(
			AccountId=testAccount.Id,
            Status='Draft',
            blng__BillingDayOfMonth__c = '1',
            EffectiveDate=System.today()
        );

        Database.insert(testOrder);
      /*
      testOrder.Status = 'Activated';
      Database.update(testOrder);
*/

    }
    
    @IsTest
    private static void testBillNowController() {		
		
        Order testOrder = [SELECT Id, Status FROM Order LIMIT 1];
        // put id in std object
		ApexPages.currentPage().getParameters().put('id',testOrder.Id);
        // pass in std object
		ApexPages.StandardController stdCtrl = new ApexPages.StandardController(testOrder);

        // pass std ctl to new instance of MyExtController
	    Q2CBillNow billnowController  = new Q2CBillNow(stdCtrl);
		
        // run methods, use sys asserts
		billnowController.billNow();
        System.assert(testOrder != null);

    }

}