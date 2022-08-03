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
  let(:team_row) { {
                # team_id: "1",
                # franchiseid: "23",
                # teamname: "Atlanta United",
                # abbreviation: "ATL",
                # link: "/api/v1/teams/1"
                      } }
  let(:game_teams) {[GameTeam.new(game_team_row1), GameTeam.new(game_team_row2)]}

  it 'returns opponent' do
    expect(dummy_class.opponent("1", favorite, teams)).to eq({"John Tortorella"=>[1.0, 0.0], "Claude Julien"=>[1.0, 1.0]})
  end

  it 'returns best_coach' do
    coach_stats = dummy_class.coach_stats("2012", game_teams)
    expect(dummy_class.best_coach(coach_stats)).to eq("Claude Julien")
  end

  it 'returns worstest_coach' do
    coach_stats = dummy_class.coach_stats("2012", game_teams)
    expect(dummy_class.worstest_coach(coach_stats)).to eq("John Tortorella")
  end

  it 'returns goal_stats' do
    expect(dummy_class.goal_stats("2012", game_teams)).to eq({"3"=>[8.0, 1.0], "6"=>[12.0, 3.0]})
  end

  it 'returns mostest_accurate_team' do
    goal_stats = dummy_class.goal_stats("2012", game_teams)
    expect(dummy_class.mostest_accurate_team(goal_stats)).to eq("6")
  end

  it 'returns leastest_accurate_team' do
    goal_stats = dummy_class.goal_stats("2012", game_teams)
    expect(dummy_class.leastest_accurate_team(goal_stats)).to eq("3")
  end

  it 'returns tackle_stats' do
    expect(dummy_class.tackle_stats("2012", game_teams)).to eq({"3"=>44, "6"=>51})
  end
end
