class WelcomeController < ApplicationController
  def index
    if current_user && current_user.items.first
      redirect_to available_items_path
    end
  end
end
