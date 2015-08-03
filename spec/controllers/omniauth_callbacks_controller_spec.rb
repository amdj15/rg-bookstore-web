require 'rails_helper'

RSpec.describe OmniauthCallbacksController, type: :controller do
  describe "GET #facebook" do
    xit "returns http success" do
      get :facebook
      expect(response).to redirect_to root_path
    end
  end
end
