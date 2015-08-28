class Api::V1::VenuesController < ApplicationController

  respond_to :json

  def index
    @venues = Venue.all
    # respond_to do |format|
    #   format.json { render json: @venues.to_json(inlude: [:event]) }
    # end
  end

end