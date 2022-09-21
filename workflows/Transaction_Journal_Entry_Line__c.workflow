<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Posted</fullName>
        <field>Posted__c</field>
        <literalValue>1</literalValue>
        <name>Posted</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Posting_Date</fullName>
        <field>Posting_Date__c</field>
        <formula>today()</formula>
        <name>Posting Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Journal Entry Line Posting</fullName>
        <actions>
            <name>Posted</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Posting_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Transaction_Journal_Entry_Line__c.Posting_Status__c</field>
            <operation>equals</operation>
            <value>Posted</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
