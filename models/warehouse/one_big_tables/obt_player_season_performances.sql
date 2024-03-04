with season_fact_table as (
    select * from {{ ref('fct_player_season_performances') }}
),
dim_seasons as (
    select * from {{ ref('dim_seasons') }}
),
dim_teams as (
    select * from {{ ref('dim_teams') }}
),
dim_players as (
    select * from {{ ref('dim_players') }}
)

select
    season,
    season_start_date,
    season_end_date
    player_id,
        first_name,
        last_name,
        dim_players.full_name,
        display_last_comma_first,
        display_fi_last,
        player_slug,
        birthdate,
        school,
        country,
        last_affiliation,
        height,
        weight,
        height_inches,
        bmi,
        bmi_category,
        seasons_played,
        jersey,
        position,
        roster_status,
        games_played_current_season_flag,
        playercode,
        first_year_played,
        last_year_played,
        g_league_has_played,
        nba_has_played,
        draft_year,
        draft_round,
        draft_number,
        greatest_75_member
    nominal_salary_earnings,
            nominal_salary_earnings_rank,
            inflation_adjusted_salary_earnings,
            inflation_adjusted_salary_earnings_rank,
    dim_teams.team_id,
    dim_teams.full_name as team_full_name,
    dim_teams.team_name_abbreviation as team_name_abbreviation,
    dim_teams.nickname as team_nickname,
    dim_teams.city as team_city,
    dim_teams.state as team_state,
    dim_teams.year_founded as team_year_founded,

            games_played,
            win_probability,
            avg_mins_played,
            avg_field_goals_made,
            avg_field_goals_attempted,
            avg_field_goal_pct,
            avg_three_point_made,
            avg_three_point_attempted,
            avg_three_point_pct,
            avg_free_throws_made,
            avg_free_throws_attempted,
            avg_free_throw_pct,
            avg_offensive_rebounds,
            avg_defensive_rebounds,
            avg_total_reboundsd,
            avg_assists,
            avg_turnovers,
            avg_steals,
            avg_blocks,
            avg_personal_fouls,
            avg_points,
            avg_plus_minus,
            team_conference_rank,
            team_division_rank,
            team_nba_finals_appearance,
            team_nba_champion
from season_fact_table
    inner join dim_players using (player_id)
    inner join dim_teams on dim_teams.team_id = season_fact_table.team_id
    inner join dim_seasons on dim_seasons.full_season_id = season_fact_table.season