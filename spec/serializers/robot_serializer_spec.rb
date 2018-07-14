require 'spec_helper'

RSpec.describe RobotSerializer, 'Instance Methods' do
  let(:subject) { RobotSerializer.new(FactoryBot.create(:robot, :rusty, has_sentience: true, has_wheels: true, has_tracks: true, number_of_rotors: 4)) }

  it 'responds to required json path' do
    expect(subject.to_json).to have_json_path('id')
    expect(subject.to_json).to have_json_type(Integer).at_path('id')
    expect(subject.to_json).to have_json_path('name')
    expect(subject.to_json).to have_json_type(String).at_path('name')
    expect(subject.to_json).to have_json_path('configuration/hasSentience')
    expect(subject.to_json).to have_json_type(TrueClass).at_path('configuration/hasSentience')
    expect(subject.to_json).to have_json_path('configuration/hasWheels')
    expect(subject.to_json).to have_json_type(TrueClass).at_path('configuration/hasWheels')
    expect(subject.to_json).to have_json_path('configuration/hasTracks')
    expect(subject.to_json).to have_json_type(TrueClass).at_path('configuration/hasTracks')
    expect(subject.to_json).to have_json_path('configuration/numberOfRotors')
    expect(subject.to_json).to have_json_type(Integer).at_path('configuration/numberOfRotors')
    expect(subject.to_json).to have_json_path('configuration/color')
    expect(subject.to_json).to have_json_type(String).at_path('configuration/color')
    expect(subject.to_json).to have_json_path('configuration/statuses')
    expect(subject.to_json).to have_json_type(Array).at_path('configuration/statuses')
  end
end
