class RobotCollectionService
  attr_reader :robots

  def initialize(robots)
    @robots = robots
  end

  def recycle
    begin
      Robot.transaction do
        robots.each do |robot|
          robot.destroy! if robot.should_recycle?
        end
      end
      true
    rescue
      false
    end
  end
end
