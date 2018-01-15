require 'rails_helper'

feature 'Show Details', js: true do
  let(:show) { create(:show_with_high_ratings) }

  scenario 'has title, description, and image' do
    visit show_path(show)

    expect(page).to have_text(show.title)
    expect(page).to have_text(show.description)
    expect(page).to have_text(show.avg_rating)

    image_xpath = "//img[@src='#{show.image_url}']"
    expect(page).to have_xpath(image_xpath)

    show.ratings.each do |rating|
      expect(page).to have_text(rating.review)
    end
  end

  context 'a non-logged-in user' do
    scenario 'tries to rate and gets redirected' do
      visit show_path(show)
      rate_show
      expect(current_path).to eq(new_user_session_path)
    end

    scenario 'tries to write a review and gets redirected' do
      visit show_path(show)
      click_on('Add a review')
      expect(current_path).to eq(new_user_session_path)
    end
  end

  context 'a logged-in user' do
    let(:user) { create(:user) }
    before { login_as user }

    scenario 'rates' do
      visit show_path(show)

      expect(user_star_rating_score).to eq(nil)
      new_score = 3
      rate_show(new_score)
      expect(user_star_rating_score).to eq(new_score.to_s)
    end

    scenario "clicks on 'Add a review'" do
      visit show_path(show)
      click_on('Add a review')
      expect(current_path).to eq(new_show_rating_path(show))
    end

    scenario 'updates rating' do
      rating = create(:rating, show: show, user: user)
      visit show_path(show)

      expect(user_star_rating_score).to eq(rating.score.to_s)

      new_score = 3
      rate_show(new_score)
      sleep 1
      expect(user_star_rating_score).to eq(new_score.to_s)
    end

    scenario "has a review clicks on 'Edit a review'" do
      rating = create(:rating, show: show, user: user)
      visit show_path(show)

      click_on('Edit a review')
      expect(current_path).to eq(edit_rating_path(rating))
    end
  end
end
