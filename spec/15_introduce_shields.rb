require_relative 'spec_helper'

describe Robot do
  before :each do
    @robot = Robot.new
  end

  describe "#shield" do
    it "should be 50" do
      expect(@robot.shield).to eq(50)
    end
  end

  describe "#wound" do
    it "decreases shield first" do
      @robot.wound(40)
      expect(@robot.shield).to eq(10)
      expect(@robot.health).to eq(100)
    end

    it "deals health damage when shield reaches 0" do
      @robot.wound(50)
      @robot.wound(40)
      expect(@robot.shield).to eq(0)
      expect(@robot.health).to eq(60)
    end
  end

end
