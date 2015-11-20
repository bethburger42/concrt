class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def create
    user = User.create user_params
    @curret_user = user
    redirect_to users
  end

  def new
    @user = User.new
  end

  def edit
  end

  def show
  end

  def update
  end

  def destroy
  end

  private

   def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
