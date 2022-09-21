trigger CdemoProductAfter on Product2 (after insert, after update) {
    if(trigger.isAfter){
        ProductUtility.AfterTriggerProcessor(Trigger.new, Trigger.isInsert);
    }

    
    else if(trigger.isUpdate){
    
    }

}