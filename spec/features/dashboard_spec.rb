require 'rails_helper'

RSpec.feature 'Dashboard', type: :feature, js: true do
  let!(:robot1) { FactoryBot.create(:robot, :qa_passed)      }
  let!(:robot2) { FactoryBot.create(:robot, :factory_second) }
  let!(:robot3) { FactoryBot.create(:robot) }
  let!(:robot4) { FactoryBot.create(:robot, :with_shipment)  }
  background { visit root_path }

  scenario 'display the qa passed robots', js: true do
    expect(page).to have_content('QA Passed')

    within '.qa-passed' do
      expect(page).to have_content(robot1.id)
      expect(page).to have_content(robot1.name)
      expect(page).to have_content(robot1.number_of_rotors)
    end
  end

  scenario 'display the factory second robots', js: true do
    expect(page).to have_content('Factory Second')

    within '.factory-second' do
      expect(page).to have_content(robot2.id)
      expect(page).to have_content(robot2.name)
      expect(page).to have_content(robot2.number_of_rotors)
    end
  end

  scenario 'send shipment' do
    expect(page).to have_content('Ready to ship')

    within '.qa-passed' do
      click_button 'Add to shipment'
    end
    within '.factory-second' do
      click_button 'Add to shipment'
    end
    within '.shipping-list' do
      click_button 'Send shipment'
    end

    expect(page).to have_content("Robots #{robot1.id}, #{robot2.id} is shipped successfully.")
  end
end
