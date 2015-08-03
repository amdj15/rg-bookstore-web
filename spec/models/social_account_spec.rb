require 'rails_helper'

RSpec.describe SocialAccount, type: :model do
  let(:social_account) { FactoryGirl::create :social_account }

  it { expect(social_account).to belong_to :customer }
end
