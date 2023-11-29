class UsersController < ApplicationController
  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = "user successfully created"
      redirect_to user_path(@user)
    else
      flash[:error] = "Something went wrong"
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    # render json: 
  end
  
end


