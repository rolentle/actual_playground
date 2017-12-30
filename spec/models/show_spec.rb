require 'rails_helper'

RSpec.describe Show, type: :model do

  scenario ".by_avg_scores" do
    good_show = create(:show_with_high_ratings, title: 'good')
    bad_show = create(:show_with_low_ratings, title: 'bad')
    show_with_no_ratings = create(:show, title: 'Not Found')

    actual_shows = Show.by_avg_scores

    expect(actual_shows.length).to eq(3)
    expect(actual_shows.first).to eq(good_show)
    expect(actual_shows[1]).to eq(bad_show)
    expect(actual_shows.last).to eq(show_with_no_ratings)
  end

  scenario "#avg_rating" do
    ok_show = create(:show_with_ok_ratings)
    expect(ok_show.avg_rating).to eq(3)
  end

  scenario "#avg_rating without ratings" do
    show = create(:show)
    expect(show.avg_rating).to eq(nil)
  end
end
