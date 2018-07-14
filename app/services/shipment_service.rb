class ShipmentService
  attr_reader :robot_ids

  def initialize(robot_ids)
    @robot_ids = robot_ids
  end

  def create
    shipment = Shipment.new
    begin
      Shipment.transaction do
        shipment.robot_ids = robot_ids
        shipment.save!
      end
      true
    rescue
      false
    end
  end
end
