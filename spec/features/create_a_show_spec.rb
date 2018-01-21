require 'rails_helper'

feature 'Submit a Show' do
  scenario 'As a non-logged-in user' do
    visit new_show_path
    expect(current_path).to eq(new_user_session_path)
  end

  scenario 'a logged-in user can submit a show' do
    user = create(:user)
    login_as user
    visit new_show_path
    expect(current_path).to eq(new_show_path)

    fill_in('Title', with: 'The Oracle Awakens')
    fill_in('Description', with: 'Kyvo, Hawthorn, Wysteria, and Uri')
    fill_in('Twitter username', with: 'OracleCast')
    click_on('Submit')

    expect(current_path).to eq(shows_path)
    expect(page).to have_text('Thank you for submitting your show, we will notify you once it has been approved')
    expect(page).not_to have_text('The Oracle Awakens')
  end
end
