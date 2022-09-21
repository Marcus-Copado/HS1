<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Parent_Account_Change</fullName>
        <description>Parent Account Change</description>
        <protected>false</protected>
        <recipients>
            <type>accountOwner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/ParentAccountRemoved</template>
    </alerts>
    <rules>
        <fullName>Parent Account Removed</fullName>
        <active>false</active>
        <formula>ISNULL(ParentId)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
