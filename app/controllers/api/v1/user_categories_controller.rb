class Api::V1::UserCategoriesController < ApplicationController

  respond_to :json

  def index
    @user_categories  = UserCategory.all
  end

  def show
    @user_categories = User.find(params[:id]).user_categories

    p render json: @user_categories.to_json
  end



end