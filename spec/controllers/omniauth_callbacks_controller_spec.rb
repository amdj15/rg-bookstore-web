require 'rails_helper'

RSpec.describe OmniauthCallbacksController, type: :controller do

  describe "GET #facebook" do
    xit "returns http success" do
      get :facebook
      expect(response).to have_http_status(:success)
    end
  end

end
