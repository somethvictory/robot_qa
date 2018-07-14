require 'rails_helper'

RSpec.describe ShipmentService, 'Instance Methods' do
  before do
    @robot1 = FactoryBot.create(:robot)
    @robot2 = FactoryBot.create(:robot)
    @subject = ShipmentService.new([@robot1.id, @robot2.id])
  end

  it 'returns true' do
    expect(@subject.create).to eq true
  end

  it 'creates a new shipment' do
    expect { @subject.create }.to change { Shipment.count }.from(0).to(1)
  end

  it 'attaches robots a new shipment' do
    @subject.create
    expect(Shipment.first.robots.order(:id).pluck(:id)).to eq [@robot1.id, @robot2.id].sort
  end
end
