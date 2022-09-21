public with sharing class Kodiak_PlayerController {

    @AuraEnabled(cacheable=true)
    public static String getFieldValue(Id recordId, String targetField){
        String sobjectName = recordId.getSObjectType().getDescribe().getName();
        SObject record = Database.query('SELECT Id, '+ String.escapeSingleQuotes(targetField) + ' FROM ' + String.escapeSingleQuotes(sobjectName) + ' WHERE Id = :recordId');
        return String.valueOf(record.get(targetField));
    }
}