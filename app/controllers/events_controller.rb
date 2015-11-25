require 'rest-client'
require 'json'

class EventsController < ApplicationController
  attr_accessor :event_id, :date, :locations, :artist, :zip, :datepicker_start_date, :datepicker_end_date

  def index
  # @events = Event.all
  end

  def results
    @events = Event.new
    @startDate = params[:datepicker_start_date].to_datetime
    @endDate = params[:datepicker_end_date].to_datetime
    @zipCode = params[:zip].to_i > 0 ? params[:zip].to_i : 98101
    @jbkey = ENV['JAMBASE_API_KEY']

    puts "****StartDate********"
    puts @startDate
    puts "****EndDate********"
    puts @endDate
    puts "****zipCode********"
    puts @zipCode

    response = RestClient.get "http://api.jambase.com/events", {:params => {:api_key => @jbkey, :o => 'json', :page => 0, :zipCode => @zipCode, :startDate => @startDate, :endDate => @endDate}}
    @results = JSON.parse(response)

    puts "**********************"
    puts @results
    puts "**********************"


  end

  def show

  end

  
  def new
    @events = Event.new
  end

  def create
    @user = User.find(session[:user_id])
    @event = Event.find_by(event_id: params[:event_id])

    # If Songkick event ID is already in database
    if @event
      @user.events << @event
    else
      @event = Event.create event_params 
      @user.events << @event
    end
    flash[:notice] = 'Event was saved to your calendar!'
    redirect_to events_path
  end

  def destroy
    Event.find(params[:id]).delete
    redirect_to events_path
  end


  private

  def event_params
    params.require(:event).permit(:event_id, :date, :location, :artist, :price)
  end
end

