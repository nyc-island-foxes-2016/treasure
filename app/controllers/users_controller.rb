class UsersController < ApplicationController
  # before_action for ownership
  def show
    @user = User.find(params[:id])
    if @user && @user == current_user
      @items = @user.items
    else
      render :file => "#{Rails.root}/public/404.html",  :status => 404
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      respond_to do |format|
        format.json {render json: @user}
        format.html {redirect_to new_item_path}
      end
    else
      render :new
    end
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:notice] = "Profile updated"
      redirect_to @user
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :avatar)
  end
end
