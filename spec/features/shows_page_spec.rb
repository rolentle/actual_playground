require 'rails_helper'

feature 'Shows page', js: true do
  scenario 'Shows are order by avg rarting' do
    good_show = create(:show_with_high_ratings)
    ok_show = create(:show_with_ok_ratings)
    bad_show = create(:show_with_low_ratings)
    unknown_show = create(:show)
    visit shows_path

    within('#shows') do
      shows = all('.ui.item')

      good_show_element = shows.first
      expect(good_show_element).to have_text(good_show.title)
      expect(good_show_element).to have_text(good_show.avg_rating)

      ok_show_element = shows[1]
      expect(ok_show_element).to have_text(ok_show.title)
      expect(ok_show_element).to have_text(ok_show.avg_rating)

      bad_show_element = shows[2]
      expect(bad_show_element).to have_text(bad_show.title)
      expect(bad_show_element).to have_text(bad_show.avg_rating)

      unknown_show_element = shows.last
      expect(unknown_show_element).to have_text(unknown_show.title)
      expect(unknown_show_element).to have_text('Not yet rated')
    end
  end

  scenario 'Clicking on show title will take you to show details' do
    show = create(:show)

    visit shows_path
    click_on(show.title)

    expect(current_path).to eq show_path(show)
  end
end
