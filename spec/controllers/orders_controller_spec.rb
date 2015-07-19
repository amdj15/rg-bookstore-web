require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  describe "GET #index" do
    login_customer

    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end
end
