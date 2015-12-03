class Api::V1::FavoriteEventsController < ApplicationController

  # respond_to :json

  skip_before_action :verify_authenticity_token

  def create
    @favorite_event = FavoriteEvent.create(favorite_event_params)
  end

  def update
    @favorite_event = FavoriteEvent.find(favorite_event_params[:id]).destroy
  end

  def show
    @favorite_events = User.find(params[:id]).favorite_events
  end


  def favorite_event_params
    params.permit(:id, :user_id, :event_id)
  end
end