require_relative 'spec_helper'

describe Robot do

  it "should have a list of robots" do
    robot1 = Robot.new
    robot2 = Robot.new
    expect(Robot.robot_list[0]).to eq(robot1)
    expect(Robot.robot_list[1]).to eq(robot2)
  end

end
