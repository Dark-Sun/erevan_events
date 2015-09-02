class Api::V1::VenueCategoriesController < ApplicationController

  respond_to :json

  def index
    @venue_categories = VenueCategory.all
    # respond_to do |format|
    #   format.json { render json: @venues.to_json(inlude: [:event]) }
    # end
  end

end