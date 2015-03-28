class PokemonsController < ApplicationController
  def new
    @pokemon = Pokemon.new
  end

  def create
    @pokemon = Pokemon.new(pokemon_params)
    if @pokemon.save
      redirect_to dashboard_path, notice: "New Pokemon #{@pokemon.name} added to Pokedex!"
    else
      render :new
    end
  end

  private

  def pokemon_params
    params.require(:pokemon).permit(:name, :species)
  end
end
