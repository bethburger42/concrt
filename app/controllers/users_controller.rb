class UsersController < ApplicationController
  def index
    search = params[:search]
      if search
        @users = User.where('lower(name) = ?', search.downcase)
      elsif search == nil
        @users = User.all
      end
  end

  def create
    user = User.create user_params
    
    if (params[:user][:picture])
      uploaded_path = params[:user][:picture].path
      cloud_file = Cloudinary::Uploader.upload(uploaded_path)
      user.cloud_id = cloud_file['public_id']

    else 
      user.cloud_id = 'no-user_sa25wv'
    end

    user.save
    
    if user
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
  
  def show
    require 'date'
    @user = User.find params[:id]
    @events = @user.events
    @friend = @user
    @friends = @user.friends
    @followers = Friendship.includes(:user).where(:friend_id => @user.id)
    
    today = Date.today
    year = today.year
    month = today.mon
    day = 01
    month_names = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    gon.month = month_names[month - 1]
    gon.year = year
    startDate = Date.new(year, month, day)
    week = startDate.wday == 0 ? startDate.cweek + 1 : startDate.cweek

    arr = Array.new(5) { Array.new(7) { {"date" => 0, "events" => []} } }

    for i in 1..5
      for j in 1..7
        if j == 1

          date = Date.commercial(year, week + i - 2, 7)
          arr[i-1][j-1]["date"] = (date.mon == month) ? date.mday : ''
          @events.each do |e|
            if e.date == date
              arr[i-1][j-1]["events"] << e
            end
          end

        else

          date = Date.commercial(year, week + i - 1, j - 1)
          arr[i-1][j-1]["date"] = (date.mon == month) ? date.mday : ''
          @events.each do |e|
            if e.date == date
              arr[i-1][j-1]["events"] << e
            end
          end

        end
      end
    end

      gon.weeks0 = arr[0].to_json
      gon.weeks1 = arr[1].to_json
      gon.weeks2 = arr[2].to_json
      gon.weeks3 = arr[3].to_json
      gon.weeks4 = arr[4].to_json

  end

  def update
    userParams = params.require(:user).permit(:name, :email, :cloud_id)
    u = User.find_by_id(@current_user.id)

    if (params[:user][:picture])
      uploaded_path = params[:user][:picture].path
      cloud_file = Cloudinary::Uploader.upload(uploaded_path)
      u.cloud_id = cloud_file['public_id']

    else 
      u.cloud_id = u.cloud_id
    end
    
    u.update_attributes(userParams)
    redirect_to '/users/' + @current_user.id.to_s
  end

  def edit
    @user = User.find params[:id]
    @users = User.all
  end

  def destroy
    user = User.find(params[:id])
    user.events.clear
    user.delete
    redirect_to root_path
  end

  def follow
    friendid = params[:user][:user_id]
    friend = User.find_by_id(friendid)
    friendship = Friendship.find_or_create_by(:user => @current_user, :friend => friend)
    flash[:success] = 'You are now following ' + friend.name + '!'
    redirect_to users_path
  end

  def remove

    user = User.find(params[:user_id])
    event = user.events.find(params[:event_id])

    # removes a specific event from a user's calendar (event stays in the db)
    user.events.delete(event)
    redirect_to '/users/' + @current_user.id.to_s

  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :cloud_id)
  end
end
