class ShipmentsController < ApplicationController
  def create
    service = ShipmentService.new(params[:robot_ids])
    if service.create
      render json: { robot_ids: service.robot_ids }, status: :created
    else
      render json: { error: 'Invalid robot ids' }, status: :unprocessable_entity
    end
  end
end
