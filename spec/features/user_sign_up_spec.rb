require 'rails_helper'

feature 'User can signup' do
  scenario 'allow a user to sign up with valid credentials' do
    visit root_path

    expect(page).to have_content 'Welcome!'
    expect(page).to have_content 'Please sign up or sign in below'
    expect(page).to have_no_content 'Sign Out'

    click_link 'Sign Up'
    expect(current_path).to eq sign_up_path
    expect(page).to have_content 'Sign Up Page'

    fill_in 'First name', with: 'Walter'
    fill_in 'Last name', with: 'White'
    fill_in 'Email', with: 'breakingbad@email.com'
    fill_in 'Password', with: 'Heisenberg'
    fill_in 'Password confirmation', with: 'Heisenberg'
    click_button 'Sign Up'

    expect(current_path).to eq pokedex_path
    expect(page).to have_content 'You have successfully signed up!'
    expect(page).to have_content 'Current User: Walter White'
    expect(page).to have_content 'Sign Out'
  end

  scenario 'User cannot sign up with invalid credentials' do
    visit root_path
    click_link 'Sign Up'
    click_button 'Sign Up'

    expect(page).to have_no_content 'You have successfully signed up!'
    expect(page).to have_content 'First name can\'t be blank'
    expect(page).to have_content 'Last name can\'t be blank'
    expect(page).to have_content 'Email can\'t be blank'
    expect(page).to have_content 'Password can\'t be blank'
    expect(page).to have_no_content 'Sign Out'
  end

end
