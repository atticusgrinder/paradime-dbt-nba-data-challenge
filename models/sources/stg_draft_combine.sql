with split_heights as (
    select 
        player,
        pos,
        body_fat,
        hand_length_inches,
        hand_width_inches,
        height_wo_shoes,
        split(height_wo_shoes, '\'') as split_height_wo_shoes,
        height_w_shoes,
        split(height_w_shoes, '\'') as split_height_w_shoes,
        standing_reach,
        split(standing_reach, '\'') as split_standing_reach,
        weight_lbs,
        wingspan,
        split(wingspan, '\'') as split_wingspan,
        year
    from {{ source('draft', 'NBA_DRAFT_COMBINE_2000_2023_CLEANED')}}
),
inches as (
    select 
        player,
        pos,
        body_fat,
        hand_length_inches,
        hand_width_inches,
        height_wo_shoes,
        split_height_wo_shoes[0] * 12 + split_height_wo_shoes[1] as height_wo_shoes_inches,
        height_w_shoes,
        split_height_w_shoes[0] * 12 + split_height_w_shoes[1] as height_w_shoes_inches,
        standing_reach,
        split_standing_reach[0] * 12 + split_standing_reach[1] as standing_reach_inches,
        weight_lbs,
        wingspan,
        split_wingspan[0] * 12 + split_wingspan[1] as wingspan_inches,
        year
    from split_heights
)
select 
    *,
    round(coalesce(height_w_shoes_inches,height_wo_shoes_inches) / wingspan_inches, 3) as height_wingspan_ratio
from inches