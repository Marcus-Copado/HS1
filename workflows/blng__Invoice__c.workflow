<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Dunning_Email</fullName>
        <description>Dunning Email</description>
        <protected>false</protected>
        <recipients>
            <field>blng__BillToContact__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/EInvoiceDunning</template>
    </alerts>
    <alerts>
        <fullName>Invoice_Email_Send</fullName>
        <description>Invoice Email Send</description>
        <protected>false</protected>
        <recipients>
            <field>blng__BillToContact__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/EInvoiceEmail</template>
    </alerts>
    <alerts>
        <fullName>Send_Posted_Invoice</fullName>
        <description>Send Posted Invoice</description>
        <protected>false</protected>
        <recipients>
            <field>blng__BillToContact__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/EInvoiceEmail</template>
    </alerts>
    <fieldUpdates>
        <fullName>Contact_from_Order</fullName>
        <field>BilltoContactId__c</field>
        <formula>blng__Order__r.BillToContactId</formula>
        <name>Contact from Order</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Post</fullName>
        <field>blng__InvoiceStatus__c</field>
        <literalValue>Posted</literalValue>
        <name>Post</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Invoice Defaults - Created</fullName>
        <actions>
            <name>Contact_from_Order</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>true</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Invoice Posted and Emailed</fullName>
        <actions>
            <name>Invoice_Email_Send</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>ISPICKVAL( blng__InvoiceStatus__c ,&quot;Posted&quot; )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Post Invoice</fullName>
        <actions>
            <name>Post</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>blng__Invoice__c.Status_Auto__c</field>
            <operation>equals</operation>
            <value>Posted</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Timed Invoice Posted and Emailed</fullName>
        <active>true</active>
        <formula>ISPICKVAL( blng__InvoiceStatus__c ,&quot;Posted&quot; )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Send_Posted_Invoice</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>blng__Invoice__c.CreatedDate</offsetFromField>
            <timeLength>-1</timeLength>
            <workflowTimeTriggerUnit>Hours</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
</Workflow>
