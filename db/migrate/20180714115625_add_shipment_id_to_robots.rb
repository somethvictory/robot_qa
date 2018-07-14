class AddShipmentIdToRobots < ActiveRecord::Migration[5.1]
  def change
    add_reference :robots, :shipment, foreign_key: true
  end
end
