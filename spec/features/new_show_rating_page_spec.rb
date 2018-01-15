require 'rails_helper'

feature 'New Show Rating Page', js: true do
  context 'a non-logged-in user' do
    scenario 'gets redirect to login page' do
      show = create(:show)
      visit new_show_rating_path(show)
      expect(current_path).to eq(new_user_session_path)
    end
  end

  context 'a logged-in user' do
    before do
      user = create(:user)
      login_as user
    end

    scenario 'creates a new review and rating' do
      show = create(:show)
      visit new_show_rating_path(show)

      new_score = 3
      rate_show(new_score)
      review_text = 'review text'
      fill_in('user-review', with: review_text)
      click_on 'Submit'

      expect(current_path).to eq(show_path(show))
      expect(user_star_rating_score).to eq(new_score.to_s)
      expect(find('#user-review')).to have_text(review_text)
      expect(page).to have_text('Edit a review')
    end
  end
end
