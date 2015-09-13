class Api::V1::VenueCategoriesController < ApplicationController

  respond_to :json

  def index
    @venue_categories = VenueCategory.all
    @venues           = Venue.all
    @events           = Event.all
    @venue_photos     = VenuePhoto.all
  end

end