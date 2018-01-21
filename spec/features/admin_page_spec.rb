require 'rails_helper'

feature 'Admin Page' do
  context 'a non-logged-in user' do
    scenario 'goes to Admin Page and redirects to admin login' do
      visit admin_root_path
      expect(current_path).to eq(new_user_session_path)
    end
  end

  context 'a non-admin logged-in-user' do
    scenario 'goes to Admin Page and redirects to admin login' do
      non_admin_user = create(:user)
      login_as non_admin_user
      visit admin_root_path
      expect(current_path).to eq(root_path)
    end
  end

  context 'an admin logged-in-user' do
    scenario 'goes to Admin Page' do
      admin_user = create(:user, superadmin: true)
      login_as admin_user
      visit admin_root_path
      expect(current_path).to eq(admin_root_path)
    end

    scenario 'can change the status of a show' do
      show = create(:show, status: :pending)
      admin_user = create(:user, superadmin: true)
      login_as admin_user
      visit shows_path
      expect(page).not_to have_text(show.title)
      visit edit_admin_show_path(show)
      select(:approved, from: 'show_status')
      click_on('Update Show')
      expect(current_path).to eq(admin_show_path(show))
      expect(page).to have_text('approved')

      visit shows_path
      expect(page).to have_text(show.title)
    end
  end
end
