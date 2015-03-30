require 'rails_helper'

feature 'Users can CRUD Pokemon' do

  before :each do
    @pokemon = create_pokemon
    @pokemon2 = create_pokemon(name: 'Tepig', species: 'Fire Pig')
    @user = create_user
  end

  scenario 'Pokedex displays index of all pokemon' do
    user_sign_in(@user)
    visit pokedex_path

    expect(page).to have_content 'List of Pokemon in our Pokedex'
    expect(page).to have_content 'Charmander - Lizard Pokemon'
    expect(page).to have_content 'Tepig - Fire Pig Pokemon'

  end

  scenario 'user can add a new pokemon with valid information' do
    user_sign_in(@user)
    visit pokedex_path
    click_link 'Add a new Pokemon to Pokedex'

    expect(current_path).to eq new_pokemon_path
    expect(page).to have_content 'Add a new Pokemon to Pokedex'

    fill_in 'Name', with: 'Geodude'
    fill_in 'Species', with: 'Rock'
    click_on 'Create Pokemon'

    expect(current_path).to eq pokedex_path
    expect(page).to have_content 'New Pokemon Geodude added to Pokedex!'
    expect(page).to have_content 'Geodude - Rock Pokemon'
  end

  scenario 'user cannot add a new pokemon with invalid information' do
    user_sign_in(@user)
    visit pokedex_path
    click_link 'Add a new Pokemon to Pokedex'

    click_on 'Create Pokemon'
    expect(page).to have_content 'Name can\'t be blank'
    expect(page).to have_content 'Species can\'t be blank'
    expect(page).to have_content 'Species is too short (minimum is 3 characters)'
    expect(page).to have_no_content 'List of Pokemon in our Pokedex'
  end

  scenario 'User can see a show page for a pokemon' do
    user_sign_in(@user)
    visit pokedex_path

    click_link 'Charmander - Lizard Pokemon'

    expect(current_path).to eq pokemon_path(@pokemon)
    expect(page).to have_content 'Pokemon Name: Charmander'
    expect(page).to have_content 'Species: Lizard Pokemon'
    expect(find_link('Return to Pokedex')[:href]).to eq(pokedex_path)
    expect(find_link('Edit')[:href]).to eq(edit_pokemon_path(@pokemon))
    expect(find_link('Delete')[:href]).to eq(pokemon_path(@pokemon))
  end

  scenario 'User can update a Pokemon with valid information' do
    user_sign_in(@user)
    visit pokemon_path(@pokemon)
    click_link 'Edit'
    expect(current_path).to eq edit_pokemon_path(@pokemon)
    expect(page).to have_content 'Edit Pokemon Information in Pokedex'

    fill_in 'Name', with: 'Charmeleon'
    fill_in 'Species', with: 'Flame'
    click_on 'Update Pokemon'

    expect(current_path).to eq pokemon_path(@pokemon)
    expect(page).to have_content 'Updated Pokemon information!'
    expect(page).to have_content 'Pokemon Name: Charmeleon'
    expect(page).to have_content 'Species: Flame Pokemon'
  end
end
