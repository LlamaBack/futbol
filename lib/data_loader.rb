require 'csv'
require_relative 'game'
require_relative 'team'
require_relative 'game_team'
require_relative './game_processor'
require_relative './league_processor'
require_relative './season_processor'
require_relative './team_processor'

class DataLoader
  def initialize(locations)
    @game_path = locations[:games]
    @team_path = locations[:teams]
    @game_teams_path = locations[:game_teams]
  end

  def games
    games_csv = CSV.open(@game_path, headers: true, header_converters: :symbol)
    @games ||= games_csv.map { |row| Game.new(row) }
  end

  def teams
    teams_csv = CSV.open(@team_path, headers: true, header_converters: :symbol)
    @teams ||= teams_csv.map { |row| Team.new(row) }
  end

  def game_teams
    game_teams_csv = CSV.open(@game_teams_path, headers: true, header_converters: :symbol)
    @game_teams ||= game_teams_csv.map { |row| GameTeam.new(row) }
  end
end
