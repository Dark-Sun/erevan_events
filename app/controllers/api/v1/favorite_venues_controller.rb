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
  end


  def favorite_venues_params
    params.permit(:id, :user_id, :venue_id)
  end
end