class Api::V1::UserCategoriesController < ApplicationController

  respond_to :json

  def index
    @user_categories  = UserCategory.all
  end

end