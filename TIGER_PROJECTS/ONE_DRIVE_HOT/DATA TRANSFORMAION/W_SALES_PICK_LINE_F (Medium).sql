select	
	
	TO_CHAR(SQ_SALES_PCKLNS1.LINE_ID)	   C1_SALES_ORDLN_ID,
	TO_CHAR(SQ_SALES_PCKLNS1.LINE_ID)	   C2_SALES_SCHLN_ID,
	SQ_SALES_PCKLNS1.DELIVERY_ID	   C3_SALES_SHPMT_ID,
	TO_CHAR(SQ_SALES_PCKLNS1.INVENTORY_ITEM_ID)	   C4_PRODUCT_ID,
	TO_CHAR(SQ_SALES_PCKLNS1.INVENTORY_ITEM_ID) ||'~'||TO_CHAR(SQ_SALES_PCKLNS1.SHIP_FROM_ORG_ID)	   C5_SALES_PRODUCT_ID,
	TO_CHAR(SQ_SALES_PCKLNS1.INVENTORY_ITEM_ID)||'~'||TO_CHAR(SQ_SALES_PCKLNS1.SHIP_FROM_ORG_ID)	   C6_INVENTORY_PRODUCT_ID,
	'PLANT'||'~'||TO_CHAR(SQ_SALES_PCKLNS1.SHIP_FROM_ORG_ID)	   C7_PLANT_LOC_ID,
	'STORAGE_LOC'||'~'||TO_CHAR(SQ_SALES_PCKLNS1.SHIP_FROM_ORG_ID)||'~'||TO_CHAR(SQ_SALES_PCKLNS1.SUBINVENTORY)||'~'||SQ_SALES_PCKLNS1.LOCATOR_ID	   C8_STORAGE_LOC_ID,
	TO_CHAR(SQ_SALES_PCKLNS1.ORG_ID)	   C9_OPERATING_UNIT_ORG_ID,
	TO_CHAR(SQ_SALES_PCKLNS1.SHIP_FROM_ORG_ID)	   C10_INVENTORY_ORG_ID,
	TO_CHAR(SQ_SALES_PCKLNS1.ORG_ID)	   C11_SALES_ORG_ID,
	'SALES_PICKING_PROCESS~PICK_STATUS~'||SQ_SALES_PCKLNS1.RELEASED_STATUS	   C12_PICK_STATUS_ID,
	SQ_SALES_PCKLNS1.FREIGHT_TERMS_CODE	   C13_FREIGHT_TERMS_ID,
	SQ_SALES_PCKLNS1.CREATION_DATE	   C14_PICKING_DOC_DT,
	(CASE
WHEN SQ_SALES_PCKLNS1.PICKABLE_FLAG = 'Y' THEN SQ_SALES_PCKLNS1.SCHEDULE_SHIP_DATE
ELSE NULL
END )	   C15_PLAN_PICK_ON_DT,
	SQ_SALES_PCKLNS1.SCHEDULE_SHIP_DATE	   C16_PLAN_SHIP_ON_DT,
	(CASE
WHEN SQ_SALES_PCKLNS1.PICKABLE_FLAG = 'Y' THEN SQ_SALES_PCKLNS1.ACTUAL_SHIPMENT_DATE
ELSE NULL
END )	   C17_ACT_PICKED_ON_DT,
	(CASE
WHEN 
          SQ_SALES_PCKLNS1.RELEASED_STATUS = 'Y'  THEN 
          NULL
ELSE 
          SQ_SALES_PCKLNS1.ACTUAL_SHIPMENT_DATE
    
END ) 	   C18_ACT_SHIPPED_ON_DT,
	(CASE
WHEN SQ_SALES_PCKLNS1.PICKABLE_FLAG = 'Y' THEN 
(CASE
WHEN   
(TRUNC(SQ_SALES_PCKLNS1.SCHEDULE_SHIP_DATE)-TRUNC(SQ_SALES_PCKLNS1.ACTUAL_SHIPMENT_DATE)) - #BIAPPS.PICK_EARLY_TIME_TOL > 0 THEN  
     -1
ELSE  
     (CASE
WHEN  
(TRUNC(SQ_SALES_PCKLNS1.SCHEDULE_SHIP_DATE)-TRUNC(SQ_SALES_PCKLNS1.ACTUAL_SHIPMENT_DATE)) + #BIAPPS.PICK_LATE_TIME_TOL < 0 THEN  
1
ELSE  
0 

END ) 
  
END )
ELSE  NULL
END )

C19_PICKED_ONTIME_IND,
	(CASE
WHEN SQ_SALES_PCKLNS1.RELEASED_STATUS <> 'C' THEN  
NULL
ELSE 
(CASE
WHEN SQ_SALES_PCKLNS1.PICKABLE_FLAG = 'Y' THEN 
(CASE
WHEN   
(TRUNC(SQ_SALES_PCKLNS1.SCHEDULE_SHIP_DATE)-TRUNC(SQ_SALES_PCKLNS1.ACTUAL_SHIPMENT_DATE)) - #BIAPPS.SHIP_EARLY_TIME_TOL > 0 THEN  
     -1
ELSE  
     (CASE
WHEN  
(TRUNC(SQ_SALES_PCKLNS1.SCHEDULE_SHIP_DATE)-TRUNC(SQ_SALES_PCKLNS1.ACTUAL_SHIPMENT_DATE)) + #BIAPPS.SHIP_LATE_TIME_TOL < 0 THEN  
1
ELSE  
0 

END ) 
  
END )
ELSE  NULL
END )


END )	   C20_SHIPPED_ONTIME_IND,
	COALESCE(
	(CASE
WHEN 
		SQ_SALES_PCKLNS1.PICKABLE_FLAG='Y' THEN 
		(CASE
WHEN 
			SQ_SALES_PCKLNS1.RELEASED_STATUS = 'Y' THEN 
			SQ_SALES_PCKLNS1.PICKED_QUANTITY
ELSE 
			(CASE
WHEN 
				SQ_SALES_PCKLNS1.RELEASED_STATUS = 'C' OR SQ_SALES_PCKLNS1.RELEASED_STATUS='I' THEN 
				SQ_SALES_PCKLNS1.SHIPPED_QUANTITY
ELSE 
				NULL
			
END )
		
END )
ELSE 
		NULL
	
END ),
	0
) * SQ_SALES_PCKLNS1.UNIT_SELLING_PRICE	   C21_NET_AMT,
	COALESCE((CASE
WHEN SQ_SALES_PCKLNS1.PICKABLE_FLAG = 'Y' THEN SQ_SALES_PCKLNS1.REQUESTED_QUANTITY
ELSE NULL
END ),0)	   C22_PLAN_PICK_QTY,
	COALESCE(
	(CASE
WHEN 
		SQ_SALES_PCKLNS1.PICKABLE_FLAG='Y' THEN 
		(CASE
WHEN 
			SQ_SALES_PCKLNS1.RELEASED_STATUS = 'Y' THEN 
			SQ_SALES_PCKLNS1.PICKED_QUANTITY
ELSE 
			(CASE
WHEN 
				SQ_SALES_PCKLNS1.RELEASED_STATUS = 'C' OR SQ_SALES_PCKLNS1.RELEASED_STATUS='I' THEN 
				SQ_SALES_PCKLNS1.SHIPPED_QUANTITY
ELSE 
				NULL
			
END )
		
END )
ELSE 
		NULL
	
END ),
	0
)	   C23_ACT_PICKED_QTY,
	COALESCE(
	
		(CASE
WHEN (CASE
WHEN SQ_SALES_PCKLNS1.PICKABLE_FLAG = 'Y' THEN 
(CASE
WHEN   
(TRUNC(SQ_SALES_PCKLNS1.SCHEDULE_SHIP_DATE)-TRUNC(SQ_SALES_PCKLNS1.ACTUAL_SHIPMENT_DATE)) - #BIAPPS.PICK_EARLY_TIME_TOL > 0 THEN  
     -1
ELSE  
     (CASE
WHEN  
(TRUNC(SQ_SALES_PCKLNS1.SCHEDULE_SHIP_DATE)-TRUNC(SQ_SALES_PCKLNS1.ACTUAL_SHIPMENT_DATE)) + #BIAPPS.PICK_LATE_TIME_TOL < 0 THEN  
1
ELSE  
0 

END ) 
  
END )
ELSE  NULL
END )

= 0 THEN 
				(CASE
WHEN 
					SQ_SALES_PCKLNS1.RELEASED_STATUS = 'Y' THEN 
					SQ_SALES_PCKLNS1.PICKED_QUANTITY
ELSE 
					(CASE
WHEN 
						SQ_SALES_PCKLNS1.RELEASED_STATUS = 'C' OR SQ_SALES_PCKLNS1.RELEASED_STATUS='I' THEN 
						SQ_SALES_PCKLNS1.PICKED_QUANTITY
ELSE 
						NULL
					
END )
				
END )
ELSE 
			NULL
		
END ),
	0
)
	   C24_ACT_PICKED_ONTIME_QTY,
	COALESCE(
	(CASE
WHEN (CASE
WHEN SQ_SALES_PCKLNS1.PICKABLE_FLAG = 'Y' THEN 
(CASE
WHEN   
(TRUNC(SQ_SALES_PCKLNS1.SCHEDULE_SHIP_DATE)-TRUNC(SQ_SALES_PCKLNS1.ACTUAL_SHIPMENT_DATE)) - #BIAPPS.PICK_EARLY_TIME_TOL > 0 THEN  
     -1
ELSE  
     (CASE
WHEN  
(TRUNC(SQ_SALES_PCKLNS1.SCHEDULE_SHIP_DATE)-TRUNC(SQ_SALES_PCKLNS1.ACTUAL_SHIPMENT_DATE)) + #BIAPPS.PICK_LATE_TIME_TOL < 0 THEN  
1
ELSE  
0 

END ) 
  
END )
ELSE  NULL
END )

= -1 THEN 
					(CASE
WHEN 
					SQ_SALES_PCKLNS1.RELEASED_STATUS = 'Y' THEN 
					SQ_SALES_PCKLNS1.PICKED_QUANTITY
ELSE 
					(CASE
WHEN 
						SQ_SALES_PCKLNS1.RELEASED_STATUS = 'C' OR SQ_SALES_PCKLNS1.RELEASED_STATUS='I' THEN 
						SQ_SALES_PCKLNS1.SHIPPED_QUANTITY
ELSE 
						NULL
					    
END )
					 
END )
ELSE 
			NULL
		
END ),
	0
)	   C25_ACT_PICKED_EARLY_QTY,
	COALESCE(
		(CASE
WHEN (CASE
WHEN SQ_SALES_PCKLNS1.PICKABLE_FLAG = 'Y' THEN 
(CASE
WHEN   
(TRUNC(SQ_SALES_PCKLNS1.SCHEDULE_SHIP_DATE)-TRUNC(SQ_SALES_PCKLNS1.ACTUAL_SHIPMENT_DATE)) - #BIAPPS.PICK_EARLY_TIME_TOL > 0 THEN  
     -1
ELSE  
     (CASE
WHEN  
(TRUNC(SQ_SALES_PCKLNS1.SCHEDULE_SHIP_DATE)-TRUNC(SQ_SALES_PCKLNS1.ACTUAL_SHIPMENT_DATE)) + #BIAPPS.PICK_LATE_TIME_TOL < 0 THEN  
1
ELSE  
0 

END ) 
  
END )
ELSE  NULL
END )

= 1 THEN 
				(CASE
WHEN 
					SQ_SALES_PCKLNS1.RELEASED_STATUS = 'Y' THEN 
					SQ_SALES_PCKLNS1.PICKED_QUANTITY
ELSE 
					(CASE
WHEN 
						SQ_SALES_PCKLNS1.RELEASED_STATUS = 'C' OR SQ_SALES_PCKLNS1.RELEASED_STATUS='I' THEN 
						SQ_SALES_PCKLNS1.SHIPPED_QUANTITY
ELSE 
						NULL
					
END )
				
END )
ELSE 
				NULL
		
END ),
	0
)	   C26_ACT_PICKED_LATE_QTY,
	COALESCE( 
 (CASE
WHEN SQ_SALES_PCKLNS1.RELEASED_STATUS='Y' THEN 
                NULL
ELSE  
                SQ_SALES_PCKLNS1.SHIPPED_QUANTITY
END ),
0)	   C27_ACT_SHIPPED_QTY,
	COALESCE(
            (CASE
WHEN SQ_SALES_PCKLNS1.RELEASED_STATUS='Y' THEN 
                NULL
ELSE 
                (CASE
WHEN SQ_SALES_PCKLNS1.RELEASED_STATUS='C' OR SQ_SALES_PCKLNS1.RELEASED_STATUS='I' THEN 
                        (CASE
WHEN (CASE
WHEN SQ_SALES_PCKLNS1.PICKABLE_FLAG = 'Y' THEN 
(CASE
WHEN   
(TRUNC(SQ_SALES_PCKLNS1.SCHEDULE_SHIP_DATE)-TRUNC(SQ_SALES_PCKLNS1.ACTUAL_SHIPMENT_DATE)) - #BIAPPS.SHIP_EARLY_TIME_TOL > 0 THEN  
     -1
ELSE  
     (CASE
WHEN  
(TRUNC(SQ_SALES_PCKLNS1.SCHEDULE_SHIP_DATE)-TRUNC(SQ_SALES_PCKLNS1.ACTUAL_SHIPMENT_DATE)) + #BIAPPS.SHIP_LATE_TIME_TOL < 0 THEN  
1
ELSE  
0 

END ) 
  
END )
ELSE  NULL
END )

= 0 THEN 
                                SQ_SALES_PCKLNS1.SHIPPED_QUANTITY
ELSE 
                                NULL
END )
ELSE 
                        NULL
END )
                
END ),
            0
        )	   C28_ACT_SHIPPED_ONTIME_QTY,
	COALESCE(
            (CASE
WHEN SQ_SALES_PCKLNS1.RELEASED_STATUS='Y' THEN 
                NULL
ELSE 
                (CASE
WHEN SQ_SALES_PCKLNS1.RELEASED_STATUS='C' OR SQ_SALES_PCKLNS1.RELEASED_STATUS='I' THEN                         
(CASE
WHEN (CASE
WHEN SQ_SALES_PCKLNS1.PICKABLE_FLAG = 'Y' THEN 
(CASE
WHEN   
(TRUNC(SQ_SALES_PCKLNS1.SCHEDULE_SHIP_DATE)-TRUNC(SQ_SALES_PCKLNS1.ACTUAL_SHIPMENT_DATE)) - #BIAPPS.SHIP_EARLY_TIME_TOL > 0 THEN  
     -1
ELSE  
     (CASE
WHEN  
(TRUNC(SQ_SALES_PCKLNS1.SCHEDULE_SHIP_DATE)-TRUNC(SQ_SALES_PCKLNS1.ACTUAL_SHIPMENT_DATE)) + #BIAPPS.SHIP_LATE_TIME_TOL < 0 THEN  
1
ELSE  
0 

END ) 
  
END )
ELSE  NULL
END )

= -1 THEN 
                                SQ_SALES_PCKLNS1.SHIPPED_QUANTITY
ELSE 
                                NULL
END )
ELSE 
                        NULL
END )
		
END ),
            0
        )
	   C29_ACT_SHIPPED_EARLY_QTY,
	COALESCE(
            (CASE
WHEN SQ_SALES_PCKLNS1.RELEASED_STATUS='Y' THEN 
                NULL
ELSE 
                (CASE
WHEN SQ_SALES_PCKLNS1.RELEASED_STATUS='C' OR SQ_SALES_PCKLNS1.RELEASED_STATUS='I' THEN 
                        (CASE
WHEN (CASE
WHEN SQ_SALES_PCKLNS1.PICKABLE_FLAG = 'Y' THEN 
(CASE
WHEN   
(TRUNC(SQ_SALES_PCKLNS1.SCHEDULE_SHIP_DATE)-TRUNC(SQ_SALES_PCKLNS1.ACTUAL_SHIPMENT_DATE)) - #BIAPPS.SHIP_EARLY_TIME_TOL > 0 THEN  
     -1
ELSE  
     (CASE
WHEN  
(TRUNC(SQ_SALES_PCKLNS1.SCHEDULE_SHIP_DATE)-TRUNC(SQ_SALES_PCKLNS1.ACTUAL_SHIPMENT_DATE)) + #BIAPPS.SHIP_LATE_TIME_TOL < 0 THEN  
1
ELSE  
0 

END ) 
  
END )
ELSE  NULL
END )

= 1 THEN 
                                SQ_SALES_PCKLNS1.SHIPPED_QUANTITY
ELSE 
                                NULL
END )
ELSE 
                        NULL
END )
                
END ),
            0
        )	   C30_ACT_SHIPPED_LATE_QTY,
	SQ_SALES_PCKLNS1.NET_WEIGHT 	   C31_NET_WEIGHT,
	SQ_SALES_PCKLNS1.VOLUME	   C32_VOLUME,
	COALESCE(SQ_SALES_PCKLNS1.ORDER_QUANTITY_UOM,'__UNASSIGNED__')	   C33_SALES_UOM_CODE,
	COALESCE(SQ_SALES_PCKLNS1.WEIGHT_UOM_CODE,'__UNASSIGNED__')	   C34_UOW_CODE,
	COALESCE(SQ_SALES_PCKLNS1.VOLUME_UOM_CODE,'__UNASSIGNED__')	   C35_UOV_CODE,
	TO_CHAR(SQ_SALES_PCKLNS1.ORDER_NUMBER)	   C36_SALES_ORDER_NUM,
	TO_CHAR(SUBSTR(SQ_SALES_PCKLNS1.SOURCE_LINE_NUMBER,1,DECODE(INSTR(SQ_SALES_PCKLNS1.SOURCE_LINE_NUMBER,'.'),0,1,INSTR(SQ_SALES_PCKLNS1.SOURCE_LINE_NUMBER,'.')-1)))	   C37_SALES_ORDER_ITEM,
	SQ_SALES_PCKLNS1.DELETE_FLG	   C38_DELETE_FLG,
	SQ_SALES_PCKLNS1.CREATION_DATE	   C39_EXCHANGE_DT,
	TO_CHAR(SQ_SALES_PCKLNS1.CREATED_BY )	   C40_CREATED_BY_ID,
	TO_CHAR(SQ_SALES_PCKLNS1.LAST_UPDATED_BY )	   C41_CHANGED_BY_ID,
	SQ_SALES_PCKLNS1.CREATION_DATE 	   C42_CREATED_ON_DT,
	SQ_SALES_PCKLNS1.LAST_UPDATE_DATE 	   C43_CHANGED_ON_DT,
	SQ_SALES_PCKLNS1.LAST_UPDATE_DATE2	   C44_AUX1_CHANGED_ON_DT,
	TO_CHAR(SQ_SALES_PCKLNS1.DELIVERY_DETAIL_ID)	   C45_INTEGRATION_ID,
	SQ_SALES_PCKLNS1.X_CUSTOM	   C46_X_CUSTOM,
	COALESCE((CASE
WHEN SQ_SALES_PCKLNS1.PICKABLE_FLAG = 'Y' THEN SQ_SALES_PCKLNS1.REQUESTED_QUANTITY
ELSE NULL
END ),0)	   C47_PLAN_SHIP_QTY,
	COALESCE(SQ_SALES_PCKLNS1.REQUESTED_QUANTITY_UOM,'__UNASSIGNED__') 	   C48_UOM_CODE,
	TO_CHAR(SQ_SALES_PCKLNS1.SOURCE_LINE_ID)	   C49_FULFILL_ORDER_LINE_ID,
	TO_CHAR(SQ_SALES_PCKLNS1.SOURCE_HEADER_ID)	   C50_FULFILL_ORDER_ID,
	TO_CHAR(SQ_SALES_PCKLNS1.SOURCE_LINE_NUMBER)	   C51_FULFILL_ORDER_LINE_NUM,
	TO_CHAR(SQ_SALES_PCKLNS1.SOURCE_HEADER_NUMBER)	   C52_FULFILL_ORDER_NUM,
	SQ_SALES_PCKLNS1.CREATION_DATE	   C53_PICK_RELEASE_DT,
	(CASE
WHEN SQ_SALES_PCKLNS1.RELEASED_STATUS <> 'C' THEN 
                NULL
ELSE  
                SQ_SALES_PCKLNS1.SHIP_CONFIRM_DATE
END )
	   C54_SHIP_CONFIRM_DT,
	TO_CHAR(SQ_SALES_PCKLNS1.SOURCE_LINE_NUMBER)	   C55_FULFILL_LINE_NUM,
	TO_CHAR(SQ_SALES_PCKLNS1.SOURCE_LINE_ID)	   C56_FULFILL_LINE_ID,
	SQ_SALES_PCKLNS1.X_DELIVERY_STATUS	   C57_X_DELIVERY_STATUS,
	SQ_SALES_PCKLNS1.X_PICK_RELEASE_DATE	   C58_X_PICK_RELEASE_DATE,
	SQ_SALES_PCKLNS1.X_DATE_REQUESTED	   C59_X_DATE_REQUESTED,
	SQ_SALES_PCKLNS1.X_DATE_ORDERED	   C60_X_DATE_ORDERED,
	SQ_SALES_PCKLNS1.X_ORDER_TYPE_ID	   C61_X_ORDER_TYPE_ID,
	SQ_SALES_PCKLNS1.X_CUST_PO	   C62_X_CUST_PO,
	SQ_SALES_PCKLNS1.X_REQUEST_DATE_TYPE	   C63_X_REQUEST_DATE_TYPE,
	SQ_SALES_PCKLNS1.X_LATEST_ACCEPTABLE_DATE	   C64_X_LATEST_ACCEPTABLE_DATE,
	SQ_SALES_PCKLNS1.X_ETD	   C65_X_ETD,
	SQ_SALES_PCKLNS1.X_ETA	   C66_X_ETA,
	SQ_SALES_PCKLNS1.X_PROMISE_DATE	   C67_X_PROMISE_DATE,
	SQ_SALES_PCKLNS1.X_PLANNED_DEPARTURE_DATE	   C68_X_PLANNED_DEPARTURE_DATE,
	SQ_SALES_PCKLNS1.X_EARLIEST_ACCEPTABLE_DATE	   C69_X_EARLIEST_ACCEPTABLE_DATE,
	SQ_SALES_PCKLNS1.X_TRIP_ID	   C70_X_TRIP_ID,
	SQ_SALES_PCKLNS1.X_MODE_OF_TRANSPORT	   C71_X_MODE_OF_TRANSPORT,
	SQ_SALES_PCKLNS1.X_CUST_BILL_TO_REV_ACCT_ID	   C72_X_CUST_BILL_TO_REV_ACCT_ID,
	SQ_SALES_PCKLNS1.X_TRACKING_NUMBER	   C73_X_TRACKING_NUMBER,
	SQ_SALES_PCKLNS1.X_SHIPPING_METHOD_CODE	   C74_X_SHIPPING_METHOD,
	SQ_SALES_PCKLNS1.X_DEMAND_CLASS	   C75_X_DEMAND_CLASS,
	SQ_SALES_PCKLNS1.X_TERRITORY_ID	   C76_X_TERRITORY_ID,
	SQ_SALES_PCKLNS1.SHIP_TO_ORG_ID	   C77_X_SHIPTO_SITE_USE_ID,
	SQ_SALES_PCKLNS1.INVOICE_TO_ORG_ID	   C78_X_BILLTO_SITE_USE_ID,
	SQ_SALES_PCKLNS1.X_GENERIC_CUSTOMER_ID	   C79_X_GENERIC_CUSTOMER_ID,
	SQ_SALES_PCKLNS1.X_SHIP_AIR	   C80_X_SHIP_AIR,
	SQ_SALES_PCKLNS1.X_VESSEL_NAME	   C81_X_VESSEL_NAME,
	SQ_SALES_PCKLNS1.X_VESSEL_NUMBER	   C82_X_VESSEL_NUMBER,
	SQ_SALES_PCKLNS1.X_BOL_NUMBER	   C83_X_BOL_NUMBER,
	SQ_SALES_PCKLNS1.X_CONTAINER_NUMBER	   C84_X_CONTAINER_NUMBER,
	SQ_SALES_PCKLNS1.X_CARTON_NUM_F	   C85_X_CARTON_NUM_F,
	SQ_SALES_PCKLNS1.X_CARTON_NUM_T	   C86_X_CARTON_NUM_T,
	SQ_SALES_PCKLNS1.X_LOADING	   C87_X_LOADING,
	SQ_SALES_PCKLNS1.X_DESTINATION	   C88_X_DESTINATION,
	SQ_SALES_PCKLNS1.X_CUSTOMER_ITEM_NUMBER	   C89_X_CUSTOMER_ITEM_NUMBER,
	SQ_SALES_PCKLNS1.X_ORDER_STATUS_ID	   C90_X_ORDER_STATUS_ID,
	SQ_SALES_PCKLNS1.LINE_NUMBER	   C91_X_LINE_NUMBER,
	SQ_SALES_PCKLNS1.SHIPMENT_NUMBER	   C92_X_SHIPMENT_NUMBER,
	SQ_SALES_PCKLNS1.UNIT_SELLING_PRICE	   C93_X_UNIT_SELLING_PRICE,
	SQ_SALES_PCKLNS1.X_SHIP_METHOD_MEANING	   C94_X_SHIP_METHOD_MEANING,
	SQ_SALES_PCKLNS1.SOURCE_LINE_NUMBER	   C95_SOURCE_LINE_NUMBER,
	SQ_SALES_PCKLNS1.SOLD_TO_ORG_ID	   C96_SOLD_TO_ORG_ID,
	SQ_SALES_PCKLNS1.SHIP_TO_CONTACT_ID	   C97_SHIP_TO_CONTACT_ID,
	SQ_SALES_PCKLNS1.ORDERED_DATE	   C98_ORDERED_DATE
from	
( /* Subselect from SDE_ORA_SalesPickLinesFact.W_SALES_PICK_LINE_FS_SQ_SALES_PCKLNS
*/
select 
	  /*+ USE_NL (WSH_DELIVERY_DETAILS, OE_ORDER_HEADERS_ALL,  OE_ORDER_LINES_ALL, ) */

	   WSH_DELIVERY_DETAILS.SOURCE_LINE_ID LINE_ID,
	WSH_DELIVERY_DETAILS.INVENTORY_ITEM_ID INVENTORY_ITEM_ID,
	WSH_DELIVERY_DETAILS.ORGANIZATION_ID SHIP_FROM_ORG_ID,
	WSH_DELIVERY_DETAILS.SHIP_TO_SITE_USE_ID SHIP_TO_ORG_ID,
	WSH_NEW_DELIVERIES.INITIAL_PICKUP_DATE ACTUAL_SHIPMENT_DATE,
	WSH_DELIVERY_DETAILS.DATE_SCHEDULED SCHEDULE_SHIP_DATE,
	OE_ORDER_LINES_ALL.UNIT_SELLING_PRICE UNIT_SELLING_PRICE,
	WSH_DELIVERY_DETAILS.SRC_REQUESTED_QUANTITY_UOM ORDER_QUANTITY_UOM,
	WSH_DELIVERY_DETAILS.DELIVERY_DETAIL_ID DELIVERY_DETAIL_ID,
	WSH_DELIVERY_DETAILS.SHIP_TO_CONTACT_ID SHIP_TO_CONTACT_ID,
	WSH_DELIVERY_DETAILS.SUBINVENTORY SUBINVENTORY,
	WSH_DELIVERY_DETAILS.RELEASED_STATUS RELEASED_STATUS,
	WSH_DELIVERY_DETAILS.SHIP_METHOD_CODE SHIP_METHOD_CODE,
	WSH_DELIVERY_DETAILS.CREATED_BY CREATED_BY,
	WSH_DELIVERY_DETAILS.LAST_UPDATED_BY LAST_UPDATED_BY,
	WSH_DELIVERY_DETAILS.CREATION_DATE CREATION_DATE,
  WSH_DELIVERY_DETAILS.LAST_UPDATE_DATE
 LAST_UPDATE_DATE,
	WSH_DELIVERY_DETAILS.SHIPPED_QUANTITY SHIPPED_QUANTITY,
	WSH_DELIVERY_DETAILS.REQUESTED_QUANTITY REQUESTED_QUANTITY,
	WSH_DELIVERY_DETAILS.NET_WEIGHT NET_WEIGHT,
	WSH_DELIVERY_DETAILS.VOLUME VOLUME,
	WSH_DELIVERY_DETAILS.WEIGHT_UOM_CODE WEIGHT_UOM_CODE,
	WSH_DELIVERY_DETAILS.VOLUME_UOM_CODE VOLUME_UOM_CODE,
	WSH_DELIVERY_DETAILS.SHIPMENT_PRIORITY_CODE SHIPMENT_PRIORITY_CODE,
	WSH_DELIVERY_DETAILS.SOURCE_HEADER_ID HEADER_ID,
	WSH_DELIVERY_DETAILS.ORG_ID ORG_ID,
	WSH_DELIVERY_DETAILS.CUSTOMER_ID SOLD_TO_ORG_ID,
	OE_ORDER_LINES_ALL.INVOICE_TO_ORG_ID INVOICE_TO_ORG_ID,
	OE_ORDER_HEADERS_ALL.ORDERED_DATE ORDERED_DATE,
	WSH_DELIVERY_DETAILS.FREIGHT_TERMS_CODE FREIGHT_TERMS_CODE,
	OE_ORDER_LINES_ALL.SHIPMENT_NUMBER SHIPMENT_NUMBER,
	WSH_DELIVERY_DETAILS.SOURCE_HEADER_NUMBER ORDER_NUMBER,
	OE_ORDER_LINES_ALL.LINE_NUMBER LINE_NUMBER,
	WSH_DELIVERY_DETAILS.LOCATOR_ID LOCATOR_ID,
	WSH_DELIVERY_DETAILS.REQUESTED_QUANTITY_UOM REQUESTED_QUANTITY_UOM,
	WSH_DELIVERY_DETAILS.PICKABLE_FLAG PICKABLE_FLAG,
	WSH_DELIVERY_DETAILS.PICKED_QUANTITY PICKED_QUANTITY,
	
WSH_NEW_DELIVERIES.LAST_UPDATE_DATE
 LAST_UPDATE_DATE2,
	WSH_DELIVERY_DETAILS.SOURCE_HEADER_NUMBER SOURCE_HEADER_NUMBER,
	WSH_DELIVERY_DETAILS.SOURCE_LINE_NUMBER SOURCE_LINE_NUMBER,
	WSH_DELIVERY_DETAILS.SOURCE_HEADER_ID SOURCE_HEADER_ID,
	WSH_DELIVERY_DETAILS.SOURCE_LINE_ID SOURCE_LINE_ID,
	WSH_NEW_DELIVERIES.DELIVERY_ID DELIVERY_ID,
	'0' X_CUSTOM,
	WSH_NEW_DELIVERIES.CONFIRM_DATE SHIP_CONFIRM_DATE,
   'N'
 DELETE_FLG,
	WSH_NEW_DELIVERIES.STATUS_CODE X_DELIVERY_STATUS,
	TRUNC(WSH_PICKING_BATCHES.CREATION_DATE) X_PICK_RELEASE_DATE,
	TRUNC(WSH_DELIVERY_DETAILS.DATE_REQUESTED) X_DATE_REQUESTED,
	TRUNC(OE_ORDER_HEADERS_ALL.ORDERED_DATE) X_DATE_ORDERED,
	CASE WHEN OE_ORDER_LINES_ALL.SOURCE_TYPE_CODE = 'INTERNAL'
THEN
'SALES_ORDLNS~' || OE_ORDER_LINES_ALL.line_category_code || '~' || TO_CHAR (OE_ORDER_HEADERS_ALL.order_type_id)|| '~SELF SHIP'
ELSE     
'SALES_ORDLNS~'|| OE_ORDER_LINES_ALL.line_category_code|| '~' || TO_CHAR (OE_ORDER_HEADERS_ALL.order_type_id) || '~DROP SHIP'
END X_ORDER_TYPE_ID,
	OE_ORDER_HEADERS_ALL.CUST_PO_NUMBER X_CUST_PO,
	OE_ORDER_HEADERS_ALL.ORDER_DATE_TYPE_CODE X_REQUEST_DATE_TYPE,
	OE_ORDER_LINES_ALL.LATEST_ACCEPTABLE_DATE X_LATEST_ACCEPTABLE_DATE,
	CASE WHEN LENGTH(WSH_NEW_DELIVERIES.ATTRIBUTE2)=11 AND INSTR(WSH_NEW_DELIVERIES.ATTRIBUTE2,'-',1,1)=3  AND INSTR(WSH_NEW_DELIVERIES.ATTRIBUTE2,'-',1,2)=7 AND
SUBSTR(UPPER(WSH_NEW_DELIVERIES.ATTRIBUTE2),4,3) IN ('JAN','FEB','MAR','APR','MAY','JUN','JUL','AUG','SEP','OCT','NOV','DEC') AND 
SUBSTR(UPPER(WSH_NEW_DELIVERIES.ATTRIBUTE2),1,2) IN ('01','02','03','04','05','06','07','08','09','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24','25','26','27','28','29','30','31')
 THEN TO_DATE(WSH_NEW_DELIVERIES.ATTRIBUTE2,'DD-MON-YYYY') ELSE NULL END X_ETD,
	CASE WHEN LENGTH(WSH_NEW_DELIVERIES.ATTRIBUTE3)=11 AND INSTR(WSH_NEW_DELIVERIES.ATTRIBUTE3,'-',1,1)=3  AND INSTR(WSH_NEW_DELIVERIES.ATTRIBUTE3,'-',1,2)=7 AND
SUBSTR(UPPER(WSH_NEW_DELIVERIES.ATTRIBUTE3),4,3) IN ('JAN','FEB','MAR','APR','MAY','JUN','JUL','AUG','SEP','OCT','NOV','DEC') AND 
SUBSTR(UPPER(WSH_NEW_DELIVERIES.ATTRIBUTE3),1,2) IN ('01','02','03','04','05','06','07','08','09','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24','25','26','27','28','29','30','31')
 THEN TO_DATE(WSH_NEW_DELIVERIES.ATTRIBUTE3,'DD-MON-YYYY') ELSE NULL END X_ETA,
	TRUNC(OE_ORDER_LINES_ALL.PROMISE_DATE) X_PROMISE_DATE,
	(WSH_TRIP_STOPS.PLANNED_DEPARTURE_DATE) X_PLANNED_DEPARTURE_DATE,
	OE_ORDER_LINES_ALL.EARLIEST_ACCEPTABLE_DATE X_EARLIEST_ACCEPTABLE_DATE,
	WSH_TRIP_STOPS.TRIP_ID X_TRIP_ID,
	WSH_CARRIER_SERVICES.MODE_OF_TRANSPORT X_MODE_OF_TRANSPORT,
	null X_CUST_BILL_TO_REV_ACCT_ID,
	WSH_NEW_DELIVERIES.WAYBILL X_TRACKING_NUMBER,
	WSH_NEW_DELIVERIES.SHIP_METHOD_CODE X_SHIPPING_METHOD_CODE,
	OE_ORDER_LINES_ALL.DEMAND_CLASS_CODE X_DEMAND_CLASS,
	CASE WHEN '#BIAPPS.IS_INCREMENTAL' ='N' THEN '0' 
ELSE 
BIAPPS.HOT_BI_UTIL_PKG.HOT_GET_REP_KEY(OE_ORDER_LINES_ALL.SHIP_TO_ORG_ID,MTL_CATEGORIES_B.SEGMENT1,MTL_CATEGORIES_B.SEGMENT2)
END X_TERRITORY_ID,
	OE_ORDER_HEADERS_ALL.ATTRIBUTE19 X_GENERIC_CUSTOMER_ID,
	WSH_NEW_DELIVERIES.ATTRIBUTE6 X_SHIP_AIR,
	WSH_NEW_DELIVERIES.ATTRIBUTE7 X_VESSEL_NAME,
	WSH_NEW_DELIVERIES.ATTRIBUTE8 X_VESSEL_NUMBER,
	WSH_NEW_DELIVERIES.ATTRIBUTE9 X_BOL_NUMBER,
	WSH_NEW_DELIVERIES.ATTRIBUTE10 X_CONTAINER_NUMBER,
	WSH_NEW_DELIVERIES.ATTRIBUTE11 X_CARTON_NUM_F,
	WSH_NEW_DELIVERIES.ATTRIBUTE12 X_CARTON_NUM_T,
	WSH_NEW_DELIVERIES.ATTRIBUTE13 X_LOADING,
	WSH_NEW_DELIVERIES.ATTRIBUTE14 X_DESTINATION,
	(Select WC_CUSTOMER_ITEMS_D.CUSTOMER_ITEM_NUMBER From HOTDW.WC_CUSTOMER_ITEMS_D  WC_CUSTOMER_ITEMS_D where OE_ORDER_LINES_ALL.INVENTORY_ITEM_ID=WC_CUSTOMER_ITEMS_D.INVENTORY_ITEM_ID AND OE_ORDER_LINES_ALL.SOLD_TO_ORG_ID=WC_CUSTOMER_ITEMS_D.CUSTOMER_ID) X_CUSTOMER_ITEM_NUMBER,
	'SALES_ORDER_PROCESS~'||OE_ORDER_LINES_ALL.FLOW_STATUS_CODE X_ORDER_STATUS_ID,
	WSH_CARRIER_SERVICES.SHIP_METHOD_MEANING X_SHIP_METHOD_MEANING
from	APPS.WSH_CARRIER_SERVICES    WSH_CARRIER_SERVICES RIGHT OUTER JOIN ((((APPS.WSH_NEW_DELIVERIES    WSH_NEW_DELIVERIES INNER JOIN (APPS.WSH_DELIVERY_DETAILS    WSH_DELIVERY_DETAILS INNER JOIN APPS.WSH_DELIVERY_ASSIGNMENTS    WSH_DELIVERY_ASSIGNMENTS ON WSH_DELIVERY_DETAILS.DELIVERY_DETAIL_ID=WSH_DELIVERY_ASSIGNMENTS.DELIVERY_DETAIL_ID) ON WSH_NEW_DELIVERIES.DELIVERY_ID=WSH_DELIVERY_ASSIGNMENTS.DELIVERY_ID) LEFT OUTER JOIN APPS.WSH_PICKING_BATCHES    WSH_PICKING_BATCHES ON WSH_DELIVERY_DETAILS.BATCH_ID=WSH_PICKING_BATCHES.BATCH_ID) LEFT OUTER JOIN APPS.WSH_DELIVERY_LEGS    WSH_DELIVERY_LEGS ON WSH_DELIVERY_ASSIGNMENTS.DELIVERY_ID=WSH_DELIVERY_LEGS.DELIVERY_ID) LEFT OUTER JOIN APPS.WSH_TRIP_STOPS    WSH_TRIP_STOPS ON WSH_DELIVERY_LEGS.PICK_UP_STOP_ID=WSH_TRIP_STOPS.STOP_ID) ON WSH_CARRIER_SERVICES.SHIP_METHOD_CODE=WSH_NEW_DELIVERIES.SHIP_METHOD_CODE, (APPS.MTL_ITEM_CATEGORIES    MTL_ITEM_CATEGORIES LEFT OUTER JOIN APPS.MTL_CATEGORIES_B    MTL_CATEGORIES_B ON MTL_ITEM_CATEGORIES.CATEGORY_ID=MTL_CATEGORIES_B.CATEGORY_ID) RIGHT OUTER JOIN APPS.MTL_SYSTEM_ITEMS    MTL_SYSTEM_ITEMS ON MTL_ITEM_CATEGORIES.INVENTORY_ITEM_ID=MTL_SYSTEM_ITEMS.INVENTORY_ITEM_ID, APPS.OE_ORDER_LINES_ALL   OE_ORDER_LINES_ALL, APPS.OE_ORDER_HEADERS_ALL   OE_ORDER_HEADERS_ALL
where	(1=1)
 And (OE_ORDER_HEADERS_ALL.HEADER_ID=WSH_DELIVERY_DETAILS.SOURCE_HEADER_ID)
AND (OE_ORDER_LINES_ALL.LINE_ID=WSH_DELIVERY_DETAILS.SOURCE_LINE_ID)
AND (MTL_SYSTEM_ITEMS.ORGANIZATION_ID=OE_ORDER_LINES_ALL.SHIP_FROM_ORG_ID AND MTL_SYSTEM_ITEMS.INVENTORY_ITEM_ID=OE_ORDER_LINES_ALL.INVENTORY_ITEM_ID)

And (

(WSH_DELIVERY_DETAILS.LAST_UPDATE_DATE >= TO_DATE(SUBSTR('#BIAPPS.LAST_EXTRACT_DATE',0,19),'YYYY-MM-DD HH24:MI:SS') OR WSH_DELIVERY_ASSIGNMENTS.LAST_UPDATE_DATE >= TO_DATE(SUBSTR('#BIAPPS.LAST_EXTRACT_DATE',0,19),'YYYY-MM-DD HH24:MI:SS') OR WSH_NEW_DELIVERIES.LAST_UPDATE_DATE >= TO_DATE(SUBSTR('#BIAPPS.LAST_EXTRACT_DATE',0,19),'YYYY-MM-DD HH24:MI:SS'))
)
 And (WSH_DELIVERY_DETAILS.SOURCE_CODE='OE')
 And (MTL_CATEGORIES_B.STRUCTURE_ID=101)
 And (MTL_ITEM_CATEGORIES.ORGANIZATION_ID=82)
 And (MTL_ITEM_CATEGORIES.CATEGORY_SET_ID=1)

)   SQ_SALES_PCKLNS1
where	(1=1)








