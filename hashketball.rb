# Write your code here!
# Write your code here!
require 'pry'
def game_hash
    {
        :home => {
            :team_name => "Brooklyn Nets",
            :colors => ["Black", "White"],
            :players => [
                {
                    :name => "Alan Anderson",
                    :number => 0,
                    :shoe => 16,
                    :points => 22,
                    :rebounds => 12,
                    :assists => 12,
                    :steals => 3,
                    :blocks => 1,
                    :slam_dunks => 1
                },
                {
                    :name => "Reggie Evans",
                    :number => 30,
                    :shoe => 14,
                    :points => 12,
                    :rebounds => 12,
                    :assists => 12,
                    :steals => 12,
                    :blocks => 12,
                    :slam_dunks => 7
                },
                {
                    :name => "Brook Lopez",
                    :number => 11,
                    :shoe => 17,
                    :points => 17,
                    :rebounds => 19,
                    :assists => 10,
                    :steals => 3,
                    :blocks => 1,
                    :slam_dunks => 15
                },
                {
                    :name => "Mason Plumlee",
                    :number => 1,
                    :shoe => 19,
                    :points => 26,
                    :rebounds => 11,
                    :assists => 6,
                    :steals => 3,
                    :blocks => 8,
                    :slam_dunks => 5
                },
                {
                    :name => "Jason Terry",
                    :number => 31,
                    :shoe => 15,
                    :points => 19,
                    :rebounds => 2,
                    :assists => 2,
                    :steals => 4,
                    :blocks => 11,
                    :slam_dunks => 1
                },
            ],
        },
        :away => { 
            :team_name => "Charlotte Hornets",
            :colors => ["Turquoise", "Purple"],
            :players => [
                {
                    :name => "Jeff Adrien",
                    :number => 4,
                    :shoe => 18,
                    :points => 10,
                    :rebounds => 1,
                    :assists => 1,
                    :steals => 2,
                    :blocks => 7,
                    :slam_dunks => 2
                },
                {
                    :name => "Bismack Biyombo",
                    :number => 0,
                    :shoe => 16,
                    :points => 12,
                    :rebounds => 4,
                    :assists => 7,
                    :steals => 22,
                    :blocks => 15,
                    :slam_dunks => 10
                },
                {
                    :name => "DeSagna Diop",
                    :number => 2,
                    :shoe => 14,
                    :points => 24,
                    :rebounds => 12,
                    :assists => 12,
                    :steals => 4,
                    :blocks => 5,
                    :slam_dunks => 5
                },
                {
                    :name => "Ben Gordon",
                    :number => 8,
                    :shoe => 15,
                    :points => 33,
                    :rebounds => 3,
                    :assists => 2,
                    :steals => 1,
                    :blocks => 1,
                    :slam_dunks => 0
                },
                {
                    :name => "Kemba Walker",
                    :number => 33,
                    :shoe => 15,
                    :points => 6,
                    :rebounds => 12,
                    :assists => 12,
                    :steals => 7,
                    :blocks => 5,
                    :slam_dunks => 12
                },

            ],
        },
    }
end

def find_player(name)
    game_hash.each do | location, data |
        data.each do | key, values |
            if key == :players
                values.each do |stats|
                    if stats[:name] == name
                        return stats
                    end
                end
            end
        end
    end
end

def find_team(team_name)
    game_hash.each do | location, data |
        if data[:team_name] == team_name
            return data
        end
    end
end


def num_points_scored(name)
    find_player(name)[:points]
end

def shoe_size(name)
    find_player(name)[:shoe]
end

def team_colors(team_name)
    find_team(team_name)[:colors]
end

def team_names
    game_hash.collect do | location, data |
        data[:team_name]
    end
end

def player_numbers(team_name)
    numbers = []
    team = find_team(team_name)
    team.each do | key, values |
        if key == :players
            numbers = values.collect do |stats|
                stats[:number]
            end
        end
    end
    numbers
end

def player_stats(player_name)
    find_player(player_name).select { | key, value | key != :name }
end

def most_a_something(stat)
    max_stat = nil
    max_stat_player = ""
    game_hash.each do | location, data |
        data.each do | key, values |
            if key == :players
                values.each do |stats|
                    if !max_stat || max_stat < stats[stat]
                        max_stat = stats[stat]
                        max_stat_player = stats[:name]
                    end
                end
            end
        end
    end
    max_stat_player
end

def big_shoe_rebounds
    find_player(most_a_something(:shoe))[:rebounds]
end

def most_points_scored
    most_a_something(:points)
end

def winning_team
    team_totals = {}
    game_hash.each do | location, data |
        team_totals[data[:team_name]] = 0
        data.each do | key, values |
            if key == :players
                values.each do |stats|
                    team_totals[data[:team_name]] += stats[:points]
                end
            end
        end
    end
    team_totals.max_by { |key, value| value }[0]
end

def player_with_longest_name
    length = 0
    longest_name = ""
    game_hash.each do | location, data |
        data.each do | key, values |
            if key == :players
                values.each do |stats|
                    if stats[:name].gsub(/\s+/, "").length > length 
                        length = stats[:name].gsub(/\s+/, "").length
                        longest_name = stats[:name]
                    end
                end
            end
        end
    end
    longest_name
end

def most_steals
    most_a_something(:steals)
end

def long_name_steals_a_ton?
    longest_name = player_with_longest_name
    most_steals == longest_name ? true : false
end