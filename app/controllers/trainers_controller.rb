class TrainersController < ApplicationController
  def new
    @trainer = Trainer.new
  end

  def create
    @trainer = Trainer.new(trainer_params)
    if @trainer.save
      redirect_to pokedex_path, notice: "New Pokemon Trainer #{@trainer.name} added to Pokedex!"
    else
      render :new
    end
  end

  def show
    @trainer = Trainer.find(params[:id])
  end

  def edit
    @trainer = Trainer.find(params[:id])
  end

  def update
    @trainer = Trainer.find(params[:id])
    if @trainer.update(trainer_params)
      redirect_to trainer_path(@trainer), notice: 'Updated Trainer information!'
    else
      render :edit
    end
  end

  def destroy
    trainer = Trainer.find(params[:id])
    trainer.destroy
    redirect_to pokedex_path, notice: "#{trainer.name} has retired from Pokemon training"
  end

  private

  def trainer_params
    params.require(:trainer).permit(:name, :country_of_origin, :date_of_birth)
  end
end
