require 'rails_helper'

RSpec.describe Rating, type: :model do
  let(:rating) { FactoryGirl::create :rating }

  it { expect(rating).to validate_presence_of :rating }
  it { expect(rating).to validate_inclusion_of(:rating).in_range(1..10) }

  it { expect(rating).to belong_to :customer }
end
