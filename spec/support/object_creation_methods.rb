def create_user(overrides = {})
  User.create!({
    first_name: 'Rick',
    last_name: 'Grimes',
    email: 'walkingdead@email.com',
    password: 'Karl!'
  }.merge(overrides))
end

def create_pokemon(overrides ={})
  Pokemon.create!({
    name: 'Charmander',
    species: 'Lizard'
  }.merge(overrides))
end

def create_trainer(overrides ={})
  Trainer.create!({
    name: 'Spartacus',
    country_of_origin: 'Thrace',
    date_of_birth: '1982-02-08'
  }.merge(overrides))
end

def create_pet(trainer, pokemon, overrides ={})
  Pet.create!({
    trainer_id: trainer.id,
    pokemon_id: pokemon.id,
    name: 'Blaze',
    experience_level: 15
  }.merge(overrides))
end
