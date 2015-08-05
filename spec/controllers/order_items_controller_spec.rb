require 'rails_helper'

RSpec.describe OrderItemsController, type: :controller do

  describe "POST #add" do
    xit "returns http success" do
      post :add
      expect(response).to have_http_status(:success)
    end
  end

  describe "DELETE #destroy" do
    xit "returns http success" do
      get :destroy
      expect(response).to have_http_status(:success)
    end
  end

end
