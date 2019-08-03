<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Email_student_about_record_update</fullName>
        <description>Email student about record update</description>
        <protected>false</protected>
        <recipients>
            <field>Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/StudentRecordUpdate</template>
    </alerts>
    <fieldUpdates>
        <fullName>AutoUpdateMarriedCheckbox</fullName>
        <field>Married__c</field>
        <literalValue>1</literalValue>
        <name>AutoUpdateMarriedCheckbox</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>StudentRecordUpdate</fullName>
        <actions>
            <name>Email_student_about_record_update</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Add a workflow rule to send email to student when His record gets update.</description>
        <formula>LastModifiedDate &lt;&gt;  CreatedDate</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>UpdateMarriedStatus</fullName>
        <actions>
            <name>AutoUpdateMarriedCheckbox</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>If any student have wife name then automatically its married = true.</description>
        <formula>NOT(ISBLANK(Spouse_Name__c))</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
