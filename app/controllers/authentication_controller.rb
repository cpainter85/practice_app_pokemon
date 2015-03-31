class AuthenticationController < ApplicationController
  skip_before_action :ensure_current_user

  def new

  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to pokedex_path, notice: 'You have successfully signed in!'
    else
      flash[:notice] = 'Invalid User/Password combination'
      render :new
    end
  end

  def destroy
    session.clear
    redirect_to root_path, notice: 'You have successfully signed out!'
  end
end
