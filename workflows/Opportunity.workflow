<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Margin</fullName>
        <field>Margin__c</field>
        <formula>SBQQ__PrimaryQuote__r.Margin__c</formula>
        <name>Margin %</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Mark_Opportunity_Contracted</fullName>
        <field>SBQQ__Contracted__c</field>
        <literalValue>1</literalValue>
        <name>Mark Opportunity Contracted</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Ordered</fullName>
        <field>SBQQ__Ordered__c</field>
        <literalValue>1</literalValue>
        <name>Ordered</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_ACV</fullName>
        <field>ACV_1st_Year__c</field>
        <formula>SBQQ__PrimaryQuote__r.ACV_1st_Year__c</formula>
        <name>Set ACV</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_ARR</fullName>
        <field>ARR__c</field>
        <formula>SBQQ__PrimaryQuote__r.Total_ARR__c</formula>
        <name>Set ARR</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_MRR</fullName>
        <field>MRR__c</field>
        <formula>SBQQ__PrimaryQuote__r.Total_MRR__c</formula>
        <name>Set MRR</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Margin_Amt</fullName>
        <field>Margin_Amt__c</field>
        <formula>SBQQ__PrimaryQuote__r.Margin__c * SBQQ__PrimaryQuote__r.SBQQ__NetAmount__c</formula>
        <name>Set Margin Amt</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_NRR</fullName>
        <field>NRR__c</field>
        <formula>SBQQ__PrimaryQuote__r.Total_NRR__c</formula>
        <name>Set NRR</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_TCV</fullName>
        <field>TCV__c</field>
        <formula>SBQQ__PrimaryQuote__r.Total_TCV__c</formula>
        <name>Set TCV</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Ordered When Quick</fullName>
        <actions>
            <name>Ordered</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>SBQQ__PrimaryQuote__r.Quick__c &amp;&amp;   Amount &lt;&gt; 0</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Set Deal Desk fields on Opp</fullName>
        <actions>
            <name>Margin</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Set_ACV</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Set_ARR</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Set_MRR</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Set_Margin_Amt</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Set_NRR</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Set_TCV</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Sets Deal Desk information from Primary Quote on the Opportunity.</description>
        <formula>SBQQ__PrimaryQuote__r.SBQQ__Primary__c = true</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
