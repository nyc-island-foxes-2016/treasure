class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
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
        format.html {redirect_to @user}
      end
    else
      render :new
    end
  end

    def update
      @user = User.find_by(id: params[:id])
      render :edit
    end


  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :avatar)
  end
end
