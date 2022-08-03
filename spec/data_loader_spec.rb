require 'data_loader'

RSpec.describe DataLoader do
  let(:locations) { { games: './data/games.csv',
                      teams: './data/teams.csv',
                      game_teams: './data/game_teams.csv' } }

  let(:data_loader) {DataLoader.new(locations)}

  it 'reads the games csv and returns an array' do
    expect(data_loader.games).to be_an_instance_of(Array)
    expect(data_loader.games[0].game_id).to eq("2012030221")
  end

  it 'reads the teams csv and returns an array' do
    expect(data_loader.teams).to be_an_instance_of(Array)
    expect(data_loader.teams[0].team_id).to eq("1")
  end

  it 'reads the game_teams csv and returns an array' do
    expect(data_loader.game_teams).to be_an_instance_of(Array)
    # require "pry";binding.pry
    expect(data_loader.game_teams[0].team_id).to eq("3")
  end
end
