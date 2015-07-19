require 'rails_helper'

RSpec.describe Customer, type: :model do
  let(:customer) { FactoryGirl::create :customer }

  it { expect(customer).to validate_presence_of :email }
  it { expect(customer).to validate_uniqueness_of :email }

  it { expect(customer).to validate_presence_of :password }
  it { expect(customer).to validate_presence_of :firstname }
  it { expect(customer).to validate_presence_of :lastname }

  it { expect(customer).to have_many :ratings }
  it { expect(customer).to have_many :reviews }

  it { expect(customer).to respond_to(:create_order) }

  context "#create_order" do
    let(:order) { customer.create_order }

    it "should return order instance" do
      expect(order.class).to be Order
    end

    it "should belong to customer" do
      expect(order.customer).to eq(customer)
    end
  end
end
