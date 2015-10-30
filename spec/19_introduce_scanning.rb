require_relative 'spec_helper'

describe Robot do
  before :each do
    Robot.list_reset
    @robot1 = Robot.new
    @robot2 = Robot.new
    @robot2b = Robot.new
    @robot3 = Robot.new
    @robot2.move_up
    @robot2b.move_up
    @robot3.move_left
    @robot3.move_left
  end

  describe "#scan" do
    it "robots 1, 2, and 3 should see 2, 1, and 0 robots respectively" do
      expect(@robot1.scan).to eq 2
      expect(@robot2.scan).to eq 1
      expect(@robot3.scan).to eq 0
    end
  end

end
