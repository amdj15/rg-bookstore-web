require 'rails_helper'

RSpec.describe RatingsController, type: :controller do
  let(:category) { FactoryGirl::create :category_with_books }
  let(:rating) { FactoryGirl::create :rating }
  let(:customer) { FactoryGirl::create :customer }

  before do
    sign_in customer
  end

  describe "DELETE #destroy" do
    before do
      rating.customer = customer
      rating.save
    end

    it "returns http redirect" do
      delete :destroy, category_id: category.id, book_id: category.books[0].id, id: rating.id
      expect(response).to redirect_to category_book_path(category, category.books[0])
    end

    context "delete foreign rating" do
      let(:another_customer) { FactoryGirl::create :customer }

      before do
        rating.customer = another_customer
        rating.save
      end

      it "auth error" do
        expect do
          delete :destroy, category_id: category.id, book_id: category.books[0].id, id: rating.id
        end.to raise_error CanCan::AccessDenied
      end
    end

    context "delete comment not logged" do
      before do
        sign_out customer
      end

      it "auth error" do
        expect do
          delete :destroy, category_id: category.id, book_id: category.books[0].id, id: rating.id
        end.to raise_error CanCan::AccessDenied
      end
    end
  end
end
