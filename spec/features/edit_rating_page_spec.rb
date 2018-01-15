require 'rails_helper'

feature 'Edit Rating Page', js: true do
  context 'a non-logged-in user' do
    scenario 'gets redirect to login page' do
      rating = create(:rating)
      visit edit_rating_path(rating)
      expect(current_path).to eq(new_user_session_path)
    end
  end
  context 'an incorrect logged-in user' do
    scenario 'gets redirected to 404' do
      rating = create(:rating)
      wrong_user = create(:user)
      login_as wrong_user
      visit edit_rating_path(rating)
      expect(current_path).to eq(root_path)
    end
  end

  context 'the correct logged-in user' do
    let(:user) { create(:user) }
    let(:show) { create(:show) }
    let(:rating) { create(:rating, user: user, show: show) }
    let(:old_score) { rating.score }
    let(:old_review_text) { rating.review }
    before do
      login_as user
      visit edit_rating_path(rating)
    end

    scenario 'hits the edit rating page' do
      expect(current_path).to eq(edit_rating_path(rating))
    end

    scenario 'has original score and review' do
      expect(user_star_rating_score).to eq(old_score.to_s)
      expect(find('#user-review')).to have_text(old_review_text)
    end

    scenario 'updates score and review and shows on the shows page' do
      new_score = 5
      rate_show(new_score)
      new_review_text ='new review text'
      fill_in('user-review', with: new_review_text)
      click_on('Submit')

      expect(current_path).to eq(show_path(rating.show))
      expect(find('#user-review')).not_to have_text(old_review_text)
      expect(find('#user-review')).to have_text(new_review_text)
      expect(user_star_rating_score).not_to eq(old_score.to_s)
      expect(user_star_rating_score).to eq(new_score.to_s)
    end

    scenario 'updates only review and shows on the show page' do
      new_review_text ='new review text'
      fill_in('user-review', with: new_review_text)
      click_on('Submit')

      expect(current_path).to eq(show_path(rating.show))
      expect(find('#user-review')).not_to have_text(old_review_text)
      expect(find('#user-review')).to have_text(new_review_text)
      expect(user_star_rating_score).to eq(old_score.to_s)
    end
  end
end
