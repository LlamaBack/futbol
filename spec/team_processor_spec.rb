require './lib/team_processor'
require './lib/game'
require './lib/game_team'
RSpec.describe TeamProcessor do
  let(:dummy_class) { Class.new { extend TeamProcessor } }

  let(:row1) { {game_id: "2012030221",
    season: "20122013",
    away_team_id: "3",
    home_team_id:  "6",
    away_goals: "2",
    home_goals: "1" }}
  let(:row2) { {game_id: "2012030222",
    season: "20122013",
    away_team_id: "3",
    home_team_id:  "6",
    away_goals: "2",
    home_goals: "3" }}
  let(:row3) { {game_id: "2011030222",
    season: "20112012",
    away_team_id: "3",
    home_team_id:  "6",
    away_goals: "6",
    home_goals: "5" }}
  let(:games) {[Game.new(row1), Game.new(row2), Game.new(row3)]}

  let(:game_team_row1) { {game_id:"2012030221",
              team_id:"3",
              goals: "1",
              head_coach: "John Tortorella",
              result: "LOSS",
              shots: "8",
              tackles: "44"
              } }
  let(:game_team_row2) { {game_id:"2012030221",
              team_id:"6",
              goals: "3",
              head_coach: "Claude Julien",
              result: "WIN",
              shots: "12",
              tackles: "51"
              } }
  let(:game_teams) {[GameTeam.new(game_team_row1), GameTeam.new(game_team_row2)]}

  let(:team_row) { {
              team_id: "1",
              franchiseid: "23",
              teamname: "Atlanta United",
              abbreviation: "ATL",
              link: "/api/v1/teams/1"
              } }
  let(:teams) {[Team.new(team_row)]}


  it 'returns season_stats' do
    expect(dummy_class.season_stats("3", game_teams)).to eq({"2012"=>[1.0, 0.0]})
  end

  it 'returns bestest season' do
    stats = dummy_class.season_stats("6", game_teams)
    expect(dummy_class.bestest_season(stats)).to eq("2012")
  end

  it 'returns worstest season' do
    stats = dummy_class.season_stats("3", game_teams)
    expect(dummy_class.worstest_season(stats)).to eq("2012")
  end

  it 'can return games_played' do
    expect(dummy_class.games_played("3", game_teams)).to eq(1.0)
  end

  it 'can return games_won' do
    expect(dummy_class.games_won("3", game_teams)).to eq(0.0)
    expect(dummy_class.games_won("6", game_teams)).to eq(1.0)
  end

  it 'returns most and lowest goals_scored' do
    expect(dummy_class.goals_scored("6", "most", game_teams)).to eq(3)
    expect(dummy_class.goals_scored("3", "lowest", game_teams)).to eq(1)
  end

  it 'returns opponent_stats' do
    expect(dummy_class.opponent_stats("6", games)).to eq({"3"=>[3.0, 1.0, 0.0]})
  end

  it 'returns fav_opponent' do
    stats = dummy_class.opponent_stats("6", games)
    expect(dummy_class.fav_opponent(stats)).to eq("3")
  end

  it 'returns rival_opponent' do
    stats = dummy_class.opponent_stats("6", games)
    expect(dummy_class.rival_opponent(stats)).to eq("3")
  end

  it 'returns team_information' do
    expect(dummy_class.team_information("1", teams)).to eq({
      'team_id' => '1',
      'franchise_id' => '23',
      'team_name' => "Atlanta United",
      'abbreviation' => 'ATL',
      'link' => '/api/v1/teams/1'
    })
  end

end
