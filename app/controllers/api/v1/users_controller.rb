class Api::V1::UsersController < ApplicationController

  respond_to :json

   skip_before_action :verify_authenticity_token

  def create
    @user = User.create(user_params)
    p render json: @user.to_json
  end

  def index
    @user = User.find_by_email(params[:email])
  end

  def user_params
    params.permit(:email, :phone, :name)
  end

end