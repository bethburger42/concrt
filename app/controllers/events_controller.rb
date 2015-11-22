require 'rest-client'
require 'json'

class EventsController < ApplicationController

  attr_accessor :name, :date, :locations, :artist, :zip, :datepicker_start_date, :datepicker_end_date

  def index
  # @events = Event.all
  end

  def results
    @events = Event.new
    @startDate = params[:datepicker_start_date]
    @endDate = params[:datepicker_end_date]
    @zipCode = params[:zip].to_i
    @jbkey = ENV['JAMBASE_API_KEY']

    puts @zipCode

    # WORKING CODE
    # response = RestClient.get "http://api.jambase.com/events", {:params => {:api_key => @jbkey, :o => 'json', :page => 0, :zipCode => @zipCode}}
    # @results = JSON.parse(response)
    # WORKING CODE

    # response = RestClient.get 'http://api.jambase.com/events', :params => {:apikey => @jbkey, :o => 'json', :page => 0, :zip => @zipCode, :startDate => @startDate, :endDate => @endDate}
    # @results = JSON.parse(response)['results']

    # puts "**********************"
    # puts @results
    # puts "**********************"
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
    flash[:notice] = 'Event was saved to your calendar!'

    # redirect_to events_path
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
    params.require(:event).permit(:name, :date, :location, :artist)
  end
end
