<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>FieldExperienceUpdated</fullName>
        <description>Send Email when Field experience updated</description>
        <protected>false</protected>
        <recipients>
            <field>Email</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/ExperiencedTeacher</template>
    </alerts>
    <rules>
        <fullName>ContactBirthday</fullName>
        <active>true</active>
        <description>Send an email to the contact two days before the contact&apos;s birthday.</description>
        <formula>AND(
NOT(ISBLANK( Birthdate )),
NOT(ISBLANK(  Email ))
)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <offsetFromField>Contact.Birthdate</offsetFromField>
            <timeLength>-2</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>ExperiencedTeacher</fullName>
        <actions>
            <name>FieldExperienceUpdated</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Add workflow to teacher(insert/update) if his experience is more then 5 then send mail</description>
        <formula>AND(
 LastModifiedDate &lt;&gt;  CreatedDate,
 Field_Experience__c &gt; 5
)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
