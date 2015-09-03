class Api::V1::VenueCategoriesController < ApplicationController

  respond_to :json

  def index
    @venue_categories = VenueCategory.all
    @venues           = Venue.all
    @events           = Event.all
  end

end