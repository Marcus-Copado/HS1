trigger CdemoProductBefore on Product2 (before insert) {
    ProductUtility.BeforeTriggerProcessor(trigger.new);
}