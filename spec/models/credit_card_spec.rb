require 'rails_helper'

RSpec.describe CreditCard, type: :model do
  let(:card) { FactoryGirl::create :credit_card }

  it { expect(card).to validate_presence_of :number }
  it { expect(card).to validate_presence_of :CVV }
  it { expect(card).to validate_presence_of :month }
  it { expect(card).to validate_presence_of :year }
  it { expect(card).to validate_presence_of :firstname }
  it { expect(card).to validate_presence_of :lastname }

  it { expect(card).to have_many :orders }
  it { expect(card).to belong_to :customer }
end
