with org_flag as (
select * from (
select organization_id,org_information1,org_information2 from HR_ORGANIZATION_INFORMATION
where org_information_context='CLASS' and org_information1 in ('INV','OPERATING_UNIT')
and org_information2 = 'Y'
)
pivot (max(org_information2) for org_information1 in ('INV','OPERATING_UNIT')) as p(organization_id, inv_org_flag, operating_unit_flag)
)
select 
 hr.organization_id
,lo.organization_code
,hr.Name organization_name
,hr.type organization_type
,lo.operating_unit operating_unit_id
,o.name operating_unit_name
,lo.legal_entity
,l.name legal_entity_name
,lo.set_of_books_id
,gl.short_name ledger_name
,gl.currency_code
,glev.flex_segment_value company_code
,org_flag.inv_org_flag
,org_flag.operating_unit_flag
,hr.internal_external_flag
,hr.last_update_date
,hr.creation_date
,hr.created_by
,hr.last_updated_by
,hl.ADDRESS_LINE_1 ST_ADDRESS1 ,
	hl.TOWN_OR_CITY CITY_CODE,
	hl.ADDRESS_LINE_2 ST_ADDRESS1,
	hl.COUNTRY country_code,hl.style,
case when hl.style = 'CA_GLB' then trim(hl.REGION_1) else trim(hl.REGION_2) end stat_prov_code,
	hl.REGION_1 county_code,
	hl.POSTAL_CODE
 from ORG_ORGANIZATION_DEFINITIONS lo
 ,gl_legal_entities_bsvs         glev
 ,HR_ALL_ORGANIZATION_UNITS hr
 ,HR_ALL_ORGANIZATION_UNITS l
 ,HR_ALL_ORGANIZATION_UNITS o
 ,gl_ledgers gl
 ,hr_locations_all hl
 ,org_flag
 where hr.location_id = hl.location_id(+)
 and lo.legal_entity = glev.legal_entity_id(+)
 and lo.organization_id(+) = hr.organization_id
 and lo.legal_entity = l.organization_id(+)
 and lo.operating_unit = o.organization_id(+)
 and gl.ledger_id(+) = lo.set_of_books_id
 and hr.organization_id = org_flag.organization_id(+)
 ;
