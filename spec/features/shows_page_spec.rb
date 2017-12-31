require 'rails_helper'

feature 'Shows page', js: true do
  scenario 'Shows are order by avg rarting' do
    unknown_show = create(:show)
    good_show = create(:show_with_high_ratings)
    ok_show = create(:show_with_ok_ratings)
    bad_show = create(:show_with_low_ratings)

    visit shows_path

    within('#shows') do
      expect(page.find('li:first-child')).to have_text(good_show.title)
      expect(page.find('li:first-child')).to have_text(good_show.avg_rating)
      expect(page.find('li:nth-child(2)')).to have_text(ok_show.title)
      expect(page.find('li:nth-child(2)')).to have_text(ok_show.avg_rating)
      expect(page.find('li:nth-child(3)')).to have_text(bad_show.title)
      expect(page.find('li:nth-child(3)')).to have_text(bad_show.avg_rating)
      expect(page.find('li:last-child')).to have_text(unknown_show.title)
      expect(page.find('li:last-child')).to have_text('Not yet rated')
    end
  end

  scenario 'Clicking on show title will take you to show details' do
    show = create(:show)

    visit shows_path
    click_on(show.title)

    expect(current_path).to eq show_path(show)
  end
end
