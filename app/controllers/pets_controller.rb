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

  def show
    @pet = @trainer.pets.find(params[:id])
  end

  def edit
    @pet = @trainer.pets.find(params[:id])
  end

  def update
    @pet = @trainer.pets.find(params[:id])
    if @pet.update(pet_params)
      redirect_to trainer_pet_path(@trainer, @pet), notice: "Updated #{@trainer.name}'s #{@pet.pokemon.name} #{@pet.name}!"
    else
      render :edit
    end
  end

  def destroy
    @pet = @trainer.pets.find(params[:id])
    @pet.destroy
    redirect_to trainer_path(@trainer), notice: "#{@trainer.name}'s #{@pet.pokemon.name} has been released back into the wild"
  end

  private
  def pet_params
    params.require(:pet).permit(:name, :experience_level, :pokemon_id)
  end
end
