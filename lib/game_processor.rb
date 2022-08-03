module GameProcessor
  def total_score(value, games)
    if value == 'highest'
      score_sum = 0
      games.each do |game|
        if score_sum < game.total_goals_game
          score_sum = game.total_goals_game
        end
      end

    else
      score_sum = Float::INFINITY
      games.each do |game|
          if score_sum > game.total_goals_game
          score_sum = game.total_goals_game
        end
      end
    end
    return score_sum
  end

  def wins_ties(value, games)
    if value == 'home'
      home_wins = 0.0
      games.each do |game|
        if game.home_goals.to_i > game.away_goals.to_i
          home_wins += 1
        end
      end
      home_wins

    elsif value == 'visitor'
      visitor_wins = 0.0
      games.each do |game|
        if game.home_goals.to_i < game.away_goals.to_i
          visitor_wins += 1
        end
      end
      visitor_wins

    else
      ties = 0.0
      games.each do |game|
        if game.home_goals.to_i == game.away_goals.to_i
          ties += 1
        end
      end
      ties
    end
  end

  def games_by_season(games)
    season_games = Hash.new(0)
    games.each do |game|
      season_games[game.season] += 1
    end
    season_games
  end

  def total_goals(games)
    total_goals = 0.0
    games.each do |game|
      total_goals += game.total_goals_game
    end
    total_goals
  end

  def total_goals_by_season(games)
    total_season_goals = Hash.new(0.0)
    games.each do |game|
      total_season_goals[game.season] += game.total_goals_game
    end
    total_season_goals
  end

  def average_season_goals(games)
    avg_season_goals = Hash.new(0.0)
    total_goals_by_season(games).each do |season, goal|
      avg_season_goals[season] = (goal / games_by_season(games)[season]).round(2)
    end
    avg_season_goals
  end
end
