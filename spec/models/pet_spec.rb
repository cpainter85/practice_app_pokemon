require 'rails_helper'

describe Pet do
  let(:trainer) { create_trainer }
  let(:pokemon) { create_pokemon }

  describe 'associations' do
    let(:pet) { create_pet(trainer, pokemon) }
    describe '#trainer' do
      it 'returns the trainer for a given pet' do
      expect(pet.trainer).to eq(trainer)
      end
    end
    describe '#pokemon' do
      it 'returns the pokemon for a given pet' do
        expect(pet.pokemon).to eq(pokemon)
      end
    end
  end

  describe 'validations' do
    before :each do
      @pet = create_pet(trainer, pokemon)
    end
    it 'validates the presence of a trainer' do
      @pet.update_attributes(trainer_id: nil)
      expect(@pet.errors.any?).to eq(true)
    end
    it 'validates the presence of a pokemon' do
      @pet.update_attributes(pokemon_id: nil)
      expect(@pet.errors.any?).to eq(true)
    end
    it 'validates the presence of a name' do
      @pet.update_attributes(name: nil)
      expect(@pet.errors.any?).to eq(true)
    end
    it 'validates the presence of an experience level' do
      @pet.update_attributes(experience_level: nil)
      expect(@pet.errors.any?).to eq(true)
    end
    it 'validates that the experience level is greater than 0' do
      @pet.update_attributes(experience_level: -1)
      expect(@pet.errors.any?).to eq(true)
    end
    it 'validates that the experience level is less than 51' do
      @pet.update_attributes(experience_level: 55)
      expect(@pet.errors.any?).to eq(true)
    end
  end
end
