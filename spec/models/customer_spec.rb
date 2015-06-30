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

  context "changed password" do
    it "should changed password hash when update password", yo:true do
      customer.password = "1111"
      allow(customer.class).to receive(:generate_hash).with(customer.password)

      customer.save
    end

    it "should not changed password hash when password is not updated" do
      customer.firstname = Faker::Name.first_name
      expect(customer.class).not_to receive(:generate_hash)

      customer.save
    end
  end

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
