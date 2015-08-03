require 'rails_helper'

RSpec.describe AuthorsController, type: :controller do
  let(:author_params) { FactoryGirl::attributes_for(:author).stringify_keys }
  let(:author) { FactoryGirl::build_stubbed :author }

  describe "GET #show" do
    before do
      allow(Author).to receive(:find).and_return author
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
      get :show, id: author.id
    end

    it "receive find and return author" do
      expect(Author).to receive(:find).with(author.id.to_s)
      get :show, id: author.id
    end

    it "render show template" do
      get :show, id: author.id
      expect(response).to render_template(:show)
    end
  end

  describe "GET #index" do
    it "render index template" do
      get :index
      expect(response).to render_template(:index)
    end

    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "resive all and return authors list" do
      expect(Author).to receive(:all).with(no_args)
      get :index
    end
  end
end
