require 'rails_helper'

RSpec.describe Robot, 'Validations', type: :model do
  it { is_expected.to validate_presence_of(:name)  }
  it { is_expected.to validate_presence_of(:color) }
end

RSpec.describe Robot, 'Associations', type: :model do
  it { is_expected.to belong_to(:color)  }
  it { is_expected.to have_and_belong_to_many(:statuses)  }
end

RSpec.describe Robot, 'Class Methods', type: :model do
  let!(:robot1) { FactoryBot.create(:robot, :shippable, :qa_passed)      }
  let!(:robot2) { FactoryBot.create(:robot, :shippable, :factory_second) }
  let!(:robot3) { FactoryBot.create(:robot) }
  let!(:robot4) { FactoryBot.create(:robot, :with_shipment)  }

  context 'when querying non_shipped' do
    it 'returns non shipped robots' do
      robots = Robot.non_shipped

      expect(robots.size).to eq 3
      expect(robots.pluck(:id).sort).to eq [robot1.id, robot2.id, robot3.id].sort
    end
  end

  context 'when querying shippable' do
    it 'returns shippable robots' do
      robots = Robot.shippable

      expect(robots.size).to eq 2
      expect(robots.pluck(:id).sort).to eq [robot1.id, robot2.id].sort
    end
  end

  context 'when querying qa_passed' do
    it 'returns qa passed robots' do
      robots = Robot.qa_passed

      expect(robots.size).to eq 1
      expect(robots.first.id).to eq robot1.id
    end
  end
end

RSpec.describe Robot, 'Instance Methods', type: :model do
  let(:robot) { FactoryBot.create(:robot, :rusty) }

  it 'returns all the status names', '#status_names' do
    expect(robot.status_names).to eq ['rusty']
  end

  context 'should recycle' do
    it 'returns true when robot statuses include on fire' do
      robot = FactoryBot.create(:robot, :on_fire)
      expect(robot.should_recycle?).to eq true
    end

    it 'returns true when the robot has invalid rotors' do
      robot = FactoryBot.create(:robot, number_of_rotors: 3)
      expect(robot.should_recycle?).to eq true
    end

    it 'returns true when the robot has any rotors and color is blue' do
      color = FactoryBot.create(:color, name: 'blue')
      robot = FactoryBot.create(:robot, number_of_rotors: 3, color: color)
      expect(robot.should_recycle?).to eq true
    end

    it 'returns true when the robot has wheels and has tracks' do
      robot = FactoryBot.create(:robot, has_wheels: true, has_tracks: true)
      expect(robot.should_recycle?).to eq true
    end

    it 'returns true when the robot has wheels and statuses include rusty' do
      robot = FactoryBot.create(:robot, :rusty, has_wheels: true)
      expect(robot.should_recycle?).to eq true
    end

    it 'returns true when the robot has sentience and statuses include loose_screws' do
      robot = FactoryBot.create(:robot, :loose_screws, has_wheels: true)
      expect(robot.should_recycle?).to eq true
    end
  end

  context 'should not recycle' do
    it 'returns false when the robot is not on fire with other valid conditions' do
      color = FactoryBot.create(:color, name: 'green')
      robot = FactoryBot.create(:robot, has_wheels: false, has_tracks: false, has_sentience: false, color: color)
      expect(robot.should_recycle?).to eq false
    end

    it 'returns false when the robot has wheels with other valid conditions' do
      color = FactoryBot.create(:color, name: 'green')
      robot = FactoryBot.create(:robot, has_wheels: true, has_tracks: false, has_sentience: false, color: color)
      expect(robot.should_recycle?).to eq false
    end

    it 'returns false when the robot has tracks with other valid conditions' do
      color = FactoryBot.create(:color, name: 'green')
      robot = FactoryBot.create(:robot, has_wheels: false, has_tracks: true, has_sentience: false, color: color)
      expect(robot.should_recycle?).to eq false
    end

    it 'returns false when the robot has sentience with other valid conditions' do
      color = FactoryBot.create(:color, name: 'green')
      robot = FactoryBot.create(:robot, has_wheels: false, has_tracks: false, has_sentience: true , color: color)
      expect(robot.should_recycle?).to eq false
    end

    it 'returns false when the robot has statuses include rusty with other valid conditions' do
      color = FactoryBot.create(:color, name: 'green')
      robot = FactoryBot.create(:robot, :rusty, has_wheels: false, has_tracks: false, has_sentience: true , color: color)
      expect(robot.should_recycle?).to eq false
    end

    it 'returns false when the robot has statuses include loose screws with other valid conditions' do
      color = FactoryBot.create(:color, name: 'green')
      robot = FactoryBot.create(:robot, :loose_screws, has_wheels: false, has_tracks: false, has_sentience: false, color: color)
      expect(robot.should_recycle?).to eq false
    end
  end

  context 'when rusty' do
    it 'returns true when its statuses include rusty' do
      robot = FactoryBot.create(:robot, :rusty)
      expect(robot.rusty?).to eq true
    end

    it 'returns false when its statuses do not include rusty' do
      robot = FactoryBot.create(:robot)
      expect(robot.rusty?).to eq false
    end
  end

  context 'when loose_screws' do
    it 'returns true when its statuses include loose_screws' do
      robot = FactoryBot.create(:robot, :loose_screws)
      expect(robot.loose_screws?).to eq true
    end

    it 'returns false when its statuses include do not loose_screws' do
      robot = FactoryBot.create(:robot)
      expect(robot.loose_screws?).to eq false
    end
  end

  context 'when on fire' do
    it 'returns true when its statuses include on fire' do
      robot = FactoryBot.create(:robot, :on_fire)
      expect(robot.on_fire?).to eq true
    end

    it 'returns false when its statuses include do not on fire' do
      robot = FactoryBot.create(:robot)
      expect(robot.on_fire?).to eq false
    end
  end

  context 'with rotors' do
    it 'returns true when its rotors is not zero' do
      robot = FactoryBot.create(:robot)
      expect(robot.has_rotors?).to eq true
    end

    it 'returns false when its is zero' do
      robot = FactoryBot.create(:robot, number_of_rotors: 0)
      expect(robot.has_rotors?).to eq false
    end

    it 'returns false when its is less than zero' do
      robot = FactoryBot.create(:robot, number_of_rotors: -1)
      expect(robot.has_rotors?).to eq false
    end
  end

  context 'valid rotors' do
    it 'returns true when number of rotors is between min and max limitation' do
      robot = FactoryBot.create(:robot, number_of_rotors: 4)
      expect(robot.valid_rotors?).to eq true
    end

    it 'returns false when number of rotors is less than min limitation' do
      robot = FactoryBot.create(:robot, number_of_rotors: 2)
      expect(robot.valid_rotors?).to eq false
    end

    it 'returns false when number of rotors is greater than max limitation' do
      robot = FactoryBot.create(:robot, number_of_rotors: 9)
      expect(robot.valid_rotors?).to eq false
    end
  end
end
