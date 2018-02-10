require 'rails_helper'

feature 'Submit a Show', js: true do
  scenario 'As a non-logged-in user' do
    visit new_show_path
    expect(current_path).to eq(new_user_session_path)
  end

  context 'a logged-in user can submit a show' do
    scenario 'by hand' do
      skip "Add manually adding episode or campaign"
      user = create(:user)
      login_as user
      visit new_show_path
      expect(current_path).to eq(new_show_path)

      fill_in('Title', with: 'The Oracle Awakens')
      fill_in('Description', with: 'Kyvo, Hawthorn, Wysteria, and Uri')
      fill_in('Twitter username', with: 'OracleCast')
      fill_in('Creator', with: 'Strangers on The Internet')
      performer_group_selection_id = 'show_creator_type_performergroup'
      choose(performer_group_selection_id)
      VCR.use_cassette('protean_city') do
        fill_in('rss_feed', with: 'https://pinecast.com/feed/protean-city-comics')
        click_on('Upload')
      end

      expect(all('.episode').count).to eq(26)
      click_on('Submit')

      expect(current_path).to eq(shows_path)
      expect(page).to have_text('Thank you for submitting your show, we will notify you once it has been approved')
      expect(page).not_to have_text('The Oracle Awakens')
    end

    scenario 'by rss feed' do
      user = create(:user)
      login_as user
      visit new_show_path
      VCR.use_cassette('protean_city') do
        fill_in('rss_feed', with: 'https://pinecast.com/feed/protean-city-comics')
        click_on('Upload')
      end

      expect(all('.episode').count).to eq(26)

      expect(find("#show_title").value).to eq('Protean City Comics')
      expect(find("#show_description").value).to have_text('Protean City')
      expect(find("#creator_name").value).to eq('SHR Network')
    end
  end
end
