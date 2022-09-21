<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Send_Quote_Approved_Email</fullName>
        <description>Send Quote Approved Email</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Standard_Quote_Approval_Approved</template>
    </alerts>
    <alerts>
        <fullName>Send_Quote_Rejected_Email</fullName>
        <description>Send Quote Rejected Email</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Standard_Quote_Approval_Rejected</template>
    </alerts>
    <fieldUpdates>
        <fullName>AdvanceApprove</fullName>
        <field>ApprovalStatus__c</field>
        <literalValue>Approved</literalValue>
        <name>AdvanceApprove</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AdvancedRecall</fullName>
        <field>ApprovalStatus__c</field>
        <literalValue>Recalled</literalValue>
        <name>AdvancedRecall</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AdvancedReject</fullName>
        <field>ApprovalStatus__c</field>
        <literalValue>Rejected</literalValue>
        <name>AdvancedReject</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Advances_Status</fullName>
        <field>ApprovalStatus__c</field>
        <literalValue>Pending</literalValue>
        <name>Advances Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Competitor</fullName>
        <field>Competitor__c</field>
        <formula>&quot;WholeView&quot;</formula>
        <name>Competitor</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Customer_Type</fullName>
        <field>Customer_Type__c</field>
        <formula>if(ispickval(SBQQ__Account__r.Type, &apos;Customer&apos;),&apos;Existing&apos;,&apos;New&apos;)</formula>
        <name>Customer Type</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Draft_Watermark_Checked</fullName>
        <field>SBQQ__WatermarkShown__c</field>
        <literalValue>1</literalValue>
        <name>Draft Watermark Checked</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Draft_Watermark_Uncheck</fullName>
        <field>SBQQ__WatermarkShown__c</field>
        <literalValue>0</literalValue>
        <name>Draft Watermark Uncheck</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Partner_Profile</fullName>
        <field>EditLinesFieldSetName__c</field>
        <literalValue>Partner</literalValue>
        <name>Partner Profile</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Primary_When_Quick</fullName>
        <field>SBQQ__Primary__c</field>
        <literalValue>1</literalValue>
        <name>Primary When Quick</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Product_Mix</fullName>
        <field>Product_Mix__c</field>
        <formula>&quot;SmartBytes Core Bundle&quot;</formula>
        <name>Product Mix</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Region</fullName>
        <field>Region__c</field>
        <formula>SBQQ__BillingCountry__c</formula>
        <name>Region</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Date</fullName>
        <field>SBQQ__StartDate__c</field>
        <formula>CreatedDate</formula>
        <name>Set Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Quote_Expiration</fullName>
        <field>SBQQ__ExpirationDate__c</field>
        <formula>Today()+7</formula>
        <name>Set Quote Expiration</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Quote_Introduction</fullName>
        <field>SBQQ__Introduction__c</field>
        <formula>&quot;Greetings &quot; + 
BLANKVALUE(SBQQ__PrimaryContact__r.FirstName, TRIM(SBQQ__Account__r.Name)) + 
&quot; &quot; + 
BLANKVALUE(SBQQ__PrimaryContact__r.LastName,&quot;&quot;)+&quot;,&quot; 
+br()+br()+br()+&quot;Enclosed is the proposal I promised you.&quot;+br()+br()+&quot;I also want to take this opportunity to thank you for all your help. Designing a suitable solution required that I become familiar with your products and your industry. As a result, your help and guidance proved to be invaluable and ultimately resulted in a better, more cost effective solution for your organization.&quot;+br()+br()+&quot;I will call you next week to discuss this proposal. As always, please don’t hesitate to call me if you have questions or if I can be of further assistance.&quot;+br()+br()+&quot;I hope we can continue working together into the future.&quot;+br()+br()+br()+&quot;With best regards,&quot; + br()+br() 
+$User.FirstName + &quot; &quot; + $User.LastName + br() + 
$User.Title + br() + $User.Email</formula>
        <name>Set Quote Introduction</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Quote_Status_Approved</fullName>
        <field>SBQQ__Status__c</field>
        <literalValue>Approved</literalValue>
        <name>Set Quote Status - Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Quote_Status_Denied</fullName>
        <field>SBQQ__Status__c</field>
        <literalValue>Denied</literalValue>
        <name>Set Quote Status - Denied</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Quote_Status_Draft</fullName>
        <field>SBQQ__Status__c</field>
        <literalValue>Draft</literalValue>
        <name>Set Quote Status - Draft</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Quote_Status_In_Review</fullName>
        <field>SBQQ__Status__c</field>
        <literalValue>In Review</literalValue>
        <name>Set Quote Status - In Review</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Renewal_Uplift</fullName>
        <field>SBQQ__RenewalUpliftRate__c</field>
        <formula>0.03</formula>
        <name>Set Renewal Uplift</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Start_Date</fullName>
        <field>SBQQ__StartDate__c</field>
        <formula>IF(ISBLANK(SBQQ__StartDate__c) , CreatedDate,  DATETIMEVALUE(SBQQ__StartDate__c))</formula>
        <name>Set Start Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Status_In_Review</fullName>
        <field>SBQQ__Status__c</field>
        <literalValue>In Review</literalValue>
        <name>Set Status - In Review</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Sub_Term</fullName>
        <field>SBQQ__SubscriptionTerm__c</field>
        <formula>12</formula>
        <name>Set Sub Term</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Sub_Terms</fullName>
        <field>SBQQ__SubscriptionTerm__c</field>
        <formula>if( ISBLANK(SBQQ__SubscriptionTerm__c), 12, SBQQ__SubscriptionTerm__c)</formula>
        <name>Set Sub Term</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Vertical</fullName>
        <field>Vertical__c</field>
        <formula>TEXT( SBQQ__Account__r.Industry )</formula>
        <name>Vertical</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Draft Watermark</fullName>
        <actions>
            <name>Draft_Watermark_Checked</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>SBQQ__Quote__c.SBQQ__Status__c</field>
            <operation>equals</operation>
            <value>Draft,In Review,Denied,Rejected</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Draft Watermark Uncheck</fullName>
        <actions>
            <name>Draft_Watermark_Uncheck</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>SBQQ__Quote__c.ApprovalStatus__c</field>
            <operation>equals</operation>
            <value>Approved</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Einstein Discovery Insight Values</fullName>
        <actions>
            <name>Competitor</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Customer_Type</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Product_Mix</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Region</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Vertical</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>Name  &lt;&gt; NULL</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Initialize Quote</fullName>
        <actions>
            <name>Set_Quote_Expiration</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Set_Quote_Introduction</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Set_Renewal_Uplift</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Set_Start_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Set_Sub_Terms</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>true</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Set Partner Profile in Community</fullName>
        <actions>
            <name>Partner_Profile</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>SBQQ__Quote__c.Channel_Level__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Set Quote Status - In Review</fullName>
        <actions>
            <name>Set_Status_In_Review</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>SBQQ__Quote__c.ApprovalStatus__c</field>
            <operation>equals</operation>
            <value>Pending</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
