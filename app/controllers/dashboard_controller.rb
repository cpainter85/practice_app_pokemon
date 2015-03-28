class DashboardController < ApplicationController
  def index
    @pokemons = Pokemon.all
  end
end
