require 'rails_helper'

describe Trainer do
  before :each do
    @trainer = create_trainer
  end

  it 'validates the presence of a name' do
    @trainer.update_attributes(name: nil)
    expect(@trainer.errors.any?).to eq(true)
  end

  it 'validates a name is at least 3 characters long' do
    @trainer.update_attributes(name: 'Oz')
    expect(@trainer.errors.any?).to eq(true)
  end

  it 'validates the presence of a country of origin' do
    @trainer.update_attributes(country_of_origin: nil)
    expect(@trainer.errors.any?).to eq(true)
  end

  it 'validates the presence of a date of birth' do
    @trainer.update_attributes(date_of_birth: nil)
    expect(@trainer.errors.any?).to eq(true)
  end

  it 'validates that the date of birth is not in the future' do
    @trainer.update_attributes(date_of_birth: 1.day.from_now)
    expect(@trainer.errors.any?).to eq(true)
  end
end
