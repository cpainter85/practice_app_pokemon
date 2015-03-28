require 'rails_helper'

describe Pokemon do
  before :each do
    @pokemon = create_pokemon
  end

  it 'validates the presence of a name' do
    @pokemon.update_attributes(name: nil)
    expect(@pokemon.errors.any?).to eq(true)
  end

  it 'validates the presence of a species' do
    @pokemon.update_attributes(species: nil)
    expect(@pokemon.errors.any?).to eq(true)
  end

  it 'validates that the name of a species is longer than 2 characters' do
    @pokemon.update_attributes(species: 'ha')
    expect(@pokemon.errors.any?).to eq(true)
  end
end
