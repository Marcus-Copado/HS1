@IsTest
public class AssignLicenseTest {
    
    @IsTest(SeeAllData=True)
    private static void testUserAssignment(){
        Map<Id, User> userMap = new Map<Id, User>([SELECT Id FROM User WHERE LastName = 'Check']);
        List<Id> uIds = new List<Id>(userMap.keySet());
        AssignLicenses.AssignQTCLicenses(uIds);
        
        List<UserPackageLicense> upl = [SELECT Id, UserId FROM UserPackageLicense WHERE UserId IN :uIds];
        System.assert(upl.size() > 0, 'UserPackageLicenses Inserted');
    }
}