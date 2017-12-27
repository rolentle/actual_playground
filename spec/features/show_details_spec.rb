require 'rails_helper'

feature "Show Details", js: true do
  before(:each) do
    @show = create(:show_with_ratings)
  end

  def rate_and_review_show(review_text='test')
    fill_in("user-review", with: review_text)
    choose("user-rating", id: "user-rating_4", allow_label_click: true)
    click_on("user-submit")
  end

  scenario "has title, description, and image" do
    visit show_path(@show)

    expect(page).to have_text(@show.title)
    expect(page).to have_text(@show.description)

    image_xpath = "//img[@src='#{@show.image_url}']"
    expect(page).to have_xpath(image_xpath)

    expect(page).to have_text(@show.avg_rating)

    @show.ratings.each do |rating|
      expect(page).to have_text(rating.review)
    end
  end

  scenario "non-logged in user tries to review and rating and gets redirected" do
    visit show_path(@show)

    rate_and_review_show
    expect(current_path).to eq(new_user_session_path)
  end

  scenario "logged in user reviews and rates" do
    user = create(:user)

    login_as user
    visit show_path(@show)

    review_text = "Test Review"
    expect(page).to have_css("#user-rating-form")
    expect(page).not_to have_css("#user-rating")
    rate_and_review_show(review_text)

    expect(page).not_to have_css("#user-rating-form")
    within("#user-rating") do
      expect(page).to have_text(review_text)
    end

    within("#ratings") do
      expect(page).not_to have_text(user.username)
    end
  end

  def visit_show_with_user_rating(review_text)
    user = create(:user)
    login_as user

    @show.ratings.create(user: user, score: 1, review: review_text)

    visit show_path(@show)
  end

  scenario "logged in user edits existing review" do
    review_text = "Test Review"
    visit_show_with_user_rating(review_text)

    expect(page).not_to have_css("#user-rating-form")
    expect(page).to have_css("#user-rating")

    within("#user-rating") do
      click_on("edit")
    end

    expect(page).not_to have_css("#user-rating")
    expect(page).to have_css("#user-rating-form")

    new_review_text = "NEW DATA"
    rate_and_review_show(new_review_text)

    expect(page).not_to have_css("#user-rating-form")

    within("#user-rating") do
      expect(page).not_to have_text(review_text)
      expect(page).to have_text(new_review_text)
    end
  end

  scenario "logged in user deletes existing review" do
    review_text = "Test Review"
    visit_show_with_user_rating(review_text)
    within("#user-rating") do
      click_on("delete")
    end

    expect(page).not_to have_css("#user-rating")
    expect(page).not_to have_text(review_text)
    expect(page).to have_css("#user-rating-form")
  end
end
