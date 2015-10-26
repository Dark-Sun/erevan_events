class Api::V1::FavoriteVenuesController < ApplicationController

  skip_before_action :verify_authenticity_token

  def create
    @favorite_venue = FavoriteVenue.create(favorite_venues_params)
  end

  def update
    @favorite_venue = FavoriteVenue.find(favorite_venues_params[:id]).destroy
  end

  def show
    @favorite_venues = User.find(params[:id]).favorite_venues
    # result = "["
    # @favorite_venues.each do |i|
    #   result = result + "{'id':" + i.id.to_s + ", 'venue_id':{'id':" + i.venue_id.to_s + "}},"
    # end
    # result = result  + "]"
    # render :json =>  result
  end


  def favorite_venues_params
    params.permit(:id, :user_id, :venue_id)
  end
end