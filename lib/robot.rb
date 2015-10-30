require 'pry'

class Robot

  attr_reader :position, :items, :items_weight, :health, :shield
  attr_accessor :equipped_weapon

  MAX_HEALTH = 100
  MAX_SHIELD = 50
  MAX_WEIGHT = 250

  @@robot_list = []

  def initialize
    @position = [0,0]
    @items = []
    @items_weight = 0
    @health = MAX_HEALTH
    @shield = MAX_SHIELD
    @@robot_list << self
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

    if @items_weight < MAX_WEIGHT then
      @items << item
      @equipped_weapon = item if item.class.superclass == Weapon
      item.feed(self) if self.health <= 80 && item.class == BoxOfBolts
      @items_weight += item.weight
    end

  end

  def wound(amount)
    if shield <= 0 then
      @health -= amount
      @health = 0 if @health < 0
    else
      @shield -= amount
      @shield = 0 if @shield < 0
    end
  end

  def heal(amount)
    @health = [@health + amount, MAX_HEALTH].min
  end

  def heal!
    raise RobotAlreadyDeadError if @health == 0
    @health = MAX_HEALTH
  end

  def recharge_shield
    @shield = MAX_SHIELD
  end

  def attack(robot)
    raise NotARobotError unless robot.class == Robot
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
    is_on = @position == robot.position

    is_above || is_below || is_left_of || is_right_of || is_on
  end

  def scan
    pos_x = @position[0]
    pos_y = @position[1]

    at_left = Robot.in_position(pos_x - 1, pos_y)
    at_right = Robot.in_position(pos_x + 1, pos_y)
    above = Robot.in_position(pos_x, pos_y + 1)
    below = Robot.in_position(pos_x, pos_y - 1)

    at_left + at_right + above + below
  end

  class << self

    def in_position(x, y)
      counter = 0
      @@robot_list.each do |robot|
        counter += 1 if robot.position == [x,y]
      end
      counter
    end

    def robot_list
      @@robot_list
    end

    def list_reset
      @@robot_list = []
    end

  end

end

class NotARobotError < StandardError
end
class RobotAlreadyDeadError < StandardError
end