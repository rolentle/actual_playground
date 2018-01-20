feature 'user signs in' do
  let(:user) { create(:user) }

  scenario 'user logins in from the home page' do
    visit root_path

    expect(page).to have_text('Sign in')

    click_on('Sign in')

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on('Log in')

    expect(current_path).to eq(root_path)
  end

  scenario 'username is on the home page' do
    login_as(user, scope: :user)

    visit root_path

    expect(page).to_not have_text('Sign in')
    expect(page).to have_text(user.username)
  end

  scenario 'logged-in user can sign out' do
    login_as(user, scope: :user)

    visit root_path
    click_on('Sign out')
  end
end
