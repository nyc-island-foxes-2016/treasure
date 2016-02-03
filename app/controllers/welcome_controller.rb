class WelcomeController < ApplicationController
  skip_before_action :require_current_user, only: [:index]

  def index
    if current_user && current_user.items.first
      redirect_to available_items_path
    end
  end
end
