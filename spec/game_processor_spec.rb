require './lib/game_processor'
require './lib/game'

RSpec.describe GameProcessor do
  let(:dummy_class) { Class.new { extend GameProcessor } }

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

  let(:row4) { {game_id: "2011030223",
    season: "20112012",
    away_team_id: "3",
    home_team_id:  "6",
    away_goals: "1",
    home_goals: "1" }}


  let(:games) {[Game.new(row1), Game.new(row2), Game.new(row3), Game.new(row4)]}

  it 'returns a total score' do
    expect(dummy_class.total_score('highest', games)).to eq(11)
    expect(dummy_class.total_score('lowest', games)).to eq(2)
  end

  it 'returns wins and ties' do
    expect(dummy_class.wins_ties('home', games)).to eq(1.0)
    expect(dummy_class.wins_ties('visitor', games)).to eq(2.0)
    expect(dummy_class.wins_ties('ties', games)).to eq(1.0)
  end

  it 'returns count of games by season' do
    expect(dummy_class.games_by_season(games)).to eq({ '20122013' => 2,
                                                       '20112012' => 2
        })
  end

  it 'returns total goals' do
    expect(dummy_class.total_goals(games)).to eq(21.0)
  end

  it 'returns total goals by season' do
    expected_hash = {"20122013" => 8.0,
                     "20112012" => 13.0
    }
    expect(dummy_class.total_goals_by_season(games)).to eq(expected_hash)
  end
end
