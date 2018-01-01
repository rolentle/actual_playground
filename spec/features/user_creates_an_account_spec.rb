require 'rails_helper'

feature 'user signs up flow' do
  scenario 'signs up' do
    visit new_user_registration_path

    fill_in('Email', with: 'eeeeeeee@example.com')
    fill_in('First name', with: 'First Name')
    fill_in('Last name', with: 'Last Name')
    fill_in('Password', with: 'password')
    fill_in('Password confirmation', with: 'password')
    click_on('Sign up')

    expect(current_path).to eq(root_path)
  end
end
