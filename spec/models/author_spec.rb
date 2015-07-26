require 'rails_helper'

RSpec.describe Author, type: :model do
  let(:author) { FactoryGirl::create :author_with_books }

  it { expect(author).to validate_presence_of :firstname }
  it { expect(author).to validate_presence_of :lastname }
  it { expect(author).to have_and_belong_to_many :books }
end
