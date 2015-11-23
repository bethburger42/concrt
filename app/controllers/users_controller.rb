class UsersController < ApplicationController
  def index
      if params[:search]
        @users = User.where('name LIKE ?', params[:search])
      else
        @users = User.all
      end
  end

  def create
    user = User.create user_params
    
    if(user)
      session[:user_id] = user.id
      flash[:success] = 'You have successfully logged in!'
      redirect_to user
    else
      flash[:danger] = 'Invalid email or password!'
      redirect_to root_path
    end
  end

  def new
    @user = User.new
  end

  def edit
  end

  def show
    @user = User.find params[:id]
  end

  def update
  end

  def destroy
    user = User.find(params[:id])
    user.events.clear
    user.delete
    redirect_to root_path
  end

  private

   def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
