require_relative 'spec_helper'

describe Robot do
  before :each do
    @robot1 = Robot.new
    @robot2 = Robot.new
  end

  describe "#in_position(x,y)" do
    it "should return 2 for (0,0) and 0 for (1,0)" do
      expect(Robot.in_position(0,0)).to eq 2
      expect(Robot.in_position(1,0)).to eq 0
    end
  end

end
