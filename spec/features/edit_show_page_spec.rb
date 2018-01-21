require 'rails_helper'

feature 'Edit a Show' do
  scenario 'a non-logged-in user cannot edit a show' do
    show = create(:show, status: 'pending')
    visit edit_show_path(show)
    expect(current_path).to eq(new_user_session_path)
  end

  context 'if the show is pending' do
    scenario 'a logged-in user who did not submit the show cannot edit it' do
      user = create(:user)
      show = create(:show, status: 'pending', submitter: user)
      wrong_user = create(:user)
      login_as wrong_user

      visit edit_show_path(show)
      expect(current_path).to eq(root_path)
    end

    scenario 'the submitter can edit the show' do
      user = create(:user)
      show = create(:show, status: 'pending', submitter: user)
      login_as user
      visit edit_show_path(show)

      expect(current_path).to eq(edit_show_path(show))
    end
  end
end
