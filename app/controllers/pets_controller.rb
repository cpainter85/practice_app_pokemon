class PetsController < ApplicationController

  before_action do
    @trainer = Trainer.find(params[:trainer_id])
  end

  def new
    @pet = @trainer.pets.new
  end

  def create
    @pet = @trainer.pets.new(pet_params)
    if @pet.save
      redirect_to trainer_path(@trainer), notice: "Added a #{@pet.pokemon.name} named #{@pet.name} to #{@pet.trainer.name}'s team"
    else
      render :new
    end
  end

  private
  def pet_params
    params.require(:pet).permit(:name, :experience_level, :pokemon_id)
  end
end
