require 'rails_helper'

feature 'User sign in' do
  scenario 'User can sign in with valid credentials' do
    user = create_user

    visit root_path
    click_link 'Sign In'
    expect(current_path).to eq sign_in_path
    expect(page).to have_content 'Sign In Page'

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'

    expect(current_path).to eq dashboard_path
    expect(page).to have_content 'You have successfully signed in!'
    expect(page).to have_content 'Current User: Rick Grimes'
    expect(page).to have_content 'Sign Out'
  end

  scenario 'User cannot sign in with invalid credentials' do
    visit root_path
    click_link 'Sign In'
    click_button 'Sign In'

    expect(current_path).to eq sign_in_path
    expect(page).to have_no_content 'You have successfully signed in!'
    expect(page).to have_no_content 'Sign Out'
    expect(page).to have_content 'Invalid User/Password combination'
  end
end
