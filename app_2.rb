require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

# binding.pry

=begin
def test #zone de test ne pas tenir compte

  player1 = HumanPlayer.new("Victor")

  puts "#{player1.name} a #{player1.life_points} points de vie et une arme de niveau #{player1.weapon_level}"
  puts ""

  player1.search_weapon
  puts "ton arme est maintenantde nivea #{player1.weapon_level}"
  puts ""

  player1.search_weapon
  puts "ton arme est maintenantde nivea #{player1.weapon_level}"
  puts ""

  player1.search_weapon
  puts "ton arme est maintenantde nivea #{player1.weapon_level}"
  puts ""

  player1.life_points = 10
  puts "on a modifier tes points de vie, tu a maintenant #{player1.life_points} point de vie"
  player1.search_health_pack
  puts "tu a maintenant #{player1.life_points} points de vie"
  puts ""

  player1.search_health_pack
  puts "tu a maintenant #{player1.life_points} points de vie"
  puts ""

  player1.search_health_pack
  puts "tu a maintenant #{player1.life_points} points de vie"
  puts ""
end
=end


def starter

  puts "-------------------------------------------------"
  puts "|Bienvenue sur 'ILS VEULENT TOUS MA POO' !      |"
  puts "|Le but du jeu est d'être le dernier survivant !|"
  puts "-------------------------------------------------"
end


def initialize_human_player #permets de générer un 

  puts "Bien le bonjour jeune aventurier intrépide, dit moi quel est ton nom"
  print ">"
  player_name = gets.chomp
  puts "Bien que le massacre commence aventurier #{player_name}"
  return player_name
end


def initialize_computer_player(number_of_player)

  computer_player_array = []

  number_of_player.times {|number| computer_player_array <<  Player.new("PC#{number + 1}") }

  return computer_player_array
end


def choice_action(enemy_array, listing) #cette méthode initialise un tour de combat
  
  puts "Quelle action veux-tu effectuer ?"
  puts ""
  puts "a - chercher une meilleure arme"
  puts "s - chercher à se soigner "
  puts ""
  puts "attaquer un joueur en vue :"
  enemy_array.map.with_index{|enemy, n| puts "#{n} - #{enemy.name} a #{enemy.life_points} points de vie"}
  puts ""


  while
    r = ""
    print "> "
    r = gets.chomp
  
    if r == "a" || r == "s"
      return r
      break
    elsif r.count(listing) >= 1
      return r
      break
    else
      puts "Je n'ai pas compris ton choix recommance :"
    end
  end

  return
end

def fight(enemy_array, human_player) #cette méthode gère l'ensemble du combat

  listing = []
  enemy_array.each_index {|n| listing << n}
  listing = listing.join
  
  all_life_points_enemys = 0
  enemy_array.each {|enemy| all_life_points_enemys += enemy.life_points}

  while human_player.life_points > 1 && all_life_points_enemys > 1

    choice = choice_action(enemy_array, listing)

    if choice == "a"
      human_player.search_weapon
      puts "ton arme est maintenantde nivea #{human_player.weapon_level}"
    elsif choice == "s"
      human_player.search_health_pack
      puts "tu a maintenant #{human_player.life_points} points de vie"
    elsif choice.count(listing) >= 1
      human_player.attacks(enemy_array[choice.to_i])
    else
      puts "il y a un problème"
    end

    puts "Les autres joueurs t'attaquent !"
    print "> "
    gets.chomp
    enemy_array.each {|enemy| enemy.attacks(human_player) if enemy.life_points > 0}
    puts ""
    puts "il te reste #{human_player.life_points} points de vie"
    puts ""
    puts "Passons au tour suivant"
    print "> "
    gets.chomp

    puts ""
    puts "-------------------------------------------------"
    puts ""
    all_life_points_enemys = 0
    enemy_array.each {|enemy| all_life_points_enemys += enemy.life_points}
  end

end


def end_game (human_life)

  puts "La partie est finie"
  puts "BRAVO ! TU AS GAGNE !" if human_life > 0
  puts "Loser ! Tu as perdu !" if human_life < 1
end


def perform #articule toutes les méthodes

  puts ""
  starter
  puts ""

  human_player = HumanPlayer.new(initialize_human_player)
  puts ""
  puts "-------------------------------------------------"
  puts ""

  enemy_array = initialize_computer_player(2)
  puts "Aujourd'hui tu vas affronter #{enemy_array.length} adversaire :"
  enemy_array.each {|player| puts player.name}
  print""
  gets.chomp
  puts "-------------------------------------------------"
  puts ""
    
  fight(enemy_array, human_player)
  
  end_game (human_player.life_points)
  puts ""
end

perform