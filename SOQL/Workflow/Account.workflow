<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>AccountModified</fullName>
        <description>Notify the account owner when someone else updates the account if the account&apos;s annual revenue is greater than $1,000,000.</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/AccountModified</template>
    </alerts>
    <rules>
        <fullName>AccountModified</fullName>
        <actions>
            <name>AccountModified</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Notify the account owner when someone else updates the account if the account&apos;s annualrevenue is greater than $1,000,000.</description>
		<formula>AND(
			LastModifiedDate &lt;&gt; CreatedDate,
			LastModifiedById &lt;&gt;  OwnerId,
			AnnualRevenue &gt; 1000000 
		)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
