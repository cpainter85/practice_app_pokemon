def create_user(overrides = {})
  User.create!({
    first_name: 'Rick',
    last_name: 'Grimes',
    email: 'walkingdead@email.com',
    password: 'Karl!'
  }.merge(overrides))
end
