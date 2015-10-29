require_relative 'spec_helper'

describe Battery do
  before :each do
    @robot = Robot.new
    @battery = Battery.new
    @robot.pick_up(@battery)
  end

  describe "#initialize" do
    it "should have name Battery and weight 25" do
      expect(@battery.name).to eq("Battery")
      expect(@battery.weight).to eq(25)
    end
  end

  describe "#recharge" do
    it "recharges shield to 50" do
      @robot.wound(40)
      expect(@robot.shield).to eq(10)
      @battery.recharge(@robot)
      expect(@robot.shield).to eq(50)
    end
  end

end
