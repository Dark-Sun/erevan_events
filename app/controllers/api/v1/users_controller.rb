class Api::V1::UsersController < ApplicationController

  respond_to :json

  def create
    @user = User.create(user_params)
    render json: @User.to_json
  end

  def index
    @user = User.find_by_email(params[:email])
  end

  def user_params
    params.require(:user)
          .permit(:email, :phone, :name)
  end

end