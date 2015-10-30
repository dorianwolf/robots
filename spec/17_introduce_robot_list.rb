require_relative 'spec_helper'

describe Robot do

  it "should have a list of robots" do
    Robot.list_reset
    robot1 = Robot.new
    robot2 = Robot.new
    expect(Robot.robot_list[0]).to eq(robot1)
    expect(Robot.robot_list[1]).to eq(robot2)
    Robot.list_reset
  end

end
