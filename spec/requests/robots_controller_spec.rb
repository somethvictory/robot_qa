require 'spec_helper'

RSpec.describe RobotsController, type: :controller do
  context 'index' do
    let!(:robot1) { FactoryBot.create(:robot) }
    let!(:robot2) { FactoryBot.create(:robot, :with_shipment) }

    it 'returns non shipped robots' do
      get :index

      results = JSON.parse(response.body)

      expect(response.code).to                                 eq '200'
      expect(results.size).to                                  eq 1
      expect(results[0]['id']).to                              eq robot1.id
      expect(results[0]['name']).to                            eq robot1.name
      expect(results[0]['name']).to                            eq robot1.name
      expect(results[0]['configuration']['hasSentience']).to   eq robot1.has_sentience
      expect(results[0]['configuration']['hasWheels']).to      eq robot1.has_wheels
      expect(results[0]['configuration']['hasTracks']).to      eq robot1.has_tracks
      expect(results[0]['configuration']['numberOfRotors']).to eq robot1.number_of_rotors
      expect(results[0]['configuration']['color']).to          eq robot1.color_name.titleize
      expect(results[0]['configuration']['statuses']).to       eq robot1.status_names.map { |s| s.titleize }
    end
  end

  context 'qa_passed' do
    let!(:robot1) { FactoryBot.create(:robot, :qa_passed)      }
    let!(:robot2) { FactoryBot.create(:robot, :factory_second) }
    let!(:robot3) { FactoryBot.create(:robot) }
    let!(:robot4) { FactoryBot.create(:robot, :with_shipment)  }

    it 'returns qa passed robots' do
      get :qa_passed

      results = JSON.parse(response.body)

      expect(response.code).to                                 eq '200'
      expect(results.size).to                                  eq 1
      expect(results[0]['id']).to                              eq robot1.id
      expect(results[0]['name']).to                            eq robot1.name
      expect(results[0]['configuration']['hasSentience']).to   eq robot1.has_sentience
      expect(results[0]['configuration']['hasWheels']).to      eq robot1.has_wheels
      expect(results[0]['configuration']['hasTracks']).to      eq robot1.has_tracks
      expect(results[0]['configuration']['numberOfRotors']).to eq robot1.number_of_rotors
      expect(results[0]['configuration']['color']).to          eq robot1.color_name.titleize
      expect(results[0]['configuration']['statuses']).to       eq robot1.status_names.map { |s| s.titleize }
    end
  end

  context 'factory_second' do
    let!(:robot1) { FactoryBot.create(:robot, :factory_second) }
    let!(:robot2) { FactoryBot.create(:robot) }
    let!(:robot3) { FactoryBot.create(:robot, :with_shipment)  }
    let!(:robot4) { FactoryBot.create(:robot, :qa_passed)      }

    it 'returns factory second robots' do
      get :factory_second

      results = JSON.parse(response.body)

      expect(response.code).to                                 eq '200'
      expect(results.size).to                                  eq 1
      expect(results[0]['id']).to                              eq robot1.id
      expect(results[0]['name']).to                            eq robot1.name
      expect(results[0]['configuration']['hasSentience']).to   eq robot1.has_sentience
      expect(results[0]['configuration']['hasWheels']).to      eq robot1.has_wheels
      expect(results[0]['configuration']['hasTracks']).to      eq robot1.has_tracks
      expect(results[0]['configuration']['numberOfRotors']).to eq robot1.number_of_rotors
      expect(results[0]['configuration']['color']).to          eq robot1.color_name.titleize
      expect(results[0]['configuration']['statuses']).to       eq robot1.status_names.map { |s| s.titleize }
    end
  end

  context 'when extinguish' do
    let!(:robot) { FactoryBot.create(:robot, :on_fire) }

    it 'removes on fire status from the robot' do
      post :extinguish, params: {id: robot.id}

      robot.reload

      expect(response.code).to eq '200'
      expect(robot.statuses.on_fire).to be_nil
    end
  end

  context 'when recycle' do
    let!(:robot1) { FactoryBot.create(:robot, has_wheels: true, has_tracks: true) }
    let!(:robot2) { FactoryBot.create(:robot, :rusty, has_wheels: true) }

    it 'deletes the robots' do
      expect {
        post :recycle, params: { recycleRobots: [robot1.id, robot2.id] }
      }.to change { Robot.count }.from(2).to(0)

      expect(response.code).to eq '200'
    end
  end
end
