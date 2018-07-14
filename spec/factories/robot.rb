FactoryBot.define do
  factory :robot do
    name FFaker::Name.first_name
    has_sentience true
    has_wheels true
    has_tracks true
    number_of_rotors 4

    association :color

    trait(:with_shipment) do
      after(:build) do |robot, _evaluator|
        robot.shipment_id = create(:shipment).id
      end
    end

    trait(:qa_passed) do
      number_of_rotors 4
      has_wheels false
      has_tracks false
      has_sentience false

      after(:build) do |robot, _evaluator|
        robot.statuses << build(:status, name: 'rusty')
      end
    end

    trait(:shippable) do
      number_of_rotors 4
      has_wheels false
      has_tracks false
      has_sentience false
    end

    trait(:factory_second) do
      number_of_rotors 4
      has_wheels false
      has_tracks false
      has_sentience false

      after(:build) do |robot, _evaluator|
        robot.statuses << build(:status, name: 'loose_screws')
      end
    end

    trait(:rusty) do
      after(:build) do |robot, _evaluator|
        robot.statuses << build(:status, name: 'rusty')
      end
    end

    trait(:on_fire) do
      after(:build) do |robot, _evaluator|
        robot.statuses << build(:status, name: 'on_fire')
      end
    end

    trait(:loose_screws) do
      after(:build) do |robot, _evaluator|
        robot.statuses << build(:status, name: 'loose_screws')
      end
    end
  end
end
