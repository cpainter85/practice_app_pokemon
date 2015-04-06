require 'rails_helper'

feature 'Users can CRUD Pets' do
  before :each do
    @trainer = create_trainer
    @pokemon = create_pokemon
    @pet = create_pet(@trainer, @pokemon)
    user_sign_in(create_user)
  end

  scenario 'The Trainer\'s show page displays an index of all their pet Pokemon' do
    pokemon2 = create_pokemon(name: 'Tepig', species: 'Fire Pig')
    pet2 = create_pet(@trainer, pokemon2, name: 'Piglet', experience_level: 22)

    visit trainer_path(@trainer)
    expect(page).to have_content "List of #{@trainer.name}'s Pet Pokemon"
    expect(page).to have_content 'Blaze - a Level 15 Charmander'
    expect(page).to have_content 'Piglet - a Level 22 Tepig'

  end

  scenario 'User can add a new pet for a trainer' do
    pokemon3 = create_pokemon(name: 'Geodude', species: 'Rock')
    visit trainer_path(@trainer)
    click_link "Add a new Pet Pokemon to #{@trainer.name}'s team"

    expect(current_path).to eq new_trainer_pet_path(@trainer)
    expect(page).to have_content "Add a new Pet Pokemon to #{@trainer.name}'s team"
    select('Geodude', from: 'Pokemon')
    fill_in 'Name', with: 'Dwayne The Rock Johnson'
    fill_in 'Experience level', with: 25
    click_on 'Create Pet'

    expect(current_path).to eq trainer_path(@trainer)
    expect(page).to have_content "Added a Geodude named Dwayne The Rock Johnson to #{@pet.trainer.name}'s team"
    expect(page).to have_content 'Dwayne The Rock Johnson - a Level 25 Geodude'
  end
end
