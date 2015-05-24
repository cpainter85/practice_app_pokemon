class WelcomeController < ApplicationController
  skip_before_action :ensure_authenticated_user
  
  def index

  end
end
