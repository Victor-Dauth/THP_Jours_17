require 'bundler'
Bundler.require

require_relative 'player'

class Game

  attr_accessor :human_player, :enemies_in_sight, :enemies_left

  def initialize(name, i) #permets d'initer les points de vie et le nom du joueur
    
    @human_player = HumanPlayer.new(name)
    @enemies_in_sight = []
    @enemies_left = []
    i.times {|i| @enemies_left << Player.new("enemies#{i + 1}")}
  end

  def kill_player(choice) #permet de suprimer un enemys mord

    @enemies_in_sight.delete_at(choice.to_i - 1)
  end

  def is_still_ongoing?

    (@enemies_in_sight.length != 0 || @enemies_left.length != 0) && @human_player.life_points != 0
  end

  def new_players_in_sight

    bad_luck = rand(1..6)

    if bad_luck == 1 || @enemies_left.length == 0
      puts "Ouf, il n'y pas de nouvelles ennemies en vu ce tour si"
    elsif bad_luck >= 2 && bad_luck <= 4
      @enemies_in_sight << @enemies_left[0]
      @enemies_left.delete_at(0)
      puts "Un nouvelle enemie est en vu !!!"
    elsif @enemies_left.length > 1
      @enemies_in_sight << @enemies_left[0]
      @enemies_in_sight << @enemies_left[1]
      @enemies_left.delete_at(0)
      @enemies_left.delete_at(0)
      puts "Deux nouvelles enemies sont en vu. C'est CHAUD !!!"
    else
      @enemies_in_sight << @enemies_left[0]
      @enemies_left.delete_at(0)
      puts "Un nouvelle enemie est en vu !!!"
    end
  end

  def show_players #permet d'afficher l'etat du jeu

    puts "Il te reste #{@human_player.life_points} points de vie et #{@enemies_in_sight.length} enemies en vue. Mais combien en reste t'il au total ?"
  end

  def menu #cette méthode initialise un tour de combat
  
    x = 0

    puts "Quelle action veux-tu effectuer ?"
    puts ""
    puts "a - chercher une meilleure arme"
    puts "s - chercher à se soigner "
    puts ""
    puts "attaquer un enemie en vue :"
    @enemies_in_sight.map.with_index {|enemy, n| puts "#{n + 1} - #{enemy.name} a #{enemy.life_points} points de vie"}
    puts ""
  end

  def menu_choice(choice) #permet d'appliquer le choix du joueur

    if choice == "a"
      @human_player.search_weapon
      puts "ton arme est maintenantde niveau #{@human_player.weapon_level}"
    elsif choice == "s"
      @human_player.search_health_pack
      puts "tu a maintenant #{@human_player.life_points} points de vie"
    elsif choice.to_i <= @enemies_in_sight.length && choice.to_i > 0
      @human_player.attacks(@enemies_in_sight[choice.to_i - 1])
      kill_player(choice) if @enemies_in_sight[choice.to_i - 1].life_points < 1
    else
      puts "il y a un problème"
    end
  end

  def enemies_attack #permet de faire attaquer les enemies

    puts "Tes enemies t'attaquent !"
    @enemies_in_sight.each {|enemy| enemy.attacks(@human_player)}
    puts ""
    puts "il te reste #{@human_player.life_points} points de vie"
    puts ""
  end

  def end #permet d'afficher le message de fin

    puts "La partie est finie"
    puts "BRAVO ! TU AS GAGNE !" if human_player.life_points > 0
    puts "Loser ! Tu as perdu !" if human_player.life_points < 1
  end
end