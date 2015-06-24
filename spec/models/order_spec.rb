require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:order) { FactoryGirl::create :order }

  it { expect(order).to validate_presence_of :total_price }
  it { expect(order).to validate_inclusion_of(:state).in_array(Order.states.values) }

  context "default state" do
    it "should set default state" do
      expect(order).to receive(:defaults_values)
      order.save
    end
  end

  it { expect(order).to belong_to :credit_card }
  it { expect(order).to belong_to :customer }
  it { expect(order).to belong_to :billing_address }
  it { expect(order).to belong_to :shipping_address }

  it { expect(order).to have_many :order_items }

  describe "#add_book" do
    let(:book) { FactoryGirl::create :book }

    it "should change total price" do
      expect { order.add_book book }.to change { order.total_price }
    end

    it "should not to change items length" do
      order.add_book book
      expect { order.add_book book }.not_to change { order.order_items.length }
    end

    it "should to change items length" do
      expect { order.add_book book }.to change { order.order_items.length }
    end
  end
end
