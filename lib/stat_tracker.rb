require_relative 'data_loader'

class StatTracker < DataLoader
  include GameProcessor, LeagueProcessor, SeasonProcessor, TeamProcessor
  attr_reader :locations, :data

  def initialize(locations)
    super(locations)
  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def highest_total_score
    total_score('highest', games)
  end

  def lowest_total_score
    total_score('lowest', games)
  end

  def percentage_home_wins
    (wins_ties('home', games) / games.count).round(2)
  end

  def percentage_visitor_wins
    (wins_ties('visitor', games) / games.count).round(2)
  end

  def percentage_ties
    (wins_ties('ties', games) / games.count).round(2)
  end

  def count_of_games_by_season
    games_by_season(games)
  end

  def average_goals_per_game
    (total_goals(games) / games.count).round(2)
  end

  def average_goals_by_season
    average_season_goals(games)
  end

  def count_of_teams
    teams.count
  end

  def best_offense
    best_team_id = offense("best", game_teams)
    team_info(best_team_id.to_s)['team_name']
  end

  def worst_offense
    worst_team_id = offense("worst", game_teams)
    team_info(worst_team_id.to_s)['team_name']
  end

  def highest_scoring_visitor
    best_visitor_id = visitor_scoring_outcome("highest_scoring", games)
    team_info(best_visitor_id.to_s)['team_name']
  end

  def highest_scoring_home_team
    best_home_id = home_scoring_outcome("highest_scoring", games)
    team_info(best_home_id.to_s)['team_name']
  end

  def lowest_scoring_visitor
    worst_visitor_id = visitor_scoring_outcome("lowest_scoring", games)
    team_info(worst_visitor_id.to_s)['team_name']
  end

  def lowest_scoring_home_team
    worst_home_id = home_scoring_outcome("lowest_scoring", games)
    team_info(worst_home_id.to_s)['team_name']
  end

  def winningest_coach(season_id)
    best_coach(coach_stats(season_id[0..3], game_teams))
  end

  def worst_coach(season_id)
    worstest_coach(coach_stats(season_id[0..3], game_teams))
  end

  def most_accurate_team(season_id)
    team_id = mostest_accurate_team(goal_stats(season_id[0..3], game_teams))
    team_info(team_id)["team_name"]
  end

  def least_accurate_team(season_id)
    team_id = leastest_accurate_team(goal_stats(season_id[0..3], game_teams))
    team_info(team_id)["team_name"]
  end

  def most_tackles(season_id)
    tackle_stats = tackle_stats(season_id[0..3], game_teams)
    team_info(tackle_stats.key(tackle_stats.values.max))["team_name"]
  end

  def fewest_tackles(season_id)
    tackle_stats = tackle_stats(season_id[0..3], game_teams)
    team_info(tackle_stats.key(tackle_stats.values.min))["team_name"]
  end

  def team_info(team_id)
    team_information(team_id, teams)
  end

  def best_season(team_id)
    team_seasons = season_stats(team_id, game_teams)
    winningest_season = bestest_season(team_seasons)
    return "#{winningest_season}#{winningest_season.next}"
  end

  def worst_season(team_id)
    team_seasons = season_stats(team_id, game_teams)
    losingest_season = worstest_season(team_seasons)
    return "#{losingest_season}#{losingest_season.next}"
  end

  def average_win_percentage(team_id)
    (games_won(team_id, game_teams) / games_played(team_id, game_teams)).round(2)
  end

  def most_goals_scored(team_id)
    goals_scored(team_id, "most", game_teams)
  end

  def fewest_goals_scored(team_id)
    goals_scored(team_id, "fewest", game_teams)
  end

  def favorite_opponent(team_id)
    team_id = fav_opponent(opponent_stats(team_id, games))
    team_info(team_id)['team_name']
  end

  def rival(team_id)
    team_id = rival_opponent(opponent_stats(team_id, games))
    team_info(team_id)['team_name']
  end
end
