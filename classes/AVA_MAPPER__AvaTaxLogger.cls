/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class AvaTaxLogger implements Database.AllowsCallouts, Database.Batchable<String>, System.Queueable {
    global AvaTaxLogger(AVA_MAPPER.ConfigurationBase config, AVA_MAPPER.AvaTaxLogModel model) {

    }
    global AvaTaxLogger(AVA_MAPPER.ConfigurationBase config, AVA_MAPPER.AvaTaxLogger.ConfigurationLogModel configModel) {

    }
    global AvaTaxLogger(AVA_MAPPER.ConfigurationBase config, AVA_MAPPER.AvaTaxLogger.ExceptionLogModel exModel) {

    }
    global AvaTaxLogger(AVA_MAPPER.ConfigurationBase config, AVA_MAPPER.AvaTaxLogger.PerformanceLogModel logModel) {

    }
    global void execute(System.QueueableContext qc) {

    }
    global void execute(Database.BatchableContext info, List<String> args) {

    }
    global void finish(Database.BatchableContext info) {

    }
    global System.Iterable start(Database.BatchableContext info) {
        return null;
    }
global class ConfigurationLogModel {
    global AVA_MAPPER.ConfigurationBase config;
    global String exceptionMessage;
    global String functionName;
    global Boolean isConifgChange;
    global Map<SObject,Set<String>> objectMap;
    global ConfigurationLogModel() {

    }
}
global class ExceptionLogModel {
    global AVA_MAPPER.ConfigurationBase config;
    global String functionName;
    global String message;
    global String operation;
    global String source;
    global ExceptionLogModel() {

    }
}
global class PerformanceLogModel {
    global AVA_MAPPER.ConfigurationBase config;
    global Long connectorTime;
    global String eventBlock;
    global String functionName;
    global String operation;
    global AVA_MAPPER.TransactionModel result;
    global String source;
    global String type;
    global PerformanceLogModel() {

    }
}
}
