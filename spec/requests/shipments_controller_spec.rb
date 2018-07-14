require 'spec_helper'

RSpec.describe ShipmentsController, type: :controller do

  context 'create' do
    let!(:robot1) { FactoryBot.create(:robot) }
    let!(:robot2) { FactoryBot.create(:robot) }
    it 'creates a new shipment'  do
      expect {
        put :create, params: { robot_ids: [robot1.id, robot2.id]}
      }.to change { Shipment.count }.from(0).to(1)
    end

    it 'attaches robots to the shipment'  do
      put :create, params: { robot_ids: [robot1.id, robot2.id]}
      expect(Shipment.first.robots.pluck(:id).sort).to eq [robot1.id, robot2.id].sort
    end
  end
end
