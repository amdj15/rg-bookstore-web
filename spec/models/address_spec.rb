require 'rails_helper'

RSpec.describe Address, type: :model do
  let(:address) { FactoryGirl::create :address }

  it { expect(address).to validate_presence_of :address }
  it { expect(address).to validate_presence_of :zip }
  it { expect(address).to validate_presence_of :city }
  it { expect(address).to validate_presence_of :phone }

  it { expect(address).to belong_to :country }
end
