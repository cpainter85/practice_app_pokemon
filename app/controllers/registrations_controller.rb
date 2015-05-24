class RegistrationsController < ApplicationController
  skip_before_action :ensure_authenticated_user
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(params.require(:user).permit(:first_name, :last_name, :email, :password))
    if @user.save
      session[:user_id] = @user.id
      redirect_to pokedex_path, notice: 'You have successfully signed up!'
    else
      render :new
    end
  end
end