<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Margin_Quantity</fullName>
        <field>Margin_Quantity__c</field>
        <formula>IF( TEXT(SBQQ__Quote__r.SBQQ__Type__c) = &quot;Amendment&quot;, SBQQ__EffectiveQuantity__c,  SBQQ__Quantity__c )</formula>
        <name>Margin Quantity</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Level_1_Floor</fullName>
        <field>Level_1_Floor__c</field>
        <formula>SBQQ__RegularPrice__c  * 0.9</formula>
        <name>Set Level 1 Floor</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Level_2_Floor</fullName>
        <field>Level_2_Floor__c</field>
        <formula>SBQQ__RegularPrice__c  * 0.8</formula>
        <name>Set Level 2 Floor</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_MRR</fullName>
        <field>MRR__c</field>
        <formula>IF((ISPICKVAL(SBQQ__SubscriptionPricing__c,&quot;Fixed Price&quot;) || ISPICKVAL(SBQQ__SubscriptionPricing__c,&quot;Percent of Total&quot;))  &amp;&amp;  ( !ISPICKVAL( SBQQ__ChargeType__c , &apos;Usage&apos;) ),
IF(Calculated_Sub_Term__c &lt;&gt; 0.0 &amp;&amp; not(ISNULL(Calculated_Sub_Term__c)),SBQQ__NetTotal__c / Calculated_Sub_Term__c,0.0),0.0)</formula>
        <name>Set MRR</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Margin Quantity</fullName>
        <actions>
            <name>Margin_Quantity</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>true</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Set MRR</fullName>
        <actions>
            <name>Set_MRR</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>SBQQ__Quote__c.SBQQ__Status__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>SBQQ__QuoteLine__c.SBQQ__ChargeType__c</field>
            <operation>notEqual</operation>
            <value>Usage</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
