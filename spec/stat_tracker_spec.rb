require './lib/stat_tracker'

RSpec.describe StatTracker do
  let(:locations) do
    {
      games: './data/dummy_games.csv',
      teams: './data/teams.csv',
      game_teams: './data/dummy_game_teams.csv'
    }
  end

  let(:stat_tracker) { StatTracker.from_csv(locations) }

  it 'StatTracker exists' do
    expect(stat_tracker).to be_a(StatTracker)
  end

  it 'returns highest_total_score' do
    expect(stat_tracker.highest_total_score).to eq(5)
  end

  it 'returns lowest_total_score' do
    expect(stat_tracker.lowest_total_score).to eq(3)
  end

  it 'returns percentage_home_wins' do
    expect(stat_tracker.percentage_home_wins).to eq(0.43)
  end

  it 'returns percentage_visitor_wins' do
    expect(stat_tracker.percentage_visitor_wins).to eq(0.57)
  end

  it 'returns percentage_ties' do
    expect(stat_tracker.percentage_ties).to eq(0.00)
  end

  it 'returns count of games by season' do
    expect(stat_tracker.count_of_games_by_season).to eq({ '20122013' => 7 })
  end

  it 'returns average goals per game' do
    expect(stat_tracker.average_goals_per_game).to eq(4.29)
  end

  it 'returns total goals by season' do
    expect(stat_tracker.total_goals_by_season).to eq({ '20122013' => 30 })
  end

  it 'returns average goals by season' do
    expect(stat_tracker.average_goals_by_season).to eq({ '20122013' => 4.29 })
  end

  it 'returns count of teams' do
    expect(stat_tracker.count_of_teams).to eq(32)
  end

  it 'returns team with best offense' do
    expect(stat_tracker.best_offense).to eq("FC Dallas")
  end

  it 'returns team with worst offense' do
    expect(stat_tracker.worst_offense).to eq("Houston Dynamo")
  end

  it 'returns highest scoring visitor team' do
    #Data has been mocked below since initial dummy data set did not have varying seasons.
    fake_data = [
      {
        :season => "20142015",
        :away_team_id => "3",
        :home_team_id => "6",
        :away_goals => "2",
        :home_goals => "3",
      },
      {
        :season => "20122013",
        :away_team_id => "3",
        :home_team_id => "6",
        :away_goals => "2",
        :home_goals => "3",
      },
      {
        :season => "20142015",
        :away_team_id => "6",
        :home_team_id => "3",
        :away_goals => "3",
        :home_goals => "1",
      },
      {
        :season => "20122013",
        :away_team_id => "6",
        :home_team_id => "3",
        :away_goals => "3",
        :home_goals => "2",
      }
    ]
    #calls to the original CSV file where specified, in this case it was the second half of the method
    allow(CSV).to receive(:open).with(any_args).and_call_original
    #allows us to utilize the fake data instead of the referenced CSV in order to perform our test
    allow(CSV).to receive(:open).with(locations[:games], any_args).and_return(fake_data)
    expect(stat_tracker.highest_scoring_visitor).to eq("FC Dallas")
  end
end
