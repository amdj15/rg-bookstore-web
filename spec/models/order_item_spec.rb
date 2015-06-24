require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  let(:item) { FactoryGirl::create :order_item }

  it { expect(item).to validate_presence_of :price }
  it { expect(item).to validate_presence_of :quantity }
  it { expect(item).to belong_to :book }
  it { expect(item).to belong_to :order }
end
