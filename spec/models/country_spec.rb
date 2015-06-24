require 'rails_helper'

RSpec.describe Country, type: :model do
  let(:country) { FactoryGirl::create :country }

  it { expect(country).to validate_presence_of :name }
  it { expect(country).to validate_uniqueness_of :name }
end
