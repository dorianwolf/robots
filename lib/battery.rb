class Battery < Item

  def initialize
    super("Battery", 25)
  end

  def recharge(robot)
    robot.recharge_shield
  end

end