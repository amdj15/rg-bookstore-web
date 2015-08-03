require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "have to show all books" do
      expect(Category).to receive(:all)
      get :index
    end

    it "render all template" do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe "GET #show" do
    let(:category) { FactoryGirl::create :category }

    it "returns http success" do
      get :show, id: category.id
      expect(response).to have_http_status(:success)
    end

    it "render show template" do
      get :show, id: category.id
      expect(response).to render_template(:show)
    end
  end
end
