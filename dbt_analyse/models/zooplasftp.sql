{{ config(
    materialized='view',
    tags=['sftp']
) }}

select
    'ZOOPLA' as AS_SOURCE,
    try_to_number(t1.LISTING_CHANGE_ID) as LISTING_CHANGE_ID,
    try_to_date(t1.DATE) as CHANGE_DATE,
    t1.LISTING_ID,
    t1.UPRN,
    t1.CHANGE_TYPE,
    try_to_number(regexp_substr(t1.PRICE, '^[0-9]+')) as ASKING_PRICE,
    concat_ws(', ',
        nullif(trim(t1.PROPERTY_NUMBER), ''),
        nullif(trim(t1.STREET), ''),
        nullif(trim(t1.TOWN), ''),
        nullif(trim(t1.COUNTY), '')
    ) as ADDRESS,
    t1.POSTCODE,
    t1.PCD as PCD_CODE,
    t1.NSPL_LOCAL_AUTHORITY as LOCAL_AUTHORITY,
    t1.NSPL_REGION as REGION,
    t1.NSPL_COUNTRY as COUNTRY,
    try_to_double(t1.LATITUDE) as LATITUDE,
    try_to_double(t1.LONGITUDE) as LONGITUDE,
    t1.PROPERTY_TYPE,
    t1.TRANSACTION_TYPE,
    try_to_number(t1.BEDROOMS) as BEDROOMS,
    try_to_number(t1.BATHROOMS) as BATHROOMS,
    try_to_number(t1.RECEPTIONS) as RECEPTIONS,
    try_to_number(regexp_substr(t1.FLOOR_AREA, '^[0-9]+')) as SIZE_SQFEET,
    t1.RENT_FREQUENCY,
    t1.TENURE,
    t1.LISTING_STATUS as DISPLAY_STATUS,
    try_to_number(t1.BRANCH_ID) as AGENT_BRANCH_ID,
    null as AGENT_BRAND_ID,
    regexp_replace(t1.SUMMARY_DESCRIPTION, '<[^>]+>', '') as SUMMARY_DESCRIPTION,
    regexp_replace(t1.DETAILED_DESCRIPTION, '<[^>]+>', '') as DETAILED_DESCRIPTION,
    regexp_replace(t1.BULLETS, '[*|]', ',') as BULLETS,
    t1.BRANCH_ADDRESS,
    IFF(lower(t1.NEW_HOME) = 'true', TRUE, FALSE) as IS_NEW_HOME,
    IFF(lower(t1.BUYER_INCENTIVES) = 'true', TRUE, FALSE) as HAS_BUYER_INCENTIVES,
    IFF(lower(t1.SHARED_ACCOMMODATION) = 'true', TRUE, FALSE) as IS_SHARED_ACCOMMODATION,
    IFF(lower(t1.AUCTION) = 'true', TRUE, FALSE) as IS_AUCTION


from {{ source('bronze', 'bronze_zoopla') }} as t1
