{{ config(
    materialized='view',
    schema='ZOOPLA'
) }}

SELECT
    AS_SOURCE,
    LISTING_CHANGE_ID,
    CHANGE_DATE,
    LISTING_ID,
    UPRN,
    CHANGE_TYPE,
    ASKING_PRICE,
    ADDRESS,
    POSTCODE,
    PCD_CODE,
    LOCAL_AUTHORITY,
    REGION,
    COUNTRY,
    LATITUDE,
    LONGITUDE,
    PROPERTY_TYPE,
    TRANSACTION_TYPE,
    BEDROOMS,
    BATHROOMS,
    RECEPTIONS,
    FLOORS,
    SIZE_SQFEET,
    RENT_FREQUENCY,
    TENURE,
    DISPLAY_STATUS,
    AGENT_BRAND_ID, -- Column 29
    AGENT_BRANCH_ID, -- Column 30
    SUMMARY_DESCRIPTION,
    DETAILED_DESCRIPTION,
    BULLETS,
    BRANCH_ADDRESS,
    IS_NEW_HOME,
    HAS_BUYER_INCENTIVES,
    IS_SHARED_ACCOMMODATION,
    IS_AUCTION,
    UPDATE_REASON, -- Column 39
    TRANSACTIONS, -- Column 40
    FEATURES, -- Column 41
    SNAPSHOT_IMPORT_NAME, -- Column 42
    IMPORT_NAME, -- Column 43
    PRICE_QUALIFIER, -- Column 44
    EPC_BAND, -- Column 45
    COUNCIL_TAX, -- Column 46
    EPC_DATE, -- Column 47
    TIME_SINCE_UPDATE, -- Column 48
    RETIREMENT_HOME, -- Column 49
    STUDENT_PROPERTY, -- Column 50
    SHARED_OWNERSHIP, -- Column 51
    AGENT_BRANCH, -- Column 52
    LISTING_URL, -- Column 53
    RELATED_URLS -- Column 54
    -- TOTAL 54 columns in SELECT list
FROM (
    
    {{ select_listings_union_cols('zooplasftp', 'ZOOPLA') }}
    
    UNION ALL
    
    {{ select_listings_union_cols('rightmove_listings_silver', 'RIGHTMOVE') }}
    
    UNION ALL
    
    {{ select_listings_union_cols('otm_silver', 'OTM') }}
)