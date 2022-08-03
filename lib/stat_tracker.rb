require 'csv'
require_relative 'game'
require_relative 'team'
require_relative 'game_team'
require_relative './game_processor'
require_relative './league_processor'
require_relative './season_processor'
require_relative './team_processor'

class StatTracker
  include GameProcessor
  include LeagueProcessor
  include SeasonProcessor
  include TeamProcessor
  attr_reader :locations, :data
  def initialize(game_path, team_path, game_teams_path)
    @game_path = game_path
    @team_path = team_path
    @game_teams_path = game_teams_path
  end

  def games
    games_csv = CSV.open(@game_path, headers: true, header_converters: :symbol)
    @games ||= games_csv.map do |row|
      Game.new(row)
    end
  end

  def teams
    teams_csv = CSV.open(@team_path, headers: true, header_converters: :symbol)
    @teams ||= teams_csv.map do |row|
      Team.new(row)
    end
  end

  def game_teams
    game_teams_csv = CSV.open(@game_teams_path, headers: true, header_converters: :symbol)
    @game_teams ||= game_teams_csv.map do |row|
      GameTeam.new(row)
    end
  end

  def self.from_csv(locations)
    StatTracker.new(
      locations[:games],
      locations[:teams],
      locations[:game_teams]
    )
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
    avg_season_goals = Hash.new(0.0)
    total_goals_by_season(games).each do |season, goal|
      avg_season_goals[season] = (goal / count_of_games_by_season[season]).round(2)
    end
      avg_season_goals
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
    team_hash = Hash.new()
    teams.each do |team|
      if team.team_id == team_id
        team_hash['team_name'] = team.team_name
        team_hash['team_id'] = team.team_id
        team_hash['franchise_id'] = team.franchise_id
        team_hash['abbreviation'] = team.abbv
        team_hash['link'] = team.link
        return team_hash
      end
    end
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
    opp_stats = opponent_stats(team_id, games)
    team_id = fav_opponent(opp_stats)
    team_info(team_id)['team_name']
  end

  def rival(team_id)
    opp_stats = opponent_stats(team_id, games)
    team_id = rival_opponent(opp_stats)
    team_info(team_id)['team_name']
  end
end
