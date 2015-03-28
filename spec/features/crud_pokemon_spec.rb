require 'rails_helper'

feature 'Users can CRUD Pokemon' do

  before :each do
    @pokemon = create_pokemon
    @pokemon2 = create_pokemon(name: 'Tepig', species: 'Fire Pig')
    @user = create_user
  end

  scenario 'dashboard displays index of all pokemon' do
    user_sign_in(@user)
    visit dashboard_path

    expect(page).to have_content 'List of Pokemon in our Pokedex'
    expect(page).to have_content 'Charmander - Lizard Pokemon'
    expect(page).to have_content 'Tepig - Fire Pig Pokemon'

  end

  scenario 'user can add a new pokemon with valid information' do
    user_sign_in(@user)
    visit dashboard_path
    click_link 'Add a new Pokemon to Pokedex'

    expect(current_path).to eq new_pokemon_path
    expect(page).to have_content 'Add a new Pokemon to Pokedex'

    fill_in 'Name', with: 'Geodude'
    fill_in 'Species', with: 'Rock'
    click_on 'Create Pokemon'

    expect(current_path).to eq dashboard_path
    expect(page).to have_content 'New Pokemon Geodude added to Pokedex!'
    expect(page).to have_content 'Geodude - Rock Pokemon'
  end

  scenario 'user cannot add a new pokemon with invalid information' do
    user_sign_in(@user)
    visit dashboard_path
    click_link 'Add a new Pokemon to Pokedex'

    click_on 'Create Pokemon'
    expect(page).to have_content 'Name can\'t be blank'
    expect(page).to have_content 'Species can\'t be blank'
    expect(page).to have_content 'Species is too short (minimum is 3 characters)'
    expect(page).to have_no_content 'List of Pokemon in our Pokedex'
  end
end
