require 'rails_helper'

RSpec.describe AuthorsController, type: :controller do
  let(:author_params) { FactoryGirl::attributes_for(:author).stringify_keys }
  let(:author) { FactoryGirl::build_stubbed :author }

  describe "GET #show" do
    before do
      # Author.stub(:find).and_return author
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

    # it "render show template" do
    #   expect(response).to render_template(:show)
    #   get :show, id: author.id
    # end
  end
end
