class EventsController < ApplicationController
  def index
    @events = Event.all
  end

  def show
  end

  def new
    @events = Event.new
  end

  def create
    Event.create event_params
    redirect_to events_path
  end

  def destroy
  end
end
