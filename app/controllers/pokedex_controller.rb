class PokedexController < ApplicationController
  def index
    @pokemons = Pokemon.all
    @trainers = Trainer.all
  end
end
