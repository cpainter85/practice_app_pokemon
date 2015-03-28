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

    expect(page).to have_content 'List of Pokemon'
    expect(page).to have_content 'Charmander - Lizard Pokemon'
    expect(page).to have_content 'Tepig - Fire Pig Pokemon'

  end
end
