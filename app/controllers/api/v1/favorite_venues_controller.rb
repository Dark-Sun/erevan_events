class Api::V1::FavoriteVenuesController < ApplicationController

  skip_before_action :verify_authenticity_token

  def create
    p "-------"
    p favorite_venues_params
    p "--------"
    @favorite_venue = FavoriteVenue.create(favorite_venues_params)
    render :json => "{'id':" + @favorite_venue.id.to_s + ", 'venue_id':{'id':" + @favorite_venue.venue_id.to_s + "}}"
  end

  def update
    @favorite_event = FavoriteEvent.find(favorite_event_params[:id]).destroy
  
    render :json => "{'id':" + @favorite_event.id.to_s + ", 'event_id':{'id':" + @favorite_event.event_id.to_s + "}}"
  end

  def show
    @favorite_events = User.find(params[:id]).favorite_events
    result = "["
    @favorite_events.each do |i|
      result = result + "{'id':" + i.id.to_s + ", 'event_id':{'id':" + i.event_id.to_s + "}},"
    end
    result = result  + "]"
    render :json =>  result
  end


  def favorite_venues_params
    params.permit(:id, :user_id, :venue_id)
  end
end