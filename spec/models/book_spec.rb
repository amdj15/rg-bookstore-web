require 'rails_helper'

RSpec.describe Book, type: :model do
  let(:book) { FactoryGirl::create :book }

  it { expect(book).to have_many :order_items }
  it { expect(book).to have_many :ratings }
  it { expect(book).to belong_to :author }
  it { expect(book).to belong_to :category }

  it { expect(book).to validate_presence_of :title }
  it { expect(book).to validate_presence_of :price }

  it { expect(book).to validate_presence_of :books_in_stock }
  it { expect(book).to validate_numericality_of(:books_in_stock).is_greater_than_or_equal_to(0) }
end
