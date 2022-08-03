require 'data_loader'

RSpec.describe DataLoader do
  let(:locations) { { games: './data/games.csv',
                      teams: './data/teams.csv',
                      game_teams: './data/game_teams.csv' } }

  let(:data_loader) {DataLoader.new(locations)}

  it 'reads the games csv' do
    expect(data_loader.games).to be_an_instance_of(Array)
  end

  it 'reads the teams csv' do
    expect(data_loader.teams).to be_an_instance_of(Array)
  end

  it 'reads the game_teams csv' do
    expect(data_loader.game_teams).to be_an_instance_of(Array)
  end
end
