require 'rails_helper'

feature 'Users can CRUD Trainers' do
  before :each do
    user_sign_in(create_user)
    @trainer = create_trainer
    trainer2 = create_trainer(name: 'Don Draper', country_of_origin: 'USA', date_of_birth: '1971-03-10')
  end

  scenario 'Pokedex displays index of all trainers' do
    visit pokedex_path
    expect(page).to have_content 'List of Pokemon Trainers'
    expect(page).to have_content 'Spartacus of Thrace'
    expect(page).to have_content 'Don Draper of USA'
  end

  scenario 'user can add a new trainer with valid information' do
    visit pokedex_path
    click_link 'Add a new Pokemon Trainer to Pokedex'

    expect(current_path).to eq new_trainer_path
    expect(page).to have_content 'Add a new Pokemon Trainer'

    fill_in 'Name', with: 'Chewbacca'
    fill_in 'Country of origin', with: 'Kashyyyk'
    fill_in 'Date of birth', with: '1944-05-19'
    click_on 'Create Trainer'

    expect(current_path).to eq pokedex_path
    expect(page).to have_content 'New Pokemon Trainer Chewbacca added to Pokedex!'
    expect(page).to have_content 'Chewbacca of Kashyyyk'
  end

  scenario 'user cannot add a new trainer with invalid information' do
    visit new_trainer_path
    click_on 'Create Trainer'

    expect(page).to have_content 'Name can\'t be blank'
    expect(page).to have_content 'Name is too short (minimum is 3 characters)'
    expect(page).to have_content 'Country of origin can\'t be blank'
    expect(page).to have_content 'Date of birth can\'t be blank'
    expect(page).to have_no_content 'List of Pokemon Trainers'

  end
  scenario 'User can see show page for a trainer' do
    visit pokedex_path
    click_link 'Spartacus of Thrace'

    expect(current_path).to eq trainer_path(@trainer)
    expect(page).to have_content "Name: #{@trainer.name}"
    expect(page).to have_content "Country of Origin: #{@trainer.country_of_origin}"
    expect(page).to have_content "Date of birth: 02/08/1982"
    expect(find_link('Return to Pokedex')[:href]).to eq(pokedex_path)
    expect(find_link('Edit')[:href]).to eq(edit_trainer_path(@trainer))
    expect(find_link('Remove from Pokedex')[:href]).to eq(trainer_path(@trainer))
  end

  scenario 'User can update a Trainer with valid infromation' do
    visit trainer_path(@trainer)
    click_link 'Edit'
    expect(current_path).to eq edit_trainer_path(@trainer)
    expect(page).to have_content 'Edit Pokemon Trainer in Pokedex'

    fill_in 'Name', with: 'Crixus'
    fill_in 'Country of origin', with: 'Gallia'
    fill_in 'Date of birth', with: '1969-10-10'
    click_on 'Update Trainer'

    expect(current_path).to eq trainer_path(@trainer)
    expect(page).to have_content 'Updated Trainer information!'
    expect(page).to have_content "Name: Crixus"
    expect(page).to have_content "Country of Origin: Gallia"
    expect(page).to have_content "Date of birth: 10/10/1969"
    expect(page).to have_no_content "Name: #{@trainer.name}"
  end

  scenario 'User can delete a Trainer' do
    visit trainer_path(@trainer)
    click_link 'Remove from Pokedex'
    expect(current_path).to eq pokedex_path
    expect(page).to have_content "#{@trainer.name} has retired from Pokemon training"

    expect { @trainer.reload }.to raise_error ActiveRecord::RecordNotFound
  end
end

feature 'Unauthenticated users cannot CRUD Trainers' do
  scenario 'attempt to CRUD trainer by an unauthenticated user renders 404' do
    trainer = create_trainer

    paths = [pokedex_path, new_trainer_path, trainer_path(trainer), edit_trainer_path(trainer)]
    paths.each do |path|
      visit path
      expect(page.status_code).to eq(404)
    end
  end
end
