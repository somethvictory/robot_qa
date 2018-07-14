require 'rails_helper'

RSpec.describe Status, 'Validations', type: :model do
  it { is_expected.to validate_presence_of(:name) }
end

RSpec.describe Status, 'Associations', type: :model do
  it { is_expected.to have_and_belong_to_many(:robots) }
end

RSpec.describe Status, 'Class Methods', type: :model do
  it { expect(Status).to respond_to(:on_fire)         }
  it { expect(Status).to respond_to(:rusty)           }
  it { expect(Status).to respond_to(:loose_screws)    }
  it { expect(Status).to respond_to(:paint_scratched) }
end
