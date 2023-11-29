class SessionsController < ApplicationController
  before_action :require_logged_out, only: [:new, :create]
  before_action :require_logged_in, only: [:destroy]

  def new
    @user = User.new
    render :new 
  end

  def create
    email = params[:user][:email]
    password = params[:user][:password]
    @user = User.find_by_credentials(email, password)
    if @user
      login(user)
      # @user.reset_session_token
      # session[:session_token] = @user.session_token 
      redirect_to user_path(@user)
    else
      @user = user.new(email: email)
      flash.now[:errors] = ["Invalid Credentials"]
      render :new
    end
  end
  
  def destroy 
    logout!
    flash[:messages] = ["Successfully logged out"]
    redirect_to new_session_path
  end
  
end