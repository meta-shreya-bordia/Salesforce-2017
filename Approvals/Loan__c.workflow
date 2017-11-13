<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Approval_Requests_Pending</fullName>
        <description>Approval Requests Pending</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Loan_Approval_Request</template>
    </alerts>
    <alerts>
        <fullName>Loan_Apporved</fullName>
        <description>Loan Apporved</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Loan_Approved</template>
    </alerts>
    <alerts>
        <fullName>Loan_Approval_Process_Alert</fullName>
        <description>Loan Approval Process Alert</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Loan_Approval_Request</template>
    </alerts>
    <alerts>
        <fullName>Loan_Rejected</fullName>
        <description>Loan Rejected</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Loan_Rejection</template>
    </alerts>
    <alerts>
        <fullName>Loan_Requests_Pending</fullName>
        <description>Loan Requests Pending</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Loan_Approval_Request</template>
    </alerts>
    <alerts>
        <fullName>Mail_Approval</fullName>
        <description>Mail should be sent to Owner on Approving and Rejecting of the Loan</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Loan_Approved</template>
    </alerts>
    <alerts>
        <fullName>Mail_Rejection</fullName>
        <description>Mail should be sent to Owner on Approving and Rejecting of the Loan</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Loan_Rejection</template>
    </alerts>
</Workflow>
