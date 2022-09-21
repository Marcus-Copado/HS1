/**
  * @name:        MCB_OrderCreationCtrl      
  * @date:        10 Nov 2020
  * @description: This is the server side controller class for <MCB_OrderCreation> lightning component.
  *          Server side insertion will be perform here.
***/
public with sharing class MCB_OrderCreationCtrl{
    /**
 * @name:        saveOrder      
 * @date:        10 Nov 2020
 * @description: This method is responsible for creating the order record. This method is called from
 *         client side lighthing component, so this should be annoted with <@AuraEnabled>.
 ***/
    @AuraEnabled
    public static void saveOrder(Order o){
        o.AccountId = '0013c00001qAXl3AAG';
        o.Status = 'Draft';
        INSERT o;
    }
}