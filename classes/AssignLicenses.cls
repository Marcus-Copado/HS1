public class AssignLicenses {

    @InvocableMethod(label='QTC License Assignment' description='Assigns CPQ, Billing, and Advanced Approvals licenses (if available) to a list of User Ids passed in.')
    public static void assignQTCLicenses(List<Id> uids){
        List<User> userList = [SELECT Id, Name FROM User WHERE Id IN :uids];
        Set<String> packageSet = new Set<String>{'sbaa', 'SBQQ', 'blng'};
        List<PackageLicense> licenseList = [SELECT Id, NamespacePrefix FROM PackageLicense WHERE NamespacePrefix IN :packageSet];

        List<UserPackageLicense> upl = new List<UserPackageLicense>();
        for(User u : userList){
            for(PackageLicense pl : licenseList){
            	upl.add(new UserPackageLicense(UserId = u.id, PackageLicenseId = pl.id));
            	System.debug('Added: ' + pl.NamespacePrefix + ' to ' + u.Name);
            }
        }

        if(!upl.isempty()){
            try {
                database.upsert(upl);
                System.debug('Successfully Inserted Package Licenses');
            } catch (DmlException e) {
                System.debug('Error Upserting Package Licenses:' + e);
            }
        }
    }
}