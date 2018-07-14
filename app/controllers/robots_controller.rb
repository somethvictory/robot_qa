class RobotsController < ApplicationController
  format 'json'

  def index
    @robots = Robot.includes(:color, :statuses).non_shipped.paginate(page: page, per_page: per_page)
    render json: @robots
  end

  def qa_passed
    @robots = Robot.includes(:color, :statuses).non_shipped.qa_passed
    render json: @robots
  end

  def factory_second
    @robots = Robot.includes(:color, :statuses).non_shipped.factory_second
    render json: @robots
  end

  def extinguish
    robot   = Robot.find(params[:id])
    service = RobotService.new(robot)

    if service.extinguish
      render json: service.robot, status: :ok
    else
      render json: {error: 'The robot is not on fire'}, status: :unprocessable_entity
    end
  end

  def recycle
    robots  = Robot.find(params[:recycleRobots])
    service = RobotCollectionService.new(robots)

    if service.recycle
      render json: service.robots, status: :ok
    else
      render json: {error: 'Unable to recycle the robots'}, status: :unprocessable_entity
    end
  end

  private
  def page
    params[:page] || 1
  end

  def per_page
    params[:per].to_i <= 1000 ? params[:per] : 10
  end
end
