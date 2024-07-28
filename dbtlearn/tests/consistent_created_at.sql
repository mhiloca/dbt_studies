select
    *
from
    {{ ref('dim_listings_cleansed') }} as dlc
join {{ ref('fct_reviews') }} as rf
    on dlc.listing_id = rf.listing_id
where rf.review_date <= dlc.created_at
limit 10