class SessionsController < ApplicationController
  def new
    @user = User.new
    if request.xhr?
      render '_form', layout: false, locals: {user: @user}
    end
  end

  def create
    @user = User.find_by(email: params[:email], provider: 'SELF')
    if @user and @user.authenticate params[:password]
      session[:user_id] = @user.id
      respond_to do |format|
        format.json {render json: @user}
        format.html {redirect_to root_path}
      end
    else
      render :new
    end
  end

  def oauth_create
    @user = User.create_or_get_from_oauth(request.env['omniauth.auth'])
    if @user
      flash[:notice] = 'Login successful'
      session[:user_id] = @user.id
      redirect_to root_path
    else
      render :new
    end
  end

  def destroy
    session.clear
    redirect_to root_path
  end
end
