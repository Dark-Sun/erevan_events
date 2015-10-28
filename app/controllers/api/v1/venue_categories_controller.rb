class Api::V1::VenueCategoriesController < ApplicationController

  respond_to :json

  def index
    @venue_categories = VenueCategory.with_deleted
    @venues           = Venue.with_deleted
    @events           = Event.with_deleted.upcoming
    @venue_photos     = VenuePhoto.all
    @user_categories  = UserCategory.all
  end

end