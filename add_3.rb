require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

# binding.pry

def starter #Message d'intro

  puts "-------------------------------------------------"
  puts "|Bienvenue sur 'ILS VEULENT TOUS MA POO' !      |"
  puts "|Le but du jeu est d'être le dernier survivant !|"
  puts "-------------------------------------------------"
end

def initialize_human_player_name #permets de générer un 

  puts "Bien le bonjour jeune aventurier intrépide, dit moi quel est ton nom"
  print ">"
  player_name = gets.chomp
  puts "Bien que le massacre commence aventurier #{player_name}"
  return player_name
end

def initialize_enemys #permets de générer un 

  puts "Combien d'enemies soit tu affronter aujourd'hui ?"
  print ">"
  numbers_of_enemys = gets.chomp.to_i
  return numbers_of_enemys
end

def choice(my_game) #Choix de l'action du joueur

  while
    r = ""
    print "> "
    r = gets.chomp
  
    if r == "a" || r == "s"
      return r
      break
    elsif r.to_i <= my_game.enemies_in_sight.length && r.to_i > 0 
      return r
      break
    else
      puts "Je n'ai pas compris ton choix recommance :"
    end
  end
end

def round(my_game) #dérouler d'un tour de jeu

  my_game.new_players_in_sight
  my_game.show_players

  my_game.menu
  choice_result = choice(my_game)
  my_game.menu_choice(choice_result)

  puts ""
  puts "C'est au tour des enemies"
  print "> "
  gets.chomp
  my_game.enemies_attack

  puts "Passons au tour suivant"
  print "> "
  gets.chomp
  puts ""
  puts "-------------------------------------------------"
  puts ""
end

def perform #articule toutes les méthodes

  puts ""
  starter
  puts ""

  name = initialize_human_player_name
  puts ""
  numbers_of_enemys = initialize_enemys
  my_game = Game.new(name, numbers_of_enemys)
  puts ""
  puts "-------------------------------------------------"
  puts ""
    
  while my_game.is_still_ongoing?
    round (my_game)
  end
  
  my_game.end
  puts ""
end

perform