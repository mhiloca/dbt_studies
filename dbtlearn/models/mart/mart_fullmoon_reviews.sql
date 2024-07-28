{{
    config(
        materialized = 'table'
    )
}}

with fct_reviews as (
    select * from {{ ref('fct_reviews') }}
),

full_moon as (
    select * from {{ ref('seed_full_moon_dates') }}
)

select
    r.*,
    iff(fm.full_moon_date is null, 'not_full_moon', 'full_moon') as is_full_moon
from
    fct_reviews as r
    left join full_moon as fm
        on to_date(r.review_date) = dateadd(day, 1, fm.full_moon_date)