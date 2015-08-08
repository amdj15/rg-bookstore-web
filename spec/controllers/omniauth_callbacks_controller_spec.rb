require 'rails_helper'

RSpec.describe OmniauthCallbacksController, type: :controller do
  describe "GET #facebook" do
    xit "returns http success" do
      @request.env["devise.mapping"] = Devise.mappings[:omniauth_callbacks]

      get "facebook"
      # expect(response).to redirect_to root_path
    end
  end
end
