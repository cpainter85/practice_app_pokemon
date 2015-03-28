require 'rails_helper'

describe User do

  before :each do
    @user = create_user
  end

  it 'validates the presence of a first name' do
    @user.update_attributes(first_name: nil)
    expect(@user.errors.any?).to eq(true)
  end

  it 'validates the presence of a last name' do
    @user.update_attributes(last_name: nil)
    expect(@user.errors.any?).to eq(true)
  end

  it 'validates the presence of an email' do
    @user.update_attributes(email: nil)
    expect(@user.errors.any?).to eq(true)
  end

  it 'validates the presence of a password' do
    @user.update_attributes(password: nil)
    expect(@user.errors.any?).to eq(true)
  end

  it 'validates the uniqueness of an email' do
    user2 = User.create(first_name: 'Daryl',
                      last_name: 'Dixon',
                      email: 'walkingdead@email.com',
                      password: 'killzombies')

    expect(user2.errors.any?).to eq(true)
  end

end
