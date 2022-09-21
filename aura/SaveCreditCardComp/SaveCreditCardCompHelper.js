({
	displayToast : function(toastTitle, toastMessage, toastType) {
        var toast = $A.get("e.force:showToast");
        toast.setParams({
            'title' : toastTitle,
            'message' : toastMessage,
            'type': toastType
        });
        toast.fire();
    }
})