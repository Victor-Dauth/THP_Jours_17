require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

# binding.pry

def test_player #mes test pour la class Player

  player1 = Player.new("Josiane")
  player2 = Player.new("José")
  player3 = Player.new("JoJo")

  puts player1.name
  puts player1.life_points
  puts ""

  player1.show_state
  puts ""

  player1.gets_domage(3)
  player1.show_state
  player1.gets_domage(5)
  player1.show_state
  player1.gets_domage(4)
  player1.show_state
  puts ""

  player2.attacks(player3)
  player2.show_state
  player3.show_state
  puts ""
end

player1 = Player.new("Josiane")
player2 = Player.new("José")

while player1.life_points > 0 && player2.life_points > 0
  puts "Voici l'état de chaque joueur :"
  player1.show_state
  player2.show_state
  puts ""

  puts "Passons à la phase d'attaque :"
  player1.attacks(player2)
  break if player2.life_points < 1
  player2.attacks(player1)
  break if player1.life_points < 1
  puts ""

  puts "appuis sur entrer pour passer au rond suivant"
  print ">"
  gets.chomp
  puts ""
  puts "-------------------------------------------------------------"
  puts ""
end


