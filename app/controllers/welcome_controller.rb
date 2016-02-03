class WelcomeController < ApplicationController
  def index
    if current_user
      redirect_to available_items_path
    end
  end
end
