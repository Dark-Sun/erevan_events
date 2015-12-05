class Api::V1::VenueCategoriesController < ApplicationController

  respond_to :json

  def index
    @venue_categories = VenueCategory.with_deleted
    @venues           = Venue.with_deleted.includes(:venue_category)
    @events           = Event.with_deleted.upcoming.includes(:venue)
    @venue_photos     = VenuePhoto.all.includes(:venue)
    @user_categories  = UserCategory.all
  end

end