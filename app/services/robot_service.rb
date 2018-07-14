class RobotService
  attr_reader :robot

  def initialize(robot)
    @robot = robot
  end

  def extinguish
    status = robot.statuses.on_fire
    if status
      robot.statuses.delete(status)
      true
    else
      false
    end
  end
end
