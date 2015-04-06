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

  scenario 'User can see a show page for a particular pet pokemon' do
    visit trainer_path(@trainer)

    click_link 'Blaze - a Level 15 Charmander'

    expect(current_path).to eq trainer_pet_path(@trainer, @pet)
    expect(page).to have_content "#{@trainer.name}'s #{@pet.pokemon.name}"
    expect(page).to have_content "Name: #{@pet.name}"
    expect(page).to have_content "Experience Level: #{@pet.experience_level}"
    expect(find_link("Return to #{@trainer.name}'s Main Page'")[:href]).to eq(trainer_path(@trainer))
    expect(find_link('Edit')[:href]).to eq(edit_trainer_pet_path(@trainer, @pet))
    expect(find_link('Remove this Pokemon')[:href]).to eq(trainer_pet_path(@trainer, @pet))
  end

  scenario 'User can update a Pet Pokemon with valid information' do
    charmeleon = create_pokemon(name: 'Charmeleon', species: 'Flame')
    visit trainer_pet_path(@trainer, @pet)
    click_link 'Edit'
    expect(current_path).to eq edit_trainer_pet_path(@trainer, @pet)
    expect(page).to have_content "Edit #{@trainer.name}'s #{@pet.pokemon.name} #{@pet.name}"

    select('Charmeleon', from: 'Pokemon')
    fill_in 'Name', with: 'Torch'
    fill_in 'Experience level', with: 20
    click_on 'Update Pokemon'

    expect(current_path).to eq trainer_pet_path(@trainer, @pet)
    expect(page).to have_content "Updated #{@trainer.name}'s Charmeleon Torch!"
    expect(page).to have_content "#{@trainer.name}'s Charmeleon"
    expect(page).to have_content "Name: Torch"
    expect(page).to have_content "Experience Level: 20"
  end

  scenario 'User can delete a Pet Pokemon' do
    visit trainer_pet_path(@trainer, @pet)

    click_link 'Remove this Pokemon'
    expect(current_path).to eq trainer_path(@trainer)
    expect(page).to have_content "#{@trainer.name}'s #{@pet.pokemon.name} has been released back into the wild"

    expect { @pet.reload }.to raise_error ActiveRecord::RecordNotFound
  end
end

feature 'Unauthenticated users cannot CRUD pet pokemon' do
  scenario 'attempt to CRUD pokemon by an unauthenticated user renders 404' do
    trainer = create_trainer
    pokemon = create_pokemon
    pet = create_pet(trainer, pokemon)

    paths = [trainer_path(trainer), new_trainer_pet_path(trainer), trainer_pet_path(trainer, pet), edit_trainer_pet_path(trainer, pet)]
    paths.each do |path|
      visit path
      expect(page.status_code).to eq(404)
    end
  end
end
