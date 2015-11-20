require 'rest-client'

class EventsController < ApplicationController

  attr_accessor :name, :date, :locations, :artist

  # def index
  # @events = Event.all
  # end

  def index
    startDate = :datepicker_start_date
    endDate = :datepicker_end_date
    response = RestClient.get 'http://api.jambase.com/events?&apikey={ api key here } &startDate=#{startDate}&endDate=#{endDate}'
    @results = JSON.parse(response)['results']
  end


  def show
  end

  def new
    @events = Event.new

  end

  def create
    # if Songkick event id isn't already in database
    @event = Event.create event_params 
    @user = User.find(session[:user_id])
    @user.events << @event
    flash[:notice] = 'Event was saved.'

    redirect_to events_path
  end

    # Event.create event_params do |c|
    #   c.event_id = params[:event_id]
    #   c.user_id = @current_user.id
    #   c.save
    # end

  def destroy
    Event.find(params[:id]).delete
    redirect_to events_path
  end

  private

  def event_params
    params.require(:event).permit(:name, :date, :locations, :artist)
  end
end
