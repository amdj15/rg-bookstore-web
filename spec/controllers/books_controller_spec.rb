require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  let(:book) { FactoryGirl::create :book }
  let(:category) { FactoryGirl::create :category }

  describe "GET #all" do
    it "returns http success" do
      get :all
      expect(response).to have_http_status(:success)
    end

    it "have to show all books" do
      allow(Book).to receive_message_chain("all.includes")
      expect(Book).to receive(:all)

      get :all
    end

    it "render all template" do
      get :all
      expect(response).to render_template(:all)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, id: book.id, category_id: category.id
      expect(response).to have_http_status(:success)
    end

    it "render show template" do
      get :show, id: book.id, category_id: category.id
      expect(response).to render_template(:show)
    end
  end

  context "authorized user" do
    login_customer

    describe "GET #review" do
      it "returns http success" do
        get :review, id: book.id, category_id: category.id
        expect(response).to have_http_status(:success)
      end

      it "render review template" do
        get :review, id: book.id, category_id: category.id
        expect(response).to render_template(:review)
      end

      it "creat new rating instance" do
        get :review, id: book.id, category_id: category.id
        expect(assigns(:review)).to be_a_new Rating
      end
    end

    describe "POST #create_review" do
      def create_review
        post :create_review, id: book.id, category_id: category.id, rating: FactoryGirl.attributes_for(:rating)
      end

      it "creates a new Rating" do
        expect{
          create_review
        }.to change(Rating, :count).by(1)
      end

      it "redirect to book" do
        create_review

        expect(response).to redirect_to category_book_path(category, book)
      end
    end
  end
end
