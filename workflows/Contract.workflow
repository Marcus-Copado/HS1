<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Activate</fullName>
        <field>Status</field>
        <literalValue>Activated</literalValue>
        <name>Activate</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Asyc_Renewal_Forecast</fullName>
        <field>SBQQ__RenewalForecast__c</field>
        <literalValue>1</literalValue>
        <name>Asyc Renewal Forecast</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Contracted_Status</fullName>
        <field>Status__c</field>
        <literalValue>Activated</literalValue>
        <name>Contracted Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Expire_it</fullName>
        <field>Status__c</field>
        <literalValue>Expired</literalValue>
        <name>Expire it</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Forecast_Contract_Renewal</fullName>
        <field>SBQQ__RenewalForecast__c</field>
        <literalValue>1</literalValue>
        <name>Forecast Contract Renewal</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Forecast_Renewal_Opp</fullName>
        <field>SBQQ__RenewalForecast__c</field>
        <literalValue>1</literalValue>
        <name>Forecast Renewal Opp</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Forecast_Renewal_Quote</fullName>
        <field>SBQQ__RenewalQuoted__c</field>
        <literalValue>1</literalValue>
        <name>Forecast Renewal Quote</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Preserve_Bundle_Structure</fullName>
        <field>SBQQ__PreserveBundleStructureUponRenewals__c</field>
        <literalValue>1</literalValue>
        <name>Preserve Bundle Structure</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Renewal_Forecast</fullName>
        <field>SBQQ__RenewalForecast__c</field>
        <literalValue>1</literalValue>
        <name>Renewal Forecast</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Renewal_Forecast2</fullName>
        <field>SBQQ__RenewalForecast__c</field>
        <literalValue>1</literalValue>
        <name>Renewal Forecast</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Renewal_Forecast</fullName>
        <field>SBQQ__RenewalForecast__c</field>
        <literalValue>1</literalValue>
        <name>Set Renewal Forecast</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Renewal_Forecasted</fullName>
        <field>SBQQ__RenewalForecast__c</field>
        <literalValue>1</literalValue>
        <name>Set Renewal Forecasted</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Status_Renewal_Forecasted</fullName>
        <field>Status__c</field>
        <literalValue>Renewal Forecasted</literalValue>
        <name>Status - Renewal Forecasted</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Activate Contract</fullName>
        <actions>
            <name>Activate</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Contracted_Status</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Preserve_Bundle_Structure</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>True</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Auto Renewal Forecast</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Contract.Status</field>
            <operation>equals</operation>
            <value>Activated</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Auto_Renewal_Forecast__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Asyc_Renewal_Forecast</name>
                <type>FieldUpdate</type>
            </actions>
            <offsetFromField>Contract.CreatedDate</offsetFromField>
            <timeLength>-1</timeLength>
            <workflowTimeTriggerUnit>Hours</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Expire Contracts</fullName>
        <actions>
            <name>Expire_it</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>TODAY() &gt; EndDate</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Renewal Forecast</fullName>
        <actions>
            <name>Renewal_Forecast2</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>ISPICKVAL(Status__c, &quot;Renewal Forecasted&quot;)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Renewal Quoted</fullName>
        <actions>
            <name>Forecast_Renewal_Quote</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>ISPICKVAL(Status__c, &quot;Renewal Quoted&quot;)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
