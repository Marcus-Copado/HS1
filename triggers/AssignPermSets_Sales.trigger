trigger AssignPermSets_Sales on User (after Insert) {


PermissionSetAssignment PSA = new PermissionSetAssignment
(PermissionSetId = '0PS3c0000005bCi', AssigneeId = Trigger.New.Get(0).Id);

insert PSA; 


}