require "./lib/game"

RSpec.describe Game do
  before :each do
    @stats = {
            game_id: "2012030221",
            season: "20122013",
            away_team_id: "3",
            home_team_id: "6",
            away_goals: "2",
            home_goals: "3"
            }
    @game = Game.new(@stats)
  end
  it 'exists and has readable attributes' do

    expect(@game).to be_a(Game)
    expect(@game.game_id).to eq("2012030221")
    expect(@game.season).to eq("20122013")
    expect(@game.away_team_id).to eq("3")
    expect(@game.home_team_id).to eq("6")
    expect(@game.away_goals).to eq("2")
    expect(@game.home_goals).to eq("3")
  end

  it 'can return total goals' do
    expect(@game.total_goals_game).to eq(5)
  end
end
