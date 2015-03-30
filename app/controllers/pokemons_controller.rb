class PokemonsController < ApplicationController
  def new
    @pokemon = Pokemon.new
  end

  def create
    @pokemon = Pokemon.new(pokemon_params)
    if @pokemon.save
      redirect_to pokedex_path, notice: "New Pokemon #{@pokemon.name} added to Pokedex!"
    else
      render :new
    end
  end

  def show
    @pokemon = Pokemon.find(params[:id])
  end

  def edit
    @pokemon = Pokemon.find(params[:id])
  end

  def update
    @pokemon = Pokemon.find(params[:id])
    if @pokemon.update(pokemon_params)
      redirect_to pokemon_path(@pokemon), notice: 'Updated Pokemon information!'
    else
      render :edit
    end
  end

  private

  def pokemon_params
    params.require(:pokemon).permit(:name, :species)
  end
end
