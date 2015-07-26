require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:category) { FactoryGirl::create :category_with_books }

  it { expect(category).to validate_presence_of :title }
  it { expect(category).to validate_uniqueness_of :title }
  it { expect(category).to have_and_belong_to_many :books }
end
