require 'rails_helper'

RSpec.describe Api::V1::RatingsController, type: :controller do
  let(:user) { create(:user) }
  let(:show) { create(:show) }

  describe 'POST create' do
    let(:params) do
      {
        show_id: show.id,
        rating: { score: 3, review: 'text' }
      }
    end

    describe 'with logged in user' do
      it "redirects to rating's show" do
        sign_in user
        post :create, params: params

        expect(response).to redirect_to(show)
      end
    end

    describe 'with non-logged in user' do
      it 'redirects to login' do
        post :create, params: params
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'PATCH update' do
    let(:rating) do
      show.ratings.create(score: 1, review: "doesn't matter", user: user)
    end

    let(:params) do
      {
        show_id: show.id,
        id: rating.id,
        rating: { score: 3, review: 'text' }
      }
    end

    describe 'with logged in user' do
      it "redirects to rating's show" do
        sign_in user

        patch :update, params: params

        expect(response).to redirect_to(show)
      end
    end

    describe 'with non-logged in user' do
      it 'redirects to login' do
        patch :update, params: params
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'DELETE destroy' do
    let(:rating) do
      show.ratings.create(score: 1, review: "doesn't matter", user: user)
    end

    let(:params) do
      {
        show_id: show.id,
        id: rating.id
      }
    end

    describe 'with logged in user' do
      it "redirects to rating's show" do
        sign_in user

        delete :destroy, params: params

        expect(response).to redirect_to(show)
      end
    end

    describe 'with non-logged in user' do
      it 'redirects to login' do
        delete :destroy, params: params
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
