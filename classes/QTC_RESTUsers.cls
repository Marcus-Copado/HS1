/*
 * This Class goes in the source org to 

*/
@RestResource(urlMapping = '/qtcusers/')
global with sharing class QTC_RESTUsers {

    @HttpPost
    global static String doPost(String firstName, String lastName, String email, String role) {
        String orgBase = '@smartbytes.demo';
        if (!email.endsWithIgnoreCase('@salesforce.com')) {
            System.debug('Invalid Email: ' + email);
            return 'Invalid Email: ' + email;
        }

        String uName = email.remove('@salesforce.com').split('\\+').get(0);
        String sanitizedEmail = uName + '@salesforce.com';
        //system.debug(sanitizedEmail);
        List <User> result = [SELECT Id, FirstName, LastName, Email FROM User WHERE Email =: sanitizedEmail OR Email =: email];
        Profile p = [SELECT Id, Name FROM Profile WHERE Name = 'CPQB Sales'
            LIMIT 1
        ];
        UserRole r = [SELECT Id, Name FROM UserRole WHERE Name = 'Direct Sales'
            LIMIT 1
        ];

        if (result.size() > 0) {
            System.debug('Matched ' + result.size() + ' existing User email(s)');
            for (User u: result) {
                System.debug('Resetting Password for: ' + u.FirstName + ' ' + u.LastName + ' (' + u.Email + ')');
                System.resetPassword(u.Id, true);
            }
            return 'Password Reset';

        } else {
            System.debug('Creating a new User for: ' + firstName + ' ' + lastName + ' (' + email + ')');
            User newUser = new User(FirstName = firstName,
                LastName = lastName,
                Email = email,
                Username = uName + orgBase,
                EmailEncodingKey = 'ISO-8859-1',
                Alias = uName.mid(0, 8),
                TimeZoneSidKey = 'America/Los_Angeles',
                LocaleSidKey = 'en_US',
                LanguageLocaleKey = 'en_US',
                ProfileId = p.Id,
                UserRoleId = r.Id);
            insert newUser;            
            System.resetPassword(newUser.Id, true);
            return newUser.Id;
        }
    }
    
    @HttpGet
    global static List<User> doGet() {
        List<User> result = [SELECT
                                Address,
                                Alias,
                                City,
                                CommunityNickname,
                                CompanyName,
                                Country,
                                CreatedById,
                                CreatedDate,
                                Email,
                                EmailEncodingKey,
                                FederationIdentifier,
                                FirstName,
                                Id,
                                IsActive,
                                LanguageLocaleKey,
                                LastLoginDate,
                                LastModifiedById,
                                LastModifiedDate,
                                LastName,
                                LastPasswordChangeDate,
                                LastReferencedDate,
                                LastViewedDate,
                                LocaleSidKey,
                                MediumBannerPhotoUrl,
                                MediumPhotoUrl,
                                MobilePhone,
                                Name,
                                Phone,
                                PostalCode,
                                ProfileId,
                                SmallBannerPhotoUrl,
                                SmallPhotoUrl,
                                State,
                                Street,
                                SystemModstamp,
                                TimeZoneSidKey,
                                Title,
                                Username,
                                UserRoleId,
                                UserType
                            FROM User];

        return result;
    }
}