/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class UnauthorizedException extends Exception {
    global dfsle.UnauthorizedException.AccessRequirement requirement {
        get;
    }
    global Id userId {
        get;
    }
global enum AccessRequirement {ClmAdministrator, ClmCommunityUser, ClmUser, ClmViewer, ConfigureAccount, DocuSignAdministrator, DocuSignBillingAdmin, DocuSignGenerator, DocuSignNegotiator, DocuSignSender, DocuSignUser, EnvelopeOwner, IntegrationUser, OriginalUser, SalesforceAdministrator, SecurityPermission, Unspecified}
}
