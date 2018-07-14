require 'rails_helper'

RSpec.describe RobotService, 'Instance Methods' do
  context 'when extinguish' do
    it 'removes fire status from the robot' do
      robot   = FactoryBot.create(:robot, :on_fire)
      subject = RobotService.new(robot)

      expect(subject.extinguish).to eq true
      expect(robot.status_names).not_to include 'on_fire'
    end

    it 'returns false when the robot does not contain on fire status' do
      robot   = FactoryBot.create(:robot)
      subject = RobotService.new(robot)

      expect(subject.extinguish).to eq false
    end
  end
end
