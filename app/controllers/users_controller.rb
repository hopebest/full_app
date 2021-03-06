class UsersController < ApplicationController
  def new
  	@user = User.new
  end

  def show
  	@user = User.find(params[:id])
  end

  def create
  	@user = User.new(users_params)
  	if @user.save
      log_in @user
      flash[:success] = "Welcome to the Full App!"
      redirect_to user_url(@user)
  	else 
  		render 'new'
  	end
  end

  private

  def users_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
