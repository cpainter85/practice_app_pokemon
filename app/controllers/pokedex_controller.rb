class PokedexController < ApplicationController
  def index
    @pokemons = Pokemon.all
  end
end
