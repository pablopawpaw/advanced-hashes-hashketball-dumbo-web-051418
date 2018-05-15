
def game_hash
  bball_hash = {
    home: {
      team_name: "Brooklyn Nets",
      colors: ["Black","White"],
      players: {
        "Alan Anderson" => {
          number: 0,
          shoe: 16,
          points: 22,
          rebounds: 12,
          assists: 12,
          steals: 3,
          blocks: 1,
          slam_dunks: 1
        },
        "Reggie Evans" => {
          number: 30,
          shoe: 14,
          points: 12,
          rebounds: 12,
          assists: 12,
          steals: 12,
          blocks: 12,
          slam_dunks: 7
        },
        "Brook Lopez" => {
          number: 11,
          shoe: 17,
          points: 17,
          rebounds: 19,
          assists: 10,
          steals: 3,
          blocks: 1,
          slam_dunks: 15
        },
        "Mason Plumlee" => {
          number: 1,
          shoe: 19,
          points: 26,
          rebounds: 12,
          assists: 6,
          steals: 3,
          blocks: 8,
          slam_dunks: 5
        },
        "Jason Terry" => {
          number: 31,
          shoe: 15,
          points: 19,
          rebounds: 2,
          assists: 2,
          steals: 4,
          blocks: 11,
          slam_dunks: 1
        }
      }
    },
    away: {
      team_name: "Charlotte Hornets",
      colors: ["Turquoise","Purple"],
      players: {
        "Jeff Adrien" => {
          number: 4,
          shoe: 18,
          points: 10,
          rebounds: 1,
          assists: 1,
          steals: 2,
          blocks: 7,
          slam_dunks: 2
        },
        "Bismak Biyombo" => {
          number: 0,
          shoe: 16,
          points: 12,
          rebounds: 4,
          assists: 7,
          steals: 7,
          blocks: 15,
          slam_dunks: 10
        },
        "DeSagna Diop" => {
          number: 2,
          shoe: 14,
          points: 24,
          rebounds: 12,
          assists: 12,
          steals: 4,
          blocks: 5,
          slam_dunks: 5
        },
        "Ben Gordon" => {
          number: 8,
          shoe: 15,
          points: 33,
          rebounds: 3,
          assists: 2,
          steals: 1,
          blocks: 1,
          slam_dunks: 0
        },
        "Brendan Haywood" => {
          number: 33,
          shoe: 15,
          points: 6,
          rebounds: 12,
          assists: 12,
          steals: 22,
          blocks: 5,
          slam_dunks: 12
        }
      }
    }
  }
end

def num_points_scored(player_name)
  #final attempt--satisfied :)
  player_list = game_hash[:home][:players].merge(game_hash[:away][:players])
  player_list.include?(player_name) ? player_list[player_name][:points] : "#{player_name} is not on the roster."
  #second attempt
=begin
  home_players = game_hash[:home][:players]
  away_players = game_hash[:away][:players]
  if home_players.include?(player_name)
    home_players[player_name][:points]
  elsif away_players.include?(player_name)
    away_players[player_name][:points]
  else
    "#{player_name} is not on the roster."
  end
=end
  #first attempt
=begin
  game_hash.collect { |h_a, team|
    team.collect { |details, stats|
      if details == :players
        stats.collect { |name, value|
          if name == player_name
            value.collect { |stat, stat_v|
              if stat == :points
                return stat_v
              end
            }
          end
        }
      else
        false
      end
    }
  }
=end
end

def shoe_size(player_name)
  player_list = game_hash[:home][:players].merge(game_hash[:away][:players])
  if player_list.include?(player_name)
    player_list.fetch(player_name)[:shoe]
  else
    puts "Player is not on either team's rosters."
  end
end

def team_colors(team_name)
  home_name = game_hash[:home][:team_name]
  away_name = game_hash[:away][:team_name]
  home_colors = game_hash[:home][:colors]
  away_colors = game_hash[:away][:colors]

  if team_name == home_name
    home_colors
  elsif
    team_name == away_name
    away_colors
  else
    puts "Requested #{team_name} is not on the roster."
  end
end

def team_names
  #deeming best way
  #orig avgd 6.28s 5x
  #updated avgd 5.06s 5x
  teams = []
  game_hash.each do |location, team_data|
    teams << team_data[:team_name]
  end
  #original way
=begin
  home_team = game_hash[:home][:team_name]
  away_team = game_hash[:away][:team_name]
  roster_teams = []
  roster_teams << home_team
  roster_teams << away_team
  roster_teams
=end
end

def player_numbers(name_of_team)
  playa_nums = []
  game_hash.map do |location, team_data|
    if name_of_team == team_data[:team_name]
      team_data[:players].map do |name, stats|
        playa_nums << stats[:number]
      end
    end
  end
  playa_nums.compact.flatten
#original / first
=begin
  player_numbers = []
  game_hash.collect do |h_a, team|
    team.collect do |info, detail|
      if detail == name_of_team
        team.collect do |info2, detail2|
          if info2 == :players
            detail2.collect do |stats, value|
              value.collect do |num, tiny|
                if num == :number
                  player_numbers << tiny
                end
              end
            end
          end
        end
      end
    end
  end
  player_numbers.sort
=end
end

def player_stats(name_of_player)
  game_hash.each do |location, team_data|
    team_data[:players].each do |name, stats|
      if name_of_player == name
        return stats
      else
        "#{name_of_player} can't be found on the roster."
      end
    end
  end
#orig / first attempt
=begin
  home_team = game_hash[:home]
  away_team = game_hash[:away]
  home_team_players = home_team[:players]
  away_team_players = away_team[:players]
  home_team_players_stats = home_team_players[name_of_player]
  away_team_players_stats = away_team_players[name_of_player]

  if home_team_players.include?(name_of_player)
    home_team_players_stats
  elsif away_team_players.include?(name_of_player)
    away_team_players_stats
  else
    "#{name_of_player} is not on either team's rosters."
  end
=end
end

def big_shoe_rebounds
  #much better improvement
  largest_shoe_size = 0
  big_foot_player = nil
  game_hash.each do |location, team_data|
    team_data[:players].each do |name, stats|
      if largest_shoe_size < stats[:shoe]
        largest_shoe_size = stats[:shoe]
        big_foot_player = name
      end
    end
  end
  big_foot_player
  #orig / first attempt
=begin
  shoe_sizes = []
  #get shoe sizes of all players
  game_hash.collect do |team, category|
    category.collect do |group, detail|
      if group == :players
        detail.collect do |name, stats|
          stats.collect do |key, value|
            if key == :shoe
              shoe_sizes << value
            end
          end
        end
      end
    end
  end
  #determine largest shoe size
  largest_shoes = shoe_sizes.max
  #find player who has the largest shoe size
  big_foot = ""
  game_hash.collect do |team, category|
    category.collect do |group, detail|
      if group == :players
        detail.collect do |name, stats|
          stats.collect do |key, value|
            if key == :shoe
              if value == largest_shoes
                big_foot << name
              end
            end
          end
        end
      end
    end
  end
  big_foot
  #get stats using other method and retrieve rebound value
  player_stats(big_foot)[:rebounds]
=end
end

def most_points_scored
  #find highest number of points
  #determine who that number belongs to
  #return player name

  points_scored = []
  game_hash.collect do |team, category|
    category.collect do |group, detail|
      if group == :players
        detail.collect do |name, stats|
          stats.collect do |key, value|
            if key == :points
              points_scored << value
            end
          end
        end
      end
    end
  end
  mvp_points = points_scored.max

  mvp_name = ""
  game_hash.collect do |team, category|
    category.collect do |group, detail|
      if group == :players
        detail.collect do |name, stats|
          stats.collect do |key, value|
            if key == :points
              if value == mvp_points
                mvp_name << name
              end
            end
          end
        end
      end
    end
  end

  "#{mvp_name}: #{mvp_points}"

end

def winning_team
  #sum up players' scored points for each team
  #totals
  #return team with more points
  home = game_hash[:home][:players]
  away = game_hash[:away][:players]
  home_score = 0
  away_score = 0
  home_name = game_hash[:home][:team_name]
  away_name = game_hash[:away][:team_name]

  home.collect do |name, stats|
    stats.collect do |key, value|
      if key == :points
        home_score+=value
      end
    end
  end

  away.collect do |name, stats|
    stats.collect do |key, value|
      if key == :points
        away_score+=value
      end
    end
  end

  if home_score > away_score
    "#{home_name} is the winner!"
  elsif away_score > home_score
    "#{away_name} is the winner!"
  else
    "Calculation Error"
  end

end

def player_with_longest_name
  #get list of all player names
  #check num of char in all names
  #retrieve longest and return that player's name
  players_on_roster = []

  game_hash.collect do |team, category|
    category.collect do |group, detail|
      if group == :players
        detail.collect do |key, value|
          players_on_roster << key
        end
      end
    end
  end

  length_of_player_names = []
  players_on_roster.collect do |name|
    length_of_player_names << name.length
  end
  longest_name_length = length_of_player_names.max

  i=0
  while i<players_on_roster.length do
    if players_on_roster[i].length == longest_name_length
      return players_on_roster[i]
    end
    i+=1
  end

end

def long_name_steals_a_ton?
  #get list of all steal stats
  #determine most steals
  #figure out who had the most steals
  #compare to player with longest name
  #return true if player with longest name had the most steals
  steal_stats = []

  game_hash.collect do |team, category|
    category.collect do |group, detail|
      if group == :players
        detail.collect do |name, stats|
          stats.collect do |key, value|
            if key == :steals
              steal_stats << value
            end
          end
        end
      end
    end
  end
  most_steals = steal_stats.max

  most_steals_name = ""
  game_hash.collect do |team, category|
    category.collect do |group, detail|
      if group == :players
        detail.collect do |name, stats|
          stats.collect do |key, value|
            if key == :steals
              if value == most_steals
                most_steals_name << name
              end
            end
          end
        end
      end
    end
  end

  if player_with_longest_name == most_steals_name
    true
  else
    false
  end

end
