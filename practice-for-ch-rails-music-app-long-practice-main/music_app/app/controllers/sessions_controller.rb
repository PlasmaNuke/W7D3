class SessionsController < ApplicationController
  def new
    render :new 
  end

  def create
    email = params[:user][:email]
    password = params[:user][:password]
    @user = User.find_by_credentials(email, password)
    if @user.save 
      # @user.reset_session_token
      # session[:session_token] = @user.session_token 
      redirect_to user_path(@user)
    else
      flash.now[:errors] = User.errors.full_messages 
      render :new
    end
  end
  
  def destroy 

  end
  
end