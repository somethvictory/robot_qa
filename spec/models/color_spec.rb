require 'rails_helper'

RSpec.describe Color, 'Validations', type: :model do
  it { is_expected.to validate_presence_of(:name) }
end

RSpec.describe Color, 'Associations', type: :model do
  it { is_expected.to have_many(:robots) }
end

RSpec.describe Color, 'Instance Methods', type: :model do
  it { is_expected.to respond_to(:red?)   }
  it { is_expected.to respond_to(:green?) }
  it { is_expected.to respond_to(:blue?)  }
end
