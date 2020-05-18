require 'bundler'
Bundler.require

class Player

  attr_accessor :name, :life_points

  def initialize(name) #permets d'initer les points de vie et le nom du joueur
    
    @life_points = 10
    @name = name if name.is_a?(String)
  end

  def show_state #permet de donner le nombre de points de vie de du joueur

    puts "#{@name} a #{@life_points} points de vie"

  end

  def gets_domage(number_of_domage) #permet de diminuer le nombre de points de vie d'un joueur

    @life_points -= number_of_domage
    @life_points = 0 if @life_points < 0

    puts "le joueur #{@name} a été tué !!!" if @life_points < 1
  end

  def attacks(player_attacked) #permet de gérer les dégat subit

    puts "le joueur #{@name} attaque le joueur #{player_attacked.name} :"
    
    domage = compute_damage
    puts "il lui inflige #{domage} points de dommages"

    player_attacked.gets_domage(domage)

  end

  private #je ne veux pas que les fonction suivant puisse être appeler en dehors de cette classe

  def compute_damage #générateur de dégat

    return rand(1..6)
  end
end



class HumanPlayer < Player

  attr_accessor :weapon_level

  def initialize(name) #on initialise les joueur humain qui sont plus fort que les joueur machine

    super(name)
    @life_points = 100
    @weapon_level = 1
  end

  def search_weapon #permet au joueur humain de cherche une nouvelle arme de niveau 1 à 6

    new_weapon = rand(1..6)
    puts "Tu as trouvé une arme de niveau #{new_weapon}"
    
    if new_weapon > @weapon_level
  
      @weapon_level = new_weapon
      puts "Youhou ! elle est meilleure que ton arme actuelle : tu la prends."
    else

      puts "M@*#$... elle n'est pas mieux que ton arme actuelle..."
    end
  end

  def search_health_pack #permet de chercher un pack de points de vie
    luck = rand(1..6)

    if luck == 1

      puts "Tu n'as rien trouvé... "
    elsif luck.between?(2, 5) 

      puts "Bravo, tu as trouvé un pack de +50 points de vie !"
      @life_points += 50
      @life_points = 100 if @life_points > 100
    else

      puts "Waow, tu as trouvé un pack de +80 points de vie !"
      @life_points += 80
      @life_points = 100 if @life_points > 100
    end
  end

  private #je ne veux pas que les fonction suivant puisse être appeler en dehors de cette classe

  def compute_damage #générateur de dégat

    return rand(1..6) * @weapon_level
  end

end

