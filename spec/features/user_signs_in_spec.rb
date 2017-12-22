feature "user signs in" do
  before(:each) do
    @user = create(:user)
    @user.confirmed_at = Time.now
    @user.save
  end

  scenario "user logins in from the home page" do
    visit root_path

    expect(page).to have_text("Sign in")

    click_on("Sign in")

    fill_in "Email", with: @user.email
    fill_in "Password", with: @user.password
    click_on("Log in")

    expect(current_path).to eq(root_path)
  end

  scenario "username is on the home page" do
    login_as(@user, :scope => :user)

    visit root_path

    expect(page).to_not have_text("Sign in")
    expect(page).to have_text(@user.username)
  end
end
