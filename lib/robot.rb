require 'pry'

class Robot

  attr_reader :position, :items, :items_weight, :health
  attr_accessor :equipped_weapon

  def initialize
    @position = [0,0]
    @items = []
    @items_weight = 0
    @health = 100
    @equipped_weapon = nil
  end

  def move_left
    @position[0] -= 1
  end

  def move_right
    @position[0] += 1
  end

  def move_up
    @position[1] += 1
  end

  def move_down
    @position[1] -= 1
  end

  def pick_up(item)

    if @items_weight < 250 then
      @items << item
      @equipped_weapon = item if item.class.superclass == Weapon
      binding.pry
      item.feed(self) if @health <= 80 && item.class == BoxOfBolts
      @items_weight += item.weight
    end

  end

  def wound(amount)
    @health -= amount
    @health = 0 if @health < 0
  end

  def heal(amount)
    @health += amount
    @health = 100 if @health > 100
  end

  def attack(robot)
    if in_range?(robot) then
      if @equipped_weapon then
        @equipped_weapon.hit(robot)
        @equipped_weapon = nil if @equipped_weapon.class == Grenade
      else
        robot.wound(5)
      end
    end
  end

  def in_range?(robot)
    if @equipped_weapon then
      range = @equipped_weapon.range
    else
      range = 1
    end
    is_above = @position[1] + range == robot.position[1]
    is_below = @position[1] - range == robot.position[1]
    is_left_of = @position[0] - range == robot.position[0]
    is_right_of = @position[0] + range == robot.position[0]

    is_above || is_below || is_left_of || is_right_of
  end

end