require 'rails_helper'

RSpec.describe RobotCollectionService, 'Instance Methods' do
  context 'when recycle' do
    it 'deletes recycle robots' do
      robot = FactoryBot.create(:robot)
      subject = RobotCollectionService.new([robot])
      allow(robot).to receive(:should_recycle?).and_return(true)

      expect(subject.recycle).to eq true
      expect {
        Robot.find(robot.id)
      }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it 'does not delete the robot' do
      robot = FactoryBot.create(:robot)
      subject = RobotCollectionService.new([robot])
      allow(robot).to receive(:should_recycle?).and_return(false)

      subject.recycle
      expect(Robot.find(robot.id)).to be_persisted
    end
  end
end
