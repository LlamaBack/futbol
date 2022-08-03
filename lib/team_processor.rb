module TeamProcessor
  def season_stats(team_id, game_teams)
    team_seasons = Hash.new { |season_id, games_won| season_id[games_won] = [0.0, 0.0] }
    game_teams.each do |game_team|
      if game_team.team_id == team_id
        team_seasons[game_team.game_id[0..3]][0] += 1
        if game_team.result == 'WIN'
          team_seasons[game_team.game_id[0..3]][1] += 1
        end
      end
    end
    return team_seasons
  end

  def bestest_season(team_seasons)
    highest_win_percentage = 0.0
    winningest_season = ''
    team_seasons.each do |season, wins_games|
      if highest_win_percentage < wins_games[1] / wins_games[0]
        highest_win_percentage = wins_games[1] / wins_games[0]
        winningest_season = season
      end
    end
    return winningest_season
  end

  def worstest_season(team_seasons)
    lowest_win_percentage = 1.0
    losingest_season = ''
    team_seasons.each do |season, wins_games|
      if lowest_win_percentage > wins_games[1] / wins_games[0]
        lowest_win_percentage = wins_games[1] / wins_games[0]
        losingest_season = season
      end
    end
    return losingest_season
  end

  def games_played(team_id, game_teams)
    games_played = 0.0
    game_teams.each do |game_team|
      if game_team.team_id == team_id
        games_played += 1
      end
    end
    games_played
  end

  def games_won(team_id, game_teams)
    games_won = 0.0
    game_teams.each do |game_team|
      if game_team.team_id == team_id
        if game_team.result == "WIN"
          games_won += 1
        end
      end
    end
    games_won
  end

  def goals_scored(team_id, value, game_teams)
    if value == "most"
      highest_goal = 0
      game_teams.each do |game_team|
        if game_team.team_id == team_id
          if game_team.goals.to_i > highest_goal
            highest_goal = game_team.goals.to_i
          end
        end
      end
      return highest_goal
    else
      lowest_goal = Float::INFINITY
      game_teams.each do |game_team|
        if game_team.team_id == team_id
          if game_team.goals.to_i < lowest_goal
            lowest_goal = game_team.goals.to_i
          end
        end
      end
      return lowest_goal
    end
  end

  def opponent_stats(team_id, games)
    opponent_stats = Hash.new { |opponent_id, stats| opponent_id[stats] = [0.0, 0.0, 0.0] }
    games.each do |game|
      if game.home_team_id == team_id
        opponent_stats[game.away_team_id][0] += 1
        if game.home_goals > game.away_goals
          opponent_stats[game.away_team_id][1] += 1
        end
      end

      if game.away_team_id == team_id
        opponent_stats[game.home_team_id][0] += 1
        if game.away_goals > game.home_goals
          opponent_stats[game.home_team_id][1] += 1
        end
      end
    end
    return opponent_stats
  end

  def fav_opponent(opponent_stats)
    highest_win_percentage = 0.0
    fav_opponent = ''
    opponent_stats.each do |opponent_id, stats|
      if highest_win_percentage < stats[1] / stats[0]
        highest_win_percentage = stats[1] / stats[0]
        fav_opponent = opponent_id
      end
    end
    fav_opponent
  end

  def rival_opponent(opponent_stats)
    lowest_win_percentage = Float::INFINITY
    rival_opponent = ''
    opponent_stats.each do |opponent_id, stats|
      if lowest_win_percentage > stats[1] / stats[0]
        lowest_win_percentage = stats[1] / stats[0]
        rival_opponent = opponent_id
      end
    end
    rival_opponent
  end

  def team_information(team_id, teams)
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
end
