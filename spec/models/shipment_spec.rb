require 'rails_helper'

RSpec.describe Shipment, 'Associations', type: :model do
  it { is_expected.to have_many(:robots) }
end
