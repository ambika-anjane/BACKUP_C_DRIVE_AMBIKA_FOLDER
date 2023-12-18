with SQ_CUST_ACCNT as(
    select * from {{ ref("stg__apps.hz_accounts") }}),
    parties as (select * from {{ ref("stg__apps.hz_parties")}})
) 


select 
	prties.PARTY_NAME	   C1_NAME,
	SQ_CUST_ACCNT.PARTY_ID	   C2_PARTY_ID,
	COALESCE(SQ_CUST_ACCNT.ACCOUNT_TYPE_CODE,'__UNASSIGNED__')	   C3_ACCOUNT_TYPE_CODE,
	COALESCE(SQ_CUST_ACCNT.ACCOUNT_CLASS_CODE,'__UNASSIGNED__')	   C4_ACCOUNT_CLASS_CODE,
	SQ_CUST_ACCNT.ACTIVE_FLG	   C5_ACTIVE_FLG,
	SQ_CUST_ACCNT_FREIGHT_BU_CODE.FREIGHT_TERM_CODE	   C6_FRGHT_TERMS_CODE,
	SQ_CUST_ACCNT.ACCOUNT_SINCE_DATE	   C7_ACCOUNT_SINCE_DT,
	SQ_CUST_ACCNT.ACCOUNT_NUM	   C8_ACCOUNT_NUM,
	TO_CHAR(SQ_CUST_ACCNT.PAY_TERMS_CODE)	   C9_PAY_TERMS_CODE,
	SQ_CUST_ACCNT.CREATED_BY_ID	   C10_CREATED_BY_ID,
	SQ_CUST_ACCNT.CHANGED_BY_ID	   C11_CHANGED_BY_ID,
	SQ_CUST_ACCNT.CREATED_ON_DT	   C12_CREATED_ON_DT,
	SQ_CUST_ACCNT.CHANGED_ON_DT	   C13_CHANGED_ON_DT,
	SQ_CUST_ACCNT.DELETE_FLG	   C14_DELETE_FLG,
	TO_CHAR(SQ_CUST_ACCNT.CUST_ACCOUNT_ID)	   C15_INTEGRATION_ID,
	SQ_CUST_ACCNT.X_CUSTOM	   C16_X_CUSTOM,
	SQ_CUST_ACCNT.TAX_CODE	   C17_TAX_CODE,
	SQ_CUST_ACCNT.AUTOPAY_FLG	   C18_AUTOPAY_FLG,
	SQ_CUST_ACCNT.HOLD_BILL_FLG	   C19_HOLD_BILL_FLG,
	SQ_CUST_ACCNT.X_ORIG_SYSTEM_REFERENCE	   C20_X_ORIG_SYSTEM_REFERENCE,
	SQ_CUST_ACCNT.X_TP_CODE	   C21_X_TP_CODE,
	SQ_CUST_ACCNT.X_CUSTOMER_GROUP	   C22_X_CUSTOMER_GROUP,
	SQ_CUST_ACCNT.X_LOB	   C23_X_LOB,
	SQ_CUST_ACCNT.X_HF_REGION	   C24_X_HF_REGION,
	SQ_CUST_ACCNT.X_PRIMARY_CHANNEL	   C25_X_PRIMARY_CHANNEL,
	SQ_CUST_ACCNT.X_SECONDARY_CHANNEL	   C26_X_SECONDARY_CHANNEL,
	SQ_CUST_ACCNT.X_SUB_PARTNER	   C27_X_SUBPARTNER,
	SQ_CUST_ACCNT.COLLECTOR_NAME	   C28_X_COLLECTOR_NAME,
	SQ_CUST_ACCNT.COLLECTOR_DESCRIPTION	   C29_X_COLLECTOR_DESCRIPTION,
	SQ_CUST_ACCNT.X_GROUP_MEMBERSHIP	   C30_X_GROUP_MEMBERSHIP,
	SQ_CUST_ACCNT_FREIGHT_BU_CODE.BU_ACCOUNT_CODE	   C31_X_BU_ACCOUNT_CODE
from	
    'N' DELETE_FLG
from  
    SQ_CUST_ACCNT, parties
where (1=1)
