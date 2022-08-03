module TeamProcessor
  # def season(team_id)
  #   team_seasons = Hash.new { |season_id, games_won| season_id[games_won] = [0.0, 0.0] }
  #   game_teams.each do |game_team|
  #     if game_team.team_id == team_id
  #       team_seasons[game_team.game_id[0..3]][0] += 1
  #       if game_team.result == 'WIN'
  #         team_seasons[game_team.game_id[0..3]][1] += 1
  #       end
  #     end
  #   end
  #   highest_win_percentage = 0.0
  #   winningest_season = ''
  #   lowest_win_percentage = 1.0
  #   losingest_season = ''
  #     team_seasons.each do |season, wins_games|
  #       if highest_win_percentage < wins_games[1] / wins_games[0]
  #         highest_win_percentage = wins_games[1] / wins_games[0]
  #         winningest_season = season
  #       else
  #         lowest_win_percentage > wins_games[1] / wins_games[0]
  #         lowest_win_percentage = wins_games[1] / wins_games[0]
  #         losingest_season = season
  #       end
  #     end
  #
  #     return "#{winningest_season}#{winningest_season.next}"
  #     return "#{losingest_season}#{losingest_season.next}"
  # end

  # def worst_season(team_id)
  #   team_seasons = Hash.new { |season_id, games_won| season_id[games_won] = [0.0, 0.0] }
  #   game_teams.each do |game_team|
  #     if game_team.team_id == team_id
  #       team_seasons[game_team.game_id[0..3]][0] += 1
  #       if game_team.result == 'WIN'
  #         team_seasons[game_team.game_id[0..3]][1] += 1
  #       end
  #     end
  #   end
    # lowest_win_percentage = 1.0
    # losingest_season = ''
    # team_seasons.each do |season, wins_games|
      # if lowest_win_percentage > wins_games[1] / wins_games[0]
      #   lowest_win_percentage = wins_games[1] / wins_games[0]
      #   losingest_season = season
      # end
    # end
    # return "#{losingest_season}#{losingest_season.next}"
  # end



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
      highest_goal
    else
      lowest_goal = Float::INFINITY
      game_teams.each do |game_team|
        if game_team.team_id == team_id
          if game_team.goals.to_i < lowest_goal
            lowest_goal = game_team.goals.to_i
          end
        end
      end
      lowest_goal
    end
  end

  def opponent(team_id, value, games)
    opponent_stats = Hash.new { |opponent_id, stats| opponent_id[stats] = [0.0, 0.0, 0.0] } #[games_played, games_won]
require "pry"; binding.pry
    games.each do |game|
      if game.home_team_id == team_id #|| row[:home_team_id] == team_id
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
    if value == 'favorite'
      highest_win_percentage = 0.0
      fav_opponent = ''
      opponent_stats.each do |opponent_id, stats|
        if highest_win_percentage < stats[1] / stats[0]
          highest_win_percentage = stats[1] / stats[0]
          fav_opponent = opponent_id
          stats[2] = stats[1] / stats[0] #not needed for this method. but might be useful for making team class?
        end
      end
      team_info(fav_opponent)['team_name']
    else
      value == 'rival'
      lowest_win_percentage = 1.0
      rival_id = ''
      opponent_stats.each do |opponent_id, stats|
        if lowest_win_percentage > stats[1] / stats[0]
          lowest_win_percentage = stats[1] / stats[0]
          rival_id = opponent_id
          stats[2] = stats[1] / stats[0] #not needed for this method. but might be useful for making team class?
        end
      end
      team_info(rival_id)['team_name']
    end
  # end

  # def rival(team_id)
    # opponent_stats = Hash.new { |opponent_id, stats| opponent_id[stats] = [0.0, 0.0, 0.0] } #[games_played, games_won]
    # games.each do |game|
    #   if game.home_team_id == team_id #|| row[:home_team_id] == team_id
    #     opponent_stats[game.away_team_id][0] += 1
    #     if game.home_goals > game.away_goals
    #       opponent_stats[game.away_team_id][1] += 1
    #     end
    #   end
    #
    #   if game.away_team_id == team_id
    #     opponent_stats[game.home_team_id][0] += 1
    #     if game.away_goals > game.home_goals
    #       opponent_stats[game.home_team_id][1] += 1
    #     end
    #   end
    # end

  end
end
